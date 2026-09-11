`timescale 1ns/1ps
//////////////////////////////////////////////////////////////////////////////////////
// 模块名 : video_to_eth
// 说明   : 把 1080p60 的 RGB888 视频流抽取成 960x540 RGB565,并以连续字节流
//          的形式送给 UDP 发送端。
//
//          全部工作在 sys_vin_clk(148.5 MHz)域。只输出电平——没有任何单拍脉冲
//          跨进 gmii 时钟域。
//////////////////////////////////////////////////////////////////////////////////////
//
// 几何关系
//   列 : 每 2 个有效像素留 1 个       -> 960 像素/行
//   字节: 每个保留像素 2 字节(RGB565) -> 1920 字节/行
//   行 : 每隔一行留一行              -> 540 行/帧
//   帧 : 540 * 1920 = 1,036,800 字节
//
//   采样率是 1,036,800 B * 60 = 62.2 MB/s。千兆线速在扣掉以太网/IP/UDP 头之后
//   的有效载荷约 118 MB/s,余量充足——但**只有**配合垂直抽取才成立。去掉垂直抽
//   取会让速率翻倍、超过线速,4096 深的 FIFO 大约 13 行就溢出。**不要删掉它**。
//
// 行 / 帧边界检测
//   刻意**不用** vin_vs 和 vin_hs。本工程里 vin_hs 接的是去雾链的 pre_frame_href,
//   而它的确切脉冲形状哪里都没有说明;vin_vs 的极性同样只是由顶层隐含。
//   这里改为从 de 的间隔推导:
//     - 本设计的行消隐是 280 拍(总共 2200 - 有效 1920),
//     - 场消隐约 99,000 拍(666 us)。
//   所以间隔 >= GAP_FRAME 就毫无歧义地意味着"新的一帧",完全不需要对同步极性
//   做任何假设。de 每个有效像素恰好一个脉冲,所以数 de 也是唯一能**自校验**、确
//   切知道实际送进来的行宽是多少的办法——为此把 line_pix_cnt 引出来给 ILA。
//
// 字节输出
//   每个 de 脉冲写一个字节:列下标为偶时采集该像素、并输出它的 RGB565 高字节;
//   紧接着的奇数列输出刚才存下的低字节。两个像素到达的时间和这两个字节需要的
//   时间一样都是两拍,所以一个保留行恰好产生 1920 次写。
//
//   只有"写"受 push_en / wr_ready 门控。推流关断期间列/行/帧计数器继续跑,所以
//   重新打开时总是从行边界继续,而不是从一行中间。

module video_to_eth #(
    parameter H_ACTIVE_PIX  = 1920,      // 每行有效像素数(1080p60)
    parameter V_ACTIVE_LINE = 1080,      // 每帧有效行数
    parameter [10:0] GAP_FRAME = 11'd1000, // de 连续为低的拍数,超过即认为"进入场消隐"
    parameter [3:0]  HREF_HOLD = 4'd8      // 最后一个 de 之后 eth_href 还要保持几拍
)(
    input               clk,        // sys_vin_clk,148.5 MHz
    input               rst_n,

    // 视频输入——顶层已经多路选择好的 去雾/旁路 总线。
    input               vin_de,
    input      [23:0]   vin_data,

    // 控制
    input               push_en,    // key_in[2] 消抖后:1 = 推流到以太网
    input               wr_ready,   // FIFO 复位控制器已放行写入端

    // 字节流输出
    output reg          eth_wr_en,
    output reg  [7:0]   eth_data,
    output reg          eth_vsync,  // 电平:整个场消隐期间为高
    output reg          eth_href,   // 电平:每个保留行一个高脉冲

    // 调试观测
    output reg  [11:0]  line_pix_cnt, // 当前行看到的 de 脉冲数(即字节数)
    output reg  [10:0]  line_idx,     // 当前行在帧内的有效行下标
    output reg  [10:0]  kept_lines    // 本帧已计入的保留行数
);

// ------------------------------------------------------------------ RGB565 打包
// 取 8 位通道的高位即可,不需要做缩放。
wire [15:0] px565 = {vin_data[23:19], vin_data[15:10], vin_data[7:3]};

// ------------------------------------------------------------ de 间隔 / 边沿
reg         de_d1;
reg  [10:0] gap_cnt;            // de 连续为低的拍数,到顶后饱和
wire        de_rise = vin_de & ~de_d1;
wire        de_fall = ~vin_de & de_d1;

always @(posedge clk or negedge rst_n) begin
    if(!rst_n) de_d1 <= 1'b0;
    else       de_d1 <= vin_de;
end

always @(posedge clk or negedge rst_n) begin
    if(!rst_n)                  gap_cnt <= 11'd0;
    else if(vin_de)             gap_cnt <= 11'd0;
    else if(gap_cnt != 11'h7ff) gap_cnt <= gap_cnt + 11'd1;
end

wire in_vblank = (gap_cnt >= GAP_FRAME);

// ------------------------------------------------------- 列 / 行 跟踪
reg  [10:0] col;                // 当前行累计的 de 脉冲数
reg         line_kept;          // 当前行的保留标志,整行期间都有效
reg         frame_flag;         // 见到了长间隔;下一个 de_rise 就是一帧的开头

wire col_even = ~col[0];        // 此刻正在到达的这个像素的奇偶性

// 对"即将开始的那一行"的判定。只在 de_rise 那一拍有意义。
// 用组合逻辑算它是为了让一行的**第一个**像素就正确:line_idx / line_kept 是寄存器,
// 在 de_rise 那一拍它们还停留在上一行的值上。
wire [10:0] idx_next  = frame_flag ? 11'd0 : (line_idx + 11'd1);
wire        kept_next = frame_flag ? 1'b1 : ~idx_next[0];
wire        kept_now  = de_rise ? kept_next : line_kept;

// 此刻到达的像素的写使能条件,组合得到。
wire        wr_now    = vin_de & kept_now & push_en & wr_ready;

always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        col         <= 11'd0;
        line_idx    <= 11'd0;
        line_kept   <= 1'b0;
        frame_flag  <= 1'b0;
        kept_lines  <= 11'd0;
        line_pix_cnt<= 12'd0;
    end
    else if(de_rise) begin
        col          <= 11'd1;              // 这个像素是第 0 个
        line_pix_cnt <= 12'd1;
        line_idx     <= idx_next;
        line_kept    <= kept_next;
        frame_flag   <= 1'b0;               // 已被本行消费掉
        if(frame_flag) kept_lines <= 11'd0; // 新帧开始:行计数清零重来
    end
    else if(de_fall) begin
        // col 在 de_fall 清零、而不是在 de_rise,这样 de_rise 那一拍 col_even 就已经
        // 是对的。line_pix_cnt 则故意在整个消隐期间保持终值不动,好让 ILA 能抓到
        // "某一行偏短或偏长"这种异常。
        col          <= 11'd0;
        if(line_kept) kept_lines <= kept_lines + 11'd1;
    end
    else if(vin_de) begin
        col          <= col + 11'd1;
        line_pix_cnt <= line_pix_cnt + 12'd1;
    end
    else if(in_vblank) begin
        // 在场消隐的第一拍置起来,一直保持到下一个 de_rise 把它消费掉,这样下一个
        // 有效行就是第 0 行。
        frame_flag   <= 1'b1;
    end
end

// ------------------------------------------------------------- 字节输出
// 在每个偶数列就把采样到的像素低字节存下来,这样下一拍奇数列到达时它已经准备好了。
reg [7:0] lo_byte;

always @(posedge clk or negedge rst_n) begin
    if(!rst_n) lo_byte <= 8'd0;
    else if(vin_de & col_even) lo_byte <= px565[7:0];
end

// 两路输出都打了拍,所以都比它们所描述的那个像素晚一拍——也正因此两者彼此对齐,
// 而"彼此对齐"才是这里真正要紧的。
always @(posedge clk or negedge rst_n) begin
    if(!rst_n) eth_wr_en <= 1'b0;
    else       eth_wr_en <= wr_now;
end

always @(posedge clk or negedge rst_n) begin
    if(!rst_n) eth_data <= 8'd0;
    else if(vin_de) eth_data <= col_even ? px565[15:8] : lo_byte;
end

// ------------------------------------------------------------------- 电平
// eth_href 整行保持为高,并在最后一个 de 之后继续保持 HREF_HOLD 拍,然后在剩下的
// 行消隐里拉低——每个保留行恰好一个上升沿,mac_test 就是靠数这个来生成
// identify_code 的。
// 这里用 kept_now 而不是 line_kept:de_rise 那一拍寄存器里的值还是旧的。
always @(posedge clk or negedge rst_n) begin
    if(!rst_n) eth_href <= 1'b0;
    else       eth_href <= (vin_de | (gap_cnt < HREF_HOLD)) & kept_now;
end

// eth_vsync 在整个场消隐期间为高。它的上升沿就是 FIFO 复位控制器用来同步的帧边界。
always @(posedge clk or negedge rst_n) begin
    if(!rst_n) eth_vsync <= 1'b0;
    else       eth_vsync <= in_vblank;
end

endmodule
