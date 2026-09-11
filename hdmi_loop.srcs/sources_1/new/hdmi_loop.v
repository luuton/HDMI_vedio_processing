`timescale 1ns/1ps
module hdmi_loop
(
	input [3:0] key_in,

	input  sys_clk_p,
	input  sys_clk_n,
	inout hdmi_scl,
	inout hdmi_sda,
    output hdmi_nreset_v10,//HDMI reset compatibility for version 1.0 and 1.1
    output hdmi_nreset,  //HDMI reset compatibility for version 1.0 and 1.1
	output hdmi_in_nreset,
	input vin_clk,
	input vin_hs,
	input vin_vs,
	input vin_de,
	input[23:0] vin_data,

	output vout_clk,
	output vout_hs,
	output vout_vs,
	output vout_de,
	output[23:0] vout_data,

	// ---- RGMII PHY (video over Ethernet, parallel output channel) ----
	output [3:0] rgmii_txd,
	output       rgmii_txctl,
	output       rgmii_txc,
	input  [3:0] rgmii_rxd,
	input        rgmii_rxctl,
	input        rgmii_rxc,
	output       e_reset,
	output       e_mdc,
	inout        e_mdio
);

wire clk_27m;
wire rst_n;
wire locked;
wire sys_vin_clk;
assign vout_clk = sys_vin_clk;
assign rst_n = locked;
assign hdmi_nreset_v10 = locked;
assign hdmi_nreset = locked;
assign hdmi_in_nreset = locked;
IBUFG video_clock
(
.I(vin_clk),
.O(sys_vin_clk)
);

// ---------------------------------------------------------------------------
// 200 MHz clock buffering
//
// The IDELAYCTRL that calibrates the RGMII input delay taps needs a 200 MHz
// reference, and the only one on the board is this same differential pin pair.
//
// sys_pll used to instantiate its own IBUFDS internally (PRIM_SOURCE =
// Differential_clock_capable_pin). Hanging a second IBUFDS on sys_clk_p/n is
// illegal -- one clock-capable pin pair may drive exactly one input buffer, and
// Vivado fails at the IO placer with
//     [Place 30-602] IO port 'sys_clk_p' is driving multiple buffers
// with no XDC property able to override it.
//
// So the buffer is built here once and sys_pll is switched to
// PRIM_SOURCE = No_buffer (see tools/setup_eth_ip.tcl), taking clk_in1 directly
// from the BUFG output. Regenerating sys_pll with that setting is mandatory --
// until it is done the instance below will not elaborate, because the generated
// wrapper still exposes clk_in1_p / clk_in1_n instead of clk_in1.
//
// It is not possible to dodge this by deriving 200 MHz from sys_pll itself: the
// MMCM VCO is 742.5 MHz and 742.5/200 is not an integer, nor do 27/148.5/200
// have a common multiple that fits under the MMCM limit.
// ---------------------------------------------------------------------------
wire sys_clk_ibuf;
wire sys_clk_200m;

IBUFDS u_sys_clk_ibufds (
	.I  (sys_clk_p   ),
	.IB (sys_clk_n   ),
	.O  (sys_clk_ibuf)
);

BUFG u_sys_clk_bufg (
	.I (sys_clk_ibuf),
	.O (sys_clk_200m)
);

sys_pll sys_pll_i
 (
	// Clock in ports -- already buffered above
	.clk_in1(sys_clk_200m),
	// Clock out ports
	.clk_out1(clk_27m),
	.clk_out2(),
	// Status and control signals
	.reset(1'b0),
	.locked(locked)
 );
i2c_config i2c_config_m0(
	.rst(!rst_n),
	.clk(clk_27m),

	.error(),
	.done(),

	.i2c_scl(hdmi_scl),
	.i2c_sda(hdmi_sda)
);

// Dehaze output bus (driven by u_haze_removal_top). mode_cur selects between it and
// the direct bypass bus below.
wire        haze_vs   ;
wire        haze_hs   ;
wire        haze_de   ;
wire [23:0] haze_data ;

// ---- key_in[0] mode select: dehaze (default) <-> direct bypass ----
// key_in[0] is active low; one debounced press toggles the mode. The new mode is
// applied on the falling edge of vsync (frame boundary) so a frame is never shown
// half direct / half dehazed.
integer k;
reg          vin_vs_d[1:0];   // 2-cycle delay of raw video for the bypass path
reg          vin_hs_d[1:0];
reg          vin_de_d[1:0];
reg  [23:0]  vin_data_d[1:0];

reg          key_r0, key_r1;      // 2-FF synchronizer into sys_vin_clk
reg          key_db, key_db_prev; // debounced level and its previous value
reg  [21:0]  key_cnt;
reg          mode_next, mode_cur; // requested mode (toggle) / applied mode
localparam   KEY_STABLE = 22'd2_200_000; // ~14.8 ms debounce @ 148.5 MHz

always @(posedge sys_vin_clk or negedge locked) begin
    if(!locked) begin
        for(k = 0; k < 2; k = k + 1) begin
            vin_vs_d[k]  <= 1'b0;
            vin_hs_d[k]  <= 1'b0;
            vin_de_d[k]  <= 1'b0;
            vin_data_d[k]<= 24'd0;
        end
    end
    else begin
        vin_vs_d[0]   <= vin_vs;
        vin_hs_d[0]   <= vin_hs;
        vin_de_d[0]   <= vin_de;
        vin_data_d[0] <= vin_data;
        vin_vs_d[1]   <= vin_vs_d[0];
        vin_hs_d[1]   <= vin_hs_d[0];
        vin_de_d[1]   <= vin_de_d[0];
        vin_data_d[1] <= vin_data_d[0];
    end
end

always @(posedge sys_vin_clk or negedge locked) begin
    if(!locked) begin
        key_r0      <= 1'b1;
        key_r1      <= 1'b1;
        key_db      <= 1'b1;
        key_db_prev <= 1'b1;
        key_cnt     <= 22'd0;
        mode_next   <= 1'b0; // 0 = dehaze
        mode_cur    <= 1'b0;
    end
    else begin
        key_r0 <= key_in[0];
        key_r1 <= key_r0;                        // synchronize to sys_vin_clk
        // debounce: accept a change only when it stays stable for KEY_STABLE clocks
        if(key_r1 != key_db) begin
            if(key_cnt >= KEY_STABLE) begin
                key_db  <= key_r1;
                key_cnt <= 22'd0;
            end
            else key_cnt <= key_cnt + 22'd1;
        end
        else key_cnt <= 22'd0;
        key_db_prev <= key_db;

        // key_db falling edge (press) toggles the requested mode
        if(key_db_prev & ~key_db) mode_next <= ~mode_next;
        // apply at frame boundary only
        if(vin_vs_d[0] & ~vin_vs) mode_cur  <= mode_next;
    end
end

// ---- key_in[2] push enable: debounced toggle, default ON ----
// Same 2-FF + KEY_STABLE debounce as key_in[0], but toggling a level instead of
// a mode.
//
// push_db_p is deliberately initialised to 1'b0 although the button is released
// at power-up (key_in[2] low-active, so released reads 1). The debouncer then
// sees a 0->1 change and settles to 1, which is a *rising* edge -- and only a
// falling edge toggles. Starting it at 1'b1 instead would make the power-up
// settle indistinguishable from a press and disable pushing on the first boot.
//
// push_en is applied at the frame boundary for the same reason mode_cur is: it
// gates only the FIFO write enable, so changing it mid-frame would leave a
// partial frame in the FIFO whose first byte is not the frame's first pixel.
// Applying it while vsync is active means video_to_eth always resumes on a line
// boundary of the new frame.
//
// push_en gates the write enable only. It must NOT gate the FIFO reset or the
// line counters: doing so would strand stale bytes in the FIFO across a disable
// window and let mac_test see a half-empty frame.
reg          push_r0, push_r1;
reg          push_db_p, push_db_p_prev;
reg  [21:0]  push_cnt;
reg          push_req, push_en;

always @(posedge sys_vin_clk or negedge locked) begin
    if(!locked) begin
        push_r0        <= 1'b1;
        push_r1        <= 1'b1;
        push_db_p      <= 1'b0;
        push_db_p_prev <= 1'b0;
        push_cnt       <= 22'd0;
        push_req       <= 1'b1;
        push_en        <= 1'b1;   // default on
    end
    else begin
        push_r0 <= key_in[2];
        push_r1 <= push_r0;                      // synchronize to sys_vin_clk
        if(push_r1 != push_db_p) begin
            if(push_cnt >= KEY_STABLE) begin
                push_db_p <= push_r1;
                push_cnt  <= 22'd0;
            end
            else push_cnt <= push_cnt + 22'd1;
        end
        else push_cnt <= 22'd0;
        push_db_p_prev <= push_db_p;

        if(push_db_p_prev & ~push_db_p) push_req <= ~push_req;
        if(vin_vs_d[0] & ~vin_vs)       push_en  <= push_req;
    end
end

haze_removal_top #(
    .Y_ENHANCE_ENABLE (0    ), // 1 = enable Y-channel +50 brightness enhancement
    .PIC_WIDTH        (1920 ) // pixels per line, must equal active video width
) u_haze_removal_top(
    .clk               (sys_vin_clk ),
    .rst_n             (locked      ),
    .pre_frame_vsync   (vin_vs      ),
    .pre_frame_href    (vin_hs      ),
    .pre_frame_clken   (vin_de      ),
    .pre_img           (vin_data    ),
    .post_frame_vsync  (haze_vs     ),
    .post_frame_href   (haze_hs     ),
    .post_frame_clken  (haze_de     ),
    .post_img          (haze_data   )
);

// mode_cur = 0 -> dehaze (default); 1 -> direct bypass of the raw input.
// Held in internal wires rather than assigned straight to the ports so the
// Ethernet channel taps exactly the picture the HDMI output is showing --
// switching modes switches both outputs together, with no second mux to keep in
// sync.
wire        vout_vs_int  ;
wire        vout_hs_int  ;
wire        vout_de_int  ;
wire [23:0] vout_data_int;

assign vout_vs_int   = mode_cur ? vin_vs_d[1]   : haze_vs;
assign vout_hs_int   = mode_cur ? vin_hs_d[1]   : haze_hs;
assign vout_de_int   = mode_cur ? vin_de_d[1]   : haze_de;
assign vout_data_int = mode_cur ? vin_data_d[1] : haze_data;

assign vout_vs       = vout_vs_int  ;
assign vout_hs       = vout_hs_int  ;
assign vout_de       = vout_de_int  ;
assign vout_data     = vout_data_int;

// ---------------------------------------------------------------------------
// Video over Ethernet -- parallel output channel
//
// 1080p60 RGB888 is decimated to 960x540 RGB565 (1,036,800 bytes/frame at 60 Hz
// = 62.2 MB/s, comfortably under the ~118 MB/s a gigabit link carries) and
// pushed out of the same RGMII PHY as UDP packets to 192.168.0.3:8080.
//
// Nothing here is in the HDMI path: vout_* above is unaffected by whether
// pushing is enabled, whether the link is up, or whether the FIFO is full.
// ---------------------------------------------------------------------------
wire        eth_wr_en       ;
wire [7:0]  eth_data        ;
wire        eth_vsync       ;
wire        eth_href        ;
wire [11:0] eth_line_pix_cnt;
wire [10:0] eth_line_idx    ;
wire [10:0] eth_kept_lines  ;
wire        eth_fifo_wr_ready;

video_to_eth #(
    .H_ACTIVE_PIX  (1920      ),
    .V_ACTIVE_LINE (1080      ),
    .GAP_FRAME     (11'd1000  ), // de-low clocks that mean "in vertical blanking"
    .HREF_HOLD     (4'd8      )
) u_video_to_eth (
    .clk          (sys_vin_clk      ),
    .rst_n        (locked           ),
    .vin_de       (vout_de_int      ),
    .vin_data     (vout_data_int    ),
    .push_en      (push_en          ),
    .wr_ready     (eth_fifo_wr_ready),
    .eth_wr_en    (eth_wr_en        ),
    .eth_data     (eth_data         ),
    .eth_vsync    (eth_vsync        ),
    .eth_href     (eth_href         ),
    .line_pix_cnt (eth_line_pix_cnt ),
    .line_idx     (eth_line_idx     ),
    .kept_lines   (eth_kept_lines   )
);

// Debug taps on eth_line_pix_cnt / eth_line_idx / eth_kept_lines and on the
// eth_video_tx *_dbg outputs are intentionally left unconnected: there are no
// spare package pins, and Vivado trims these nets. To watch them on the board,
// add an ILA in the GUI and probe the internal nets by name.
eth_video_tx #(
    // 540 x 1920 = 1,036,800 = 1350 x 768 exactly, so a frame is a whole number
    // of packets and the frame-boundary FIFO reset discards nothing. See the
    // parameter comment in eth_video_tx.v before changing this.
    .UDP_SEND_LEN (16'd768)
) u_eth_video_tx (
    .clk_200m          (sys_clk_200m      ),
    .locked            (locked            ),
    .rgmii_txd         (rgmii_txd         ),
    .rgmii_txctl       (rgmii_txctl       ),
    .rgmii_txc         (rgmii_txc         ),
    .rgmii_rxd         (rgmii_rxd         ),
    .rgmii_rxctl       (rgmii_rxctl       ),
    .rgmii_rxc         (rgmii_rxc         ),
    .e_reset           (e_reset           ),
    .e_mdc             (e_mdc             ),
    .e_mdio            (e_mdio            ),
    .vin_clk           (sys_vin_clk       ),
    .vin_rst_n         (locked            ),
    .eth_vsync_in      (eth_vsync         ),
    .eth_href_in       (eth_href          ),
    .eth_wr_en_in      (eth_wr_en         ),
    .eth_data_in       (eth_data          ),
    .fifo_wr_ready     (eth_fifo_wr_ready ),
    .idelay_rdy_dbg    (                  ),
    .mac_sending_dbg   (                  ),
    .mac_not_exist_dbg (                  ),
    .arp_found_dbg     (                  ),
    .fifo_full_dbg     (                  ),
    .fifo_cnt_dbg      (                  ),
    .eth_rst_n_dbg     (                  )
);

endmodule
