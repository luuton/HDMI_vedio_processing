// video_to_eth 的自校验 testbench。
//
// 用一套等比缩小、但结构上完全一致的几何参数,让整个仿真几千拍就跑完:
//     H_ACTIVE  = 8   (实际 1920)
//     H_BLANK   = 8   (实际 280)
//     V_ACTIVE  = 6   (实际 1080)
//     V_BLANK   = 24  (实际约 99000)  -- 必须大于 GAP_FRAME
//     GAP_FRAME = 12  (实际 1000)     -- 必须大于 H_BLANK
//
// 每帧的预期结果:
//     保留行数   = V_ACTIVE/2 = 3          (偶数行下标 0,2,4)
//     每行写次数 = H_ACTIVE   = 8          (每个 de 脉冲写一次)
//     每帧字节数 = 3 * 8      = 24
//
// 同时验证 RGB565 打包和抽取是否正确:保留行的第 k 对字节必须等于像素 2k 的
// RGB565,而奇数像素绝不能出现。
//
// 一共生成两帧,这样帧边界检测(frame_flag、line_idx 复位、kept_lines 复位)才会被
// 真正跑到,而不是只测了第一帧。

`timescale 1ns/1ps

module tb_video_to_eth;

localparam H_ACTIVE  = 8;
localparam H_BLANK   = 8;
localparam V_ACTIVE  = 6;
localparam V_BLANK   = 24;
localparam GAP_FRAME = 12;      // 必须大于 H_BLANK,否则行消隐会被当成场消隐
localparam FRAMES    = 2;

localparam KEPT_LINES  = V_ACTIVE / 2;
localparam BYTES_LINE  = H_ACTIVE;                 // 每个 de 脉冲写一次
localparam BYTES_FRAME = KEPT_LINES * BYTES_LINE;  // 24
localparam TOTAL_BYTES = FRAMES * BYTES_FRAME;

reg clk = 1'b0;
always #3.367 clk = ~clk;                          // ~148.5 MHz

reg rst_n = 1'b0;

reg         de   = 1'b0;
reg  [23:0] data = 24'd0;
reg         push_en  = 1'b1;
reg         wr_ready = 1'b1;

wire         eth_wr_en;
wire [7:0]   eth_data;
wire         eth_vsync;
wire         eth_href;
wire [11:0]  line_pix_cnt;
wire [10:0]  line_idx;
wire [10:0]  kept_lines;

video_to_eth #(
    .H_ACTIVE_PIX (H_ACTIVE ),
    .V_ACTIVE_LINE(V_ACTIVE ),
    .GAP_FRAME    (GAP_FRAME),
    .HREF_HOLD    (4'd4     )
) dut (
    .clk          (clk         ),
    .rst_n        (rst_n       ),
    .vin_de       (de          ),
    .vin_data     (data        ),
    .push_en      (push_en     ),
    .wr_ready     (wr_ready    ),
    .eth_wr_en    (eth_wr_en   ),
    .eth_data     (eth_data    ),
    .eth_vsync    (eth_vsync   ),
    .eth_href     (eth_href    ),
    .line_pix_cnt (line_pix_cnt),
    .line_idx     (line_idx    ),
    .kept_lines   (kept_lines  )
);

// ------------------------------------------------------------------- 采集
reg [7:0]  sbytes [0:TOTAL_BYTES-1];   // 整条输出字节流
integer    byte_idx    = 0;
integer    wr_lines    = 0;
integer    href_rises  = 0;
reg        href_d      = 1'b0;
reg        href_fall_d = 1'b0;   // 延后一拍的"收尾"脉冲
integer    line_writes = 0;
integer    line_wr_max = 0;
integer    line_wr_min = 999999;

always @(posedge clk) begin
    if (eth_wr_en) begin
        if (byte_idx < TOTAL_BYTES) sbytes[byte_idx] <= eth_data;
        byte_idx    <= byte_idx + 1;
        wr_lines    <= wr_lines + 1;
        line_writes <= line_writes + 1;
    end

    // 在上升沿计数,但要等到下降沿**之后一拍**才采样并清零——一行的最后一次写和
    // 下一行的第一次写会落在同一拍上,所以在边沿那一拍采样,两种写法都会漏掉一个
    // 计数。延时上是安全的:href 在最后一个 de 之后 HREF_HOLD 拍才落下,而 H_BLANK
    // 大于 HREF_HOLD,所以这个窗口没有歧义。
    if (eth_href && !href_d) href_rises <= href_rises + 1;
    href_d      <= eth_href;
    href_fall_d <= (!eth_href && href_d);
    if (href_fall_d) begin
        if (line_writes > line_wr_max) line_wr_max <= line_writes;
        if (line_writes < line_wr_min) line_wr_min <= line_writes;
        line_writes <= 0;
    end
end

// -------------------------------------------------------------- 激励
// 像素颜色是 (帧, 行, 像素) 的纯函数,这样期望字节可以脱离 DUT 独立算出来。
task emit_line(input integer f, input integer l);
    integer p;
    reg [7:0] r, g, b;
    begin
        r = (f*16 + l) & 8'hff;
        for (p = 0; p < H_ACTIVE; p = p + 1) begin
            g = (p*2)       & 8'hff;
            b = (255 - p)   & 8'hff;
            de   = 1'b1;
            data = {r, g, b};
            @(negedge clk);
        end
        de = 1'b0;
    end
endtask

task blank(input integer n);
    integer i;
    begin
        de = 1'b0;
        for (i = 0; i < n; i = i + 1) @(negedge clk);
    end
endtask

integer f, l, ki, kp, k, mismatches, exp_idx;
reg [7:0]  tr, tg, tb;
reg [15:0] exp565;
reg [7:0]  got_hi, got_lo;

initial begin
    repeat (8) @(negedge clk);
    rst_n = 1'b1;
    repeat (4) @(negedge clk);

    for (f = 0; f < FRAMES; f = f + 1) begin
        for (l = 0; l < V_ACTIVE; l = l + 1) begin
            emit_line(f, l);
            blank(H_BLANK);
        end
        blank(V_BLANK);                     // 场消隐 -> 新的一帧
    end
    repeat (40) @(negedge clk);

    $display("");
    $display("total writes        = %0d   (expect %0d)", wr_lines, TOTAL_BYTES);
    $display("eth_href rises      = %0d   (expect %0d)", href_rises, FRAMES*KEPT_LINES);
    $display("writes per line     = min %0d / max %0d   (expect %0d)",
             line_wr_min, line_wr_max, BYTES_LINE);

    mismatches = 0;
    for (f = 0; f < FRAMES; f = f + 1) begin
        exp_idx = 0;
        for (ki = 0; ki < KEPT_LINES; ki = ki + 1) begin
            l = ki * 2;                                  // 奇数行被丢弃
            for (kp = 0; kp < H_ACTIVE/2; kp = kp + 1) begin
                k = kp * 2;                              // 奇数像素被丢弃
                tr = (f*16 + l) & 8'hff;
                tg = (k*2)      & 8'hff;
                tb = (255 - k)  & 8'hff;
                // RGB565: R[7:3] | G[7:2](6 位,不是 3 位) | B[7:3]
                exp565 = {tr[7:3], tg[7:2], tb[7:3]};
                got_hi = sbytes[f*BYTES_FRAME + exp_idx];
                got_lo = sbytes[f*BYTES_FRAME + exp_idx + 1];
                if (got_hi !== exp565[15:8] || got_lo !== exp565[7:0]) begin
                    if (mismatches < 4)
                        $display("  MISMATCH frame%0d line%0d pix%0d: got %0d %0d expected %0d %0d",
                                 f, l, k, got_hi, got_lo, exp565[15:8], exp565[7:0]);
                    mismatches = mismatches + 1;
                end
                exp_idx = exp_idx + 2;
            end
        end
    end
    $display("payload mismatches  = %0d / %0d", mismatches, TOTAL_BYTES);
    $display(line_wr_min == BYTES_LINE && line_wr_max == BYTES_LINE &&
             wr_lines == TOTAL_BYTES &&
             href_rises == FRAMES*KEPT_LINES && mismatches == 0
             ? "RESULT: PASS" : "RESULT: FAIL");
    $display("");
    $finish;
end

endmodule
