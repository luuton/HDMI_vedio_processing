`timescale 1ns/1ps
module hdmi_loop
(
	input [3:0] key_in,

	input  sys_clk_p,
	input  sys_clk_n,
	inout hdmi_scl,
	inout hdmi_sda,
    output hdmi_nreset_v10,//兼容 HDMI 1.0 和 1.1 版本的复位
    output hdmi_nreset,  //兼容 HDMI 1.0 和 1.1 版本的复位
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

	// ---- RGMII PHY(以太网视频传输,并行输出通道) ----
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
// 200 MHz 时钟缓冲
//
// 校准 RGMII 输入延迟抽头的 IDELAYCTRL 需要 200 MHz
// 参考时钟,而板上唯一的来源正是这一对差分引脚。
//
// sys_pll 原本在内部自己实例化 IBUFDS(PRIM_SOURCE =
// Differential_clock_capable_pin)。在同一对 sys_clk_p/n 上再挂第二个 IBUFDS 是
// 不合法的 —— 一对时钟可用(clock-capable)引脚只能驱动一个输入缓冲,而
// Vivado 会在 IO placer 阶段报错:
//     [Place 30-602] IO port 'sys_clk_p' is driving multiple buffers
// 且没有任何 XDC 属性可以覆盖它。
//
// 所以这里只构建一次缓冲,并把 sys_pll 改为
// PRIM_SOURCE = No_buffer(见 tools/setup_eth_ip.tcl),让 clk_in1 直接
// 取自 BUFG 输出。必须用该设置重新生成 sys_pll ——
// 在完成之前,下面的实例无法 elaborate,因为生成的
// wrapper 仍然暴露 clk_in1_p / clk_in1_n 而不是 clk_in1。
//
// 也不能通过从 sys_pll 自身分频出 200 MHz 来规避这个问题:
// MMCM 的 VCO 是 742.5 MHz,742.5/200 不是整数,而 27/148.5/200
// 也不存在落在 MMCM 限制以下的公倍数。
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
	// 时钟输入端口 -- 已在上面缓冲
	.clk_in1(sys_clk_200m),
	// 时钟输出端口
	.clk_out1(clk_27m),
	.clk_out2(),
	// 状态与控制信号
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

// 去雾输出总线(由 u_haze_removal_top 驱动)。mode_cur 在它与
// 下面的直通旁路总线之间做选择。
wire        haze_vs   ;
wire        haze_hs   ;
wire        haze_de   ;
wire [23:0] haze_data ;

// ---- key_in[0] 模式选择:去雾(默认) <-> 直通旁路 ----
// key_in[0] 低电平有效;一次消抖后的按下翻转模式。新模式在
// vsync 下降沿(场边界)生效,因此一帧画面绝不会出现
// 一半直通、一半去雾的情况。
integer k;
reg          vin_vs_d[1:0];   // 旁路通路使用的原始视频 2 拍延迟
reg          vin_hs_d[1:0];
reg          vin_de_d[1:0];
reg  [23:0]  vin_data_d[1:0];

reg          key_r0, key_r1;      // 同步到 sys_vin_clk 的 2 级触发器
reg          key_db, key_db_prev; // 消抖后的电平及其前一拍的值
reg  [21:0]  key_cnt;
reg          mode_next, mode_cur; // 请求的模式(翻转)/ 已生效的模式
localparam   KEY_STABLE = 22'd2_200_000; // 在 148.5 MHz 下约 14.8 ms 消抖

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
        mode_next   <= 1'b0; // 0 = 去雾
        mode_cur    <= 1'b0;
    end
    else begin
        key_r0 <= key_in[0];
        key_r1 <= key_r0;                        // 同步到 sys_vin_clk
        // 消抖:只有电平保持 KEY_STABLE 个时钟不变时才接受变化
        if(key_r1 != key_db) begin
            if(key_cnt >= KEY_STABLE) begin
                key_db  <= key_r1;
                key_cnt <= 22'd0;
            end
            else key_cnt <= key_cnt + 22'd1;
        end
        else key_cnt <= 22'd0;
        key_db_prev <= key_db;

        // key_db 下降沿(按下)翻转请求的模式
        if(key_db_prev & ~key_db) mode_next <= ~mode_next;
        // 仅在帧边界生效
        if(vin_vs_d[0] & ~vin_vs) mode_cur  <= mode_next;
    end
end

// ---- key_in[2] 推送使能:消抖翻转,默认开启 ----
// 与 key_in[0] 相同的 2 级触发器 + KEY_STABLE 消抖,但翻转的是电平
// 而不是模式。
//
// push_db_p 被刻意初始化为 1'b0,尽管上电时按键处于释放状态
// (key_in[2] 低电平有效,所以释放时读到的是 1)。这样消抖器会
// 看到一次 0->1 变化并稳定到 1,那是一个*上升*沿 —— 而只有
// 下降沿才会翻转。若改为从 1'b1 开始,上电后的稳定过程就会与
// 一次按下无法区分,从而在首次启动时禁止推送。
//
// push_en 与 mode_cur 同理在帧边界生效:它只
// 门控 FIFO 写使能,因此在一帧中途改变它会让 FIFO 里留下
// 半个帧,且其首字节并不是该帧的第一个像素。
// 在 vsync 有效期间生效,意味着 video_to_eth 总是在新帧的
// 行边界上恢复。
//
// push_en 只门控写使能。它绝不能门控 FIFO 复位或
// 行计数器:否则会在禁用期间把陈旧字节滞留在 FIFO 中,
// 并让 mac_test 看到一个半空的帧。
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
        push_en        <= 1'b1;   // 默认开启
    end
    else begin
        push_r0 <= key_in[2];
        push_r1 <= push_r0;                      // 同步到 sys_vin_clk
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

// pre_frame_href 接的是 SiI9013 的 HSYNC 引脚(N18),它是水平消隐期内
// 的一个窄脉冲 —— 而不是行有效电平。它过去还被当作去雾链的
// 行门控,这让整条链形同虚设:在 1080p60(H 极性为正)下,
// 它在全部 1920 个有效像素期间都是低,于是 3x3 窗口被强制置零,
// 暗通道读到 0,t 饱和到 255,J 与 I 之差在
// 1 LSB 以内。现在 haze_removal_top 在内部用 clken 门控其数据通路,
// 这个输入只用来定位输出 HSYNC 脉冲的位置 —— 所以这里接
// HSYNC 脉冲是正确的。参见 haze_removal_top.v 中的 href_line 注释,以及
// tools/tb_haze_removal_top.v 中的复现用例。
haze_removal_top #(
    // 必须保持 0。Y_ENHANCE_ENABLE=1 分支是休眠且无人维护的分支:
    // 它把 Cb 接到 YCbCr2RGB 的 i_cr_data、把 Cr 接到 i_cb_data(Cb/Cr 接反),
    // 通过 8 位端口给 Y 加 50,于是 Y > 205 会回绕成接近全黑,还把
    // o_red/o_blue 落在 post_img[0+:8]/[16+:8] —— 这与设计的其余部分
    // 以及 video_to_eth 的字节序正好相反。readme.md 已经把这三条列在
    // "休眠分支未启用且未维护".
    //
    // 本工作区中它曾被短暂设为 1(HEAD 是 0,tools/tb_haze_removal_top.v
    // 驱动 0,已烧写的比特流也是 0 —— 来自 tools/out.avi_20260921_212043.311.jpg 的抓图
    // 与 Y_ENHANCE_ENABLE=0 的模型吻合到 3.9 LSB/plane,而正向渲染
    // =1 链路则偏差 48 LSB/plane)。若留在 1,下一次综合会悄悄变成
    // 这条已损坏的分支。
    .Y_ENHANCE_ENABLE (0    ),
    .PIC_WIDTH        (1920 ),// 每行像素数,必须等于有效视频宽度
    .WINDOW_PASSES    (3    ),// 暗通道 = 7x7(3 级级联的 3x3 运算)
    .MODIFICATION_VALUE(16'd218)// omega = 0.85;243 = 0.95 是 He 等人更暗的设置
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

// mode_cur = 0 -> 去雾(默认);1 -> 原始输入直接旁路。
// 之所以先放在内部 wire 上而不是直接赋给端口,是为了让
// 以太网通道取到的画面与 HDMI 输出显示的完全一致 ——
// 切换模式时两路输出同步切换,不需要第二个多路选择器来维持
// 同步。
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
// 以太网视频传输 -- 并行输出通道
//
// 1080p60 RGB888 被降采样为 960x540 RGB565(60 Hz 下每帧 1,036,800 字节
// = 62.2 MB/s,明显低于千兆链路承载的约 118 MB/s),并以
// UDP 包的形式从同一个 RGMII PHY 发往 192.168.0.3:8080。
//
// 这里没有任何东西位于 HDMI 通路上:上面的 vout_* 不受
// 推送是否使能、链路是否连通、FIFO 是否写满的影响。
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
    .GAP_FRAME     (11'd1000  ), // 表示“处于垂直消隐期”的 de 低电平时钟数
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

// 对 eth_line_pix_cnt / eth_line_idx / eth_kept_lines 以及
// eth_video_tx 的 *_dbg 输出的调试抽头被刻意留为不连接:板上没有
// 多余的封装引脚,Vivado 也会裁剪这些网络。要在板上观察它们,
// 请在 GUI 中添加 ILA,并按名称探测这些内部网络。
eth_video_tx #(
    // 540 x 1920 = 1,036,800 = 1350 x 768,正好整除,所以一帧是整数个
    // 包,帧边界处的 FIFO 复位不会丢弃任何数据。改动前请先看
    // eth_video_tx.v 中的参数注释。
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
