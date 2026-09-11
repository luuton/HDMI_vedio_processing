`timescale 1ns/1ps
//////////////////////////////////////////////////////////////////////////////////////
// 模块名 : eth_video_tx
// 说明   : 把 video_to_eth 的字节流接到 RGMII PHY 上。
//
//          IDELAYCTRL + util_gmii_to_rgmii + camera_fifo + mac_test,再加上参考
//          工程里没有的"帧边界 FIFO 复位控制器"。
//////////////////////////////////////////////////////////////////////////////////////
//
// 时钟域
//   clk_200m      - IDELAYCTRL 参考时钟。来自板子上差分 200 MHz 时钟的 IBUFDS+BUFG,
//                   **不是** sys_pll 出来的(见顶层 PRIM_SOURCE 处的说明)。
//   vin_clk       - 148.5 MHz 视频时钟。FIFO 写侧、video_to_eth。
//   gmii_rx_clk   - 125 MHz RGMII 接收时钟(rgmii_rxc)。本模块里的所有逻辑都在这个
//                   域:FIFO 读侧、mac_test,以及 gmii_tx_clk(util_gmii_to_rgmii 内部
//                   是把 gmii_tx_clk 直接接成 gmii_rx_clk)。
//
// 复位链
//   locked -> reset(clk_200m 上 335 ms 计数器)-> phy_rst_n -> e_reset(PHY)
//   phy_rst_n & IDELAYCTRL.RDY -> gmii_rx_clk 上三级同步器 -> eth_rst_n
//
//   IDELAYCTRL.RDY 必须参与"何时释放复位"。参考工程把 RDY 悬空、RST 直接接 0,于是
//   如果 200 MHz 时钟还没稳,IDELAY 的抽头就没校准,将**永远收不到任何包**——ARP
//   就是死活不成功,而且看不出任何原因。
//
//   复位**刻意不**由 gmii_rx_clk 推导:如果复位要等 RX 时钟,而 PHY 在复位期间又不
//   给 RXC,整个设计就死锁了。phy_rst_n 来自 clk_200m,所以 RXC 不出现时 eth_rst_n
//   就一直是低,自然不会卡住。
//
// 帧边界 FIFO 复位(取代参考工程里的 异步 rst = cmos_vsync)
//   参考工程直接用视频 vsync 复位 FIFO,而它相对于读侧是异步的。这会出两个问题:
//   FIFO 里还剩的东西被悄悄丢掉,于是每一帧落下来都带一个随机的水平偏移;以及如果
//   读指针被拽回 0 的那一刻 MAC 正好在发包中,那个包的中间就会混进垃圾字节。
//
//   本设计的做法:在同步后的 vsync 边沿上停写,等 MAC 空闲、且剩下的不足一个载荷,
//   再复位,等 wr_rst_busy 和 rd_rst_busy 都落下,然后重新放行写入端。这样
//   "复位后写入的第一个字节就是这一帧的第一个字节"是**由构造保证**的。场消隐有
//   666 us,而 FIFO 最多只存 4 KB,所以排空用不了 40 us。
//
//   又因为 UDP_SEND_LEN 能整除帧长,"剩下不足一个载荷"实际上通常就是**正好剩 0**,
//   所以复位不会丢任何东西,一帧 1,036,800 字节完整地到达 PC。
//
// 跨时钟域信号
//   只有电平跨界,绝不放单拍脉冲:视频侧一个 6.7 ns 的脉冲比 125 MHz 的一个周期还
//   短,会被整个漏掉。eth_vsync 和 eth_href 都是电平,而且各自在使用前都过一遍 2 级
//   同步器——送给 mac_test 之前也一样,这一点正是参考工程做错的地方(它出问题的路径
//   是 cmos_href_d0_reg/D)。

module eth_video_tx #(
    // UDP 载荷字节数。768 不是随便取的——它保证一帧正好是整数个包:
    //
    //     540 行 x 1920 字节 = 1,036,800 = 1350 x 768   (整除)
    //
    // 这一点很要紧,因为一个包只在凑满一个载荷时才发得出去,所以帧尾多出来的
    // 那点字节永远发不出去、只能被 FIFO 复位丢掉——那会是每一帧都固定的短尾巴,
    // 每帧到 PC 都少几百字节。
    // 用 768 时排空正好停在 0,什么都不丢。
    //
    // 1024 这个看起来很自然的选择**不能**整除 1,036,800(余 512)。
    // 512 能整除(2025 个包),但包头开销更大,而且把数据报速率推到约 121k/s,
    // 对接收端的套接字来说太重了。
    // 768 给出 1350 包/帧、约 81k 数据报/秒,链路效率 93%。
    parameter [15:0] UDP_SEND_LEN = 16'd768
)(
    // ---- 200 MHz IDELAYCTRL 参考时钟,顶层 IBUFDS+BUFG 送进来
    input               clk_200m,
    input               locked,          // PLL 锁定,高有效

    // ---- RGMII 引脚
    output      [3:0]   rgmii_txd,
    output              rgmii_txctl,
    output              rgmii_txc,
    input       [3:0]   rgmii_rxd,
    input               rgmii_rxctl,
    input               rgmii_rxc,
    output              e_reset,         // PHY 复位,335 ms 之后拉高
    output              e_mdc,
    inout               e_mdio,

    // ---- 视频域字节流(来自 video_to_eth)
    // 这里不需要 push_en:video_to_eth 已经用它门控过 eth_wr_en_in 了。
    input               vin_clk,
    input               vin_rst_n,
    input               eth_vsync_in,    // 电平,整个场消隐期间为高
    input               eth_href_in,     // 电平,每个保留行一个脉冲
    input               eth_wr_en_in,
    input       [7:0]   eth_data_in,
    output              fifo_wr_ready,   // 回给 video_to_eth

    // ---- 调试 / ILA
    output              idelay_rdy_dbg,
    output              mac_sending_dbg,
    output              mac_not_exist_dbg,
    output              arp_found_dbg,
    output              fifo_full_dbg,
    output      [11:0]  fifo_cnt_dbg,
    output              eth_rst_n_dbg
);

// ============================================================ 200 MHz 时钟域
// IDELAYCTRL 必须和 util_gmii_to_rgmii 里的 IDELAYE2/ODELAYE2 处在同一个
// IODELAY_GROUP 里,否则工具会拒绝 IDELAY 的布局。
wire idelay_rdy;
(* IODELAY_GROUP = "rgmii_idelay_group" *)
IDELAYCTRL u_idelayctrl (
    .RDY    (idelay_rdy),
    .REFCLK (clk_200m ),
    .RST    (~locked  )
);
assign idelay_rdy_dbg = idelay_rdy;

// 335 ms 上电复位,以 PLL 锁定为放行条件。
wire phy_rst_n;
reset u_reset (
    .clk   (clk_200m ),
    .key1  (locked   ),
    .rst_n (phy_rst_n)
);
assign e_reset = phy_rst_n;

// MDIO 没有实现(参考工程里也把 miim_top 注释掉了)。PHY 直接用上电默认配置:千兆、
// 全双工。把 MDC 驱低、MDIO 置成高阻,而不是让引脚悬空。
assign e_mdc  = 1'b0;
assign e_mdio = 1'bz;

// ======================================================== RGMII <-> GMII
wire [7:0]  gmii_txd;
wire        gmii_tx_en;
wire        gmii_tx_er;
wire        gmii_tx_clk;
wire        gmii_crs;
wire        gmii_col;
wire [7:0]  gmii_rxd;
wire        gmii_rx_dv;
wire        gmii_rx_er;
wire        gmii_rx_clk;

// =========================================================== gmii_rx_clk 时钟域
// 复位:异步置位、同步释放。rst_async_n **不**依赖 gmii_rx_clk,所以即使 PHY 在复位
// 期间不给 RXC 也不会死锁。
wire rst_async_n = locked & phy_rst_n & idelay_rdy;

reg [2:0] eth_rst_sync;
always @(posedge gmii_rx_clk or negedge rst_async_n) begin
    if(!rst_async_n) eth_rst_sync <= 3'b000;
    else             eth_rst_sync <= {eth_rst_sync[1:0], 1'b1};
end
wire eth_rst_n = eth_rst_sync[2];
assign eth_rst_n_dbg = eth_rst_n;

// ------------------------------------------------ 电平同步器(2 级触发器)
reg vs_d0, vs_d1, vs_d2;
reg href_d0, href_d1, href_d2;

always @(posedge gmii_rx_clk or negedge eth_rst_n) begin
    if(!eth_rst_n) begin
        vs_d0 <= 1'b0; vs_d1 <= 1'b0; vs_d2 <= 1'b0;
        href_d0 <= 1'b0; href_d1 <= 1'b0; href_d2 <= 1'b0;
    end
    else begin
        vs_d0   <= eth_vsync_in;
        vs_d1   <= vs_d0;
        vs_d2   <= vs_d1;
        href_d0 <= eth_href_in;
        href_d1 <= href_d0;
        href_d2 <= href_d1;
    end
end

// d1 比 d2 新,所以这就是同步后电平的上升沿。
wire vs_rise = vs_d1 & ~vs_d2;

// -------------------------------------------------------------------- FIFO
wire [7:0]  fifo_data;
wire        fifo_rd_en;
wire        fifo_full;
wire        fifo_empty;
wire [11:0] fifo_rdusedw;
wire        wr_rst_busy;
wire        rd_rst_busy;
wire        mac_sending;
wire        mac_not_exist;
wire        arp_found;

// ------------------------------------------------- 帧边界复位状态机
localparam [1:0] F_IDLE  = 2'd0,
                 F_DRAIN = 2'd1,
                 F_RESET = 2'd2,
                 F_WAIT  = 2'd3;

reg [1:0] fstate;
reg [4:0] rst_cnt;
reg       fifo_rst_pulse;
reg       ready_gmii;

always @(posedge gmii_rx_clk or negedge eth_rst_n) begin
    if(!eth_rst_n) begin
        fstate         <= F_IDLE;
        rst_cnt        <= 5'd0;
        fifo_rst_pulse <= 1'b0;
        ready_gmii     <= 1'b0;
    end
    else begin
        case(fstate)
            F_IDLE: begin
                fifo_rst_pulse <= 1'b0;
                if(vs_rise) fstate <= F_DRAIN;
            end

            // 等到 MAC 空闲、且剩下的字节已经不够再凑出一个包。
            //
            // 等计数**正好到 0**——这个最直观、也是最初写的条件——会**死锁**。
            // mac_test 只在攒够一个完整载荷时才起一个包,所以它停下来时队列里还
            // 剩 0 ~ UDP_SEND_LEN-1 个字节,计数永远落不到 0。于是写入端永远得不到
            // 放行,整个设计发完一帧就冻住。
            //
            // 判 `< UDP_SEND_LEN` 等价于"MAC 已经再发不出一个包了",而且一定能
            // 终止:每发一个包计数正好掉 UDP_SEND_LEN,所以循环必然结束,而
            // mac_sending 过两拍也会落下。
            F_DRAIN: begin
                if(!mac_sending && fifo_rdusedw < UDP_SEND_LEN) begin
                    fstate  <= F_RESET;
                    rst_cnt <= 5'd0;
                end
            end

            F_RESET: begin
                fifo_rst_pulse <= 1'b1;
                if(rst_cnt == 5'd15) begin
                    fifo_rst_pulse <= 1'b0;
                    fstate         <= F_WAIT;
                end
                else rst_cnt <= rst_cnt + 5'd1;
            end

            F_WAIT: begin
                if(!wr_rst_busy && !rd_rst_busy) fstate <= F_IDLE;
            end

            default: fstate <= F_IDLE;
        endcase

        // 只有控制器停在 IDLE 时才放行写入端。
        ready_gmii <= (fstate == F_IDLE);
    end
end

wire fifo_rst = ~eth_rst_n | fifo_rst_pulse;

camera_fifo u_camera_fifo (
    .rst            (fifo_rst       ),
    .wr_clk         (vin_clk        ),
    .din            (eth_data_in    ),
    .wr_en          (eth_wr_en_in   ),
    .rd_clk         (gmii_rx_clk    ),
    .rd_en          (fifo_rd_en     ),
    .dout           (fifo_data      ),
    .full           (fifo_full      ),
    .empty          (fifo_empty     ),
    .rd_data_count  (fifo_rdusedw   ),
    .wr_rst_busy    (wr_rst_busy    ),
    .rd_rst_busy    (rd_rst_busy    )
);

assign fifo_full_dbg = fifo_full;
assign fifo_cnt_dbg  = fifo_rdusedw;

// ------------------------------------------- 把写入放行信号送进 vin_clk 域
// 这是个能稳定几百微秒的电平,所以一个普通的 2 级同步器就够了,不需要握手。
reg rdy_s0, rdy_s1;
always @(posedge vin_clk or negedge vin_rst_n) begin
    if(!vin_rst_n) begin
        rdy_s0 <= 1'b0;
        rdy_s1 <= 1'b0;
    end
    else begin
        rdy_s0 <= ready_gmii;
        rdy_s1 <= rdy_s0;
    end
end
assign fifo_wr_ready = rdy_s1;

// ------------------------------------------------------------------ MAC
mac_test u_mac_test (
    .rst_n                  (eth_rst_n      ),
    .cmos_vsync             (vs_d1          ),
    .cmos_href              (href_d1        ),
    .reg_conf_done          (1'b1           ),
    .udp_send_data_length   (UDP_SEND_LEN   ),
    .fifo_data              (fifo_data      ),
    .fifo_data_count        (fifo_rdusedw   ),
    .fifo_rd_en             (fifo_rd_en     ),
    .gmii_tx_clk            (gmii_tx_clk    ),
    .gmii_rx_clk            (gmii_rx_clk    ),
    .gmii_rx_dv             (gmii_rx_dv     ),
    .gmii_rxd               (gmii_rxd       ),
    .gmii_tx_en             (gmii_tx_en     ),
    .gmii_txd               (gmii_txd       ),
    .mac_sending            (mac_sending    ),
    .mac_not_exist          (mac_not_exist  ),
    .arp_found              (arp_found      )
);

assign mac_sending_dbg    = mac_sending;
assign mac_not_exist_dbg  = mac_not_exist;
assign arp_found_dbg      = arp_found;

util_gmii_to_rgmii u_gmii_to_rgmii (
    .reset                  (~eth_rst_n     ),
    .sys_clk                (clk_200m       ),
    .rgmii_td               (rgmii_txd      ),
    .rgmii_tx_ctl           (rgmii_txctl    ),
    .rgmii_txc              (rgmii_txc      ),
    .rgmii_rd               (rgmii_rxd      ),
    .rgmii_rx_ctl           (rgmii_rxctl    ),
    .gmii_rx_clk            (gmii_rx_clk    ),
    .rgmii_rxc              (rgmii_rxc      ),
    .gmii_txd               (gmii_txd       ),
    .gmii_tx_en             (gmii_tx_en     ),
    .gmii_tx_er             (gmii_tx_er     ),
    .gmii_tx_clk            (gmii_tx_clk    ),
    .gmii_crs               (gmii_crs       ),
    .gmii_col               (gmii_col       ),
    .gmii_rxd               (gmii_rxd       ),
    .gmii_rx_dv             (gmii_rx_dv     ),
    .gmii_rx_er             (gmii_rx_er     ),
    .speed_selection        (2'b10          ),   // 10 = 1000 Mbps
    .duplex_mode            (1'b1           ),
    .rgmii_rx_ctl_idelay    ()
);

endmodule
