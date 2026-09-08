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
	output[23:0] vout_data
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
sys_pll sys_pll_i
 (
	// Clock in ports
	.clk_in1_p(sys_clk_p),
	.clk_in1_n(sys_clk_n),
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
assign vout_vs   = mode_cur ? vin_vs_d[1]   : haze_vs;
assign vout_hs   = mode_cur ? vin_hs_d[1]   : haze_hs;
assign vout_de   = mode_cur ? vin_de_d[1]   : haze_de;
assign vout_data = mode_cur ? vin_data_d[1] : haze_data;

endmodule
