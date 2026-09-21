// haze_removal_top 的离线自校验 testbench。
//
// 修复前的故障(hdmi_loop.v 把 SiI9013 的 HSYNC 脚接给了 pre_frame_href):
//     .pre_frame_href  (vin_hs)      <- HSYNC 输出脚 N18,与 DE(N19)是两个引脚
//     .pre_frame_clken (vin_de)
// 1080p60(CEA-861 VIC 16)是正极性 H 同步,所以 vin_hs 在**整条有效行期间恒为 0**,
// 只在行消隐里高一小段;而去雾链要求 pre_frame_href 是"一整行都有效"的电平:
//     matrix_generate_3x3.v:97-101  href 为 0 时把 3x3 窗口强制清零
//     src_min.v:37 / calculate_A.v:50 的门是 href & clken,而 hs 脉冲落在
//                                     de=0 的消隐里,于是这个与恒为 0
// 结果是暗通道恒为 0、A 停在 0(输出端兜到 1)、t 恒为 255,代入定点算术
// 恰好得到 J = I(误差 <= 1 LSB)—— 不是"效果弱",是恒等变换。
//
// **修复前的实测**(本 tb 早先版本,那时 DUT 还是旧接线,默认模式即复现):
//     cal_A (稳态) = 1        cal_tx_img = 255 恒定
//     最佳延迟 D = 11 : 最大偏差 1 => 输出就是源图的延迟副本
//     逐位模型 746/746 完全一致
//
// 修复(haze_removal_top.v):数据通路改用 href_line = pre_frame_clken 作行门控;
// 输出标记则改从 cal_src_frame_href(time_alignment 的 src 通路,本身已把真 HSYNC
// 对齐到 cal_img)取,再由 haze_removal_cal 自己的 3 拍与画面同步延迟。
//
// 本 tb 用 plusarg 在两套**端口激励**之间切换,用来验证修复的关键性质:
//     默认(不带参数)   pre_frame_href = 行消隐里的窄脉冲 = 板上真实波形
//     +DE              pre_frame_href = 与 clken 相同的行有效电平
// clken 在两种模式下都接行有效电平。
//
// 判据(修复后,两种模式都应成立):
//     D1 输出被真正变换(不是任何延迟的副本),且与逐位模型完全一致
//     D2 两种模式的数据结果**逐位相同** —— 证明端口 href 已经够不到数据通路,
//        这正是"接线错误"被消除的形式化表述(baseline 里两种模式结果不同)
//     D3 输出标记仍是输入标记的延迟副本(默认模式:窄脉冲,因此 R2 要求满足)
//
// 另外做一次延迟审计:量出 post_frame_clken / post_frame_href 相对输入各是多少拍,
// 并给出 post_frame_href 的脉冲宽度,确认它没有被撑成整行电平。
//
// ===================== 暗通道窗口 3x3 -> 7x7(2026-09-21) =====================
// dark_channel.v 改成把 3x3 那一级**串联 WINDOW_PASSES 次**。盒式最小值是可组合的
// 形态学腐蚀,[-1,1]^2 (+) [-1,1]^2 (+) [-1,1]^2 = [-3,3]^2,所以三级串联恰好等于
// 一个 7x7 盒式最小值 —— 不用新写模块,也不用动行缓存。代价:每多一级 +4 拍延迟、
// +2 条行缓存(1920 像素下 2 个 BRAM18)。
// 由此 time_alignment 的 src_delay 从 8 变成 1 + 4*3 + 3 = 16(它现在是**算出来**的,
// 不再手写常数;原来那个手写 8 加一句"改一个记得改另一个"的注释就是个陷阱)。
//
// 本 tb 随之要改的只有几何:V_ACTIVE 8 -> 16,因为 7x7 窗口要 7 行才填满。
//
// 判据新增:
//     D4 暗通道本身与"src_pmin 的因果 KWIN x KWIN 盒式最小值"**逐位相同**(内部区域)。
//        这一条直接验证上面那个设计主张,而不是只靠 A / tx 间接推断。
//
// `-d WP1` 把 WINDOW_PASSES 编译成 1(= 原来的单级 3x3),同一份激励应当同样全过,
// 于是可以在仿真里直接 A/B 两种窗口。

`timescale 1ns/1ps

module tb_haze_removal_top;

// ============================================================ 几何参数
// 等比缩小,但比例关系与 1080p60 一致:行有效 32 / 行消隐 16,
// HSYNC 脉冲 4 拍且落在行消隐里(H_SYNC_AT + H_SYNC_LEN = 40 < 48)。
// PIC_WIDTH 必须等于行有效像素数,one_column_ram 的行延迟才成立。
localparam H_ACTIVE   = 32;
localparam H_BLANK    = 16;
localparam H_TOTAL    = H_ACTIVE + H_BLANK;   // 48
localparam H_SYNC_AT  = 36;                   // 脉冲落在行消隐 [32,48)
localparam H_SYNC_LEN = 4;                    // 对应 1080p60 的 44/2200

// 暗通道窗口:3 级 3x3 串联 = 精确的 7x7 盒式最小值(dark_channel.v 里证明)。
// `-d WP1` 编译成单级 3x3,用来做 A/B —— 同一个 tb、同一份激励,只换窗口。
`ifdef WP1
localparam WINDOW_PASSES = 1;
`else
localparam WINDOW_PASSES = 3;
`endif
localparam KWIN       = 2*WINDOW_PASSES + 1;  // WP=3 时为 7

// V_ACTIVE 必须远大于 KWIN:窗口要 KWIN 行才填满,行首还有 KWIN-1 拍被行消隐清零,
// 每帧得留出稳态行。原来的 8 是按 3x3 定的,对 7x7 只剩 1 行,所以放大到 16。
localparam V_ACTIVE   = 16;
localparam V_BLANK    = 8;
localparam V_TOTAL    = V_ACTIVE + V_BLANK;   // 24
localparam FRAMES     = 3;
// 第 0 行留作**场消隐**:有效行是 1..V_ACTIVE。这样复位期间 de 一直是 0,
// 流水线是干净的;否则 de 在复位窗口里恒为 1(计数器停在 hcnt=0 → in_pix 为真),
// 11 级 clken 链会被提前灌满,采集到的"第一行"就会把 2 拍残留在前面粘成一个
// 34 拍的长行。真实视频里首条有效行之前也一定有一整段场消隐。
localparam VC0        = 1;

localparam DRAIN      = 2 * V_TOTAL * H_TOTAL;              // 排空流水线
localparam MAXCYC     = FRAMES * V_TOTAL * H_TOTAL + DRAIN; // 5760
localparam DMAX       = 32;                                 // 延迟扫描上限
// 稳态窗口 = 第 1 帧的有效区(第 0 帧不具代表性:A_value_out 复位默认 230)。
// 从帧内偏移 64 开始,跳过窗口还没填满、还在被行消隐清零的那几行。
localparam SS0        = V_TOTAL * H_TOTAL + 64;
localparam SS1        = 2 * V_TOTAL * H_TOTAL;

// 字符串寄存器必须按字节数开够,否则 $display 会截断(中文每字 3 字节)。
reg [8*72-1:0] mode_name;

reg clk = 1'b0;
always #3.367 clk = ~clk;                     // ~148.5 MHz

reg rst_n = 1'b0;

// 采集窗口的相位基准:cyc 与激励计数器共用 run,保证两者同相。
integer cyc = 0;
reg     run = 1'b0;

// ============================================================ 激励生成
// 计数器自由跑,一行 H_TOTAL 拍、一帧 V_TOTAL 行。
integer hcnt = 0;
integer vcnt = 0;
integer frm  = 0;

// 计数器必须和采集窗口同相:run=0 期间一直清零,run=1 那一拍 hcnt/vcnt/frm
// 从 0 开始,和 cyc 从 0 开始严格对齐。否则采集窗口会从半行中间切入,
// 首尾两行都只有一部分,传输计数对不上。
always @(posedge clk) begin
    if (!run) begin
        hcnt <= H_ACTIVE;                 // 停在行消隐里,de 在复位期间为 0
        vcnt <= 0;
        frm  <= 0;
    end
    else if (hcnt == H_TOTAL - 1) begin
        hcnt <= 0;
        if (vcnt == V_TOTAL - 1) begin
            vcnt <= 0;
            frm  <= frm + 1;
        end
        else vcnt <= vcnt + 1;
    end
    else hcnt <= hcnt + 1;
end

wire in_line = (vcnt >= VC0) && (vcnt < VC0 + V_ACTIVE) && (frm < FRAMES);
wire in_pix  = (hcnt < H_ACTIVE);

wire de_w = in_line && in_pix;      // 行有效电平:每行 32 拍为高
// HSYNC 每条线都发,场消隐里也发 —— 真实接收芯片就是这个行为。
wire hs_w = (hcnt >= H_SYNC_AT) && (hcnt < H_SYNC_AT + H_SYNC_LEN);
wire vs_w = (vcnt >= VC0 + V_ACTIVE) && (frm < FRAMES);

integer href_hs;
initial begin
    href_hs = 1;                                   // 默认 = 板上现状
    if ($test$plusargs("DE")) href_hs = 0;         // +DE = 修复后的接线
    if (href_hs) mode_name = "hs  (板上现状: pre_frame_href = HSYNC 窄脉冲)";
    else         mode_name = "de  (修复后:   pre_frame_href = 行有效电平)";
end

wire href_w = href_hs ? hs_w : de_w;

// 合成的"有雾"场景:亮大气幕 + 暗/亮目标块,块内每个像素还带一点梯度,
// 这样逐位比较不会被重复像素掩盖。
// 暗块 150..189、亮块 210..249,整帧最大通道值 A = 249。
function [23:0] src_pix(input integer l, input integer c);
    integer idx;
    integer blk;
    integer v;
    begin
        idx = l * H_ACTIVE + c;                    // 0 .. 255
        blk = ((c / 6) + (l / 3)) % 2;             // 0 = 暗目标, 1 = 亮目标
        v   = (blk ? 60 : 0) + 150 + (idx % 40);
        if (v > 255) v = 255;
        src_pix = {v[7:0], v[7:0], v[7:0]};
    end
endfunction

// 源图每像素的 min(R,G,B)。src_pix 三通道相同,所以就是上面的 v。
// 单独抽出来,是为了给下面的暗通道直接核对当参考模型。
function integer src_pmin(input integer l, input integer c);
    integer idx, blk, v;
    begin
        idx = l * H_ACTIVE + c;
        blk = ((c / 6) + (l / 3)) % 2;
        v   = (blk ? 60 : 0) + 150 + (idx % 40);
        if (v > 255) v = 255;
        src_pmin = v;
    end
endfunction

// 暗通道的直接参考模型:对 src_pmin 做**因果**的 KWIN x KWIN 盒式最小值,
// 即窗口锚在当前像素、向 (x-KWIN+1..x, y-KWIN+1..y) 扩展。
// 因为 RTL 里每一级 3x3 都是因果的,串联出来整体也是因果窗口,不是居中窗口。
// 只在内部区域调用(l >= 帧首有效行 + KWIN-1 且 c >= KWIN-1),这样窗口完全落在
// 有效像素里,不必建模"行消隐把窗口清零"这件事。
function integer dc_box(input integer l, input integer c);
    integer dy, dx, v, mn;
    begin
        mn = 255;
        for (dy = 0; dy < KWIN; dy = dy + 1)
            for (dx = 0; dx < KWIN; dx = dx + 1) begin
                v = src_pmin(l - dy, c - dx);
                if (v < mn) mn = v;
            end
        dc_box = mn;
    end
endfunction

reg [23:0] pix;
always @(*) pix = (in_line && in_pix) ? src_pix(vcnt, hcnt) : 24'd0;

// ============================================================ 被测模块
wire        post_vs;
wire        post_hs;
wire        post_de;
wire [23:0] post_data;

haze_removal_top #(
    .Y_ENHANCE_ENABLE (0           ),
    .PIC_WIDTH        (H_ACTIVE    ),
    .WINDOW_PASSES    (WINDOW_PASSES)
) u_dut (
    .clk               (clk     ),
    .rst_n             (rst_n   ),
    .pre_frame_vsync   (vs_w    ),
    .pre_frame_href    (href_w  ),
    .pre_frame_clken   (de_w    ),
    .pre_img           (pix     ),
    .post_frame_vsync  (post_vs ),
    .post_frame_href   (post_hs ),
    .post_frame_clken  (post_de ),
    .post_img          (post_data)
);

// ============================================================ 采集
// 全部按**时钟拍**记录。cal_img / cal_tx_img / cal_A / cal_*_clken 都是
// haze_removal_top 模块级的线网(在 generate 之外声明),可以安全地层次化引用。
reg [23:0] cap_in  [0:MAXCYC-1];
reg [23:0] cap_out [0:MAXCYC-1];
reg  [7:0] cap_ci  [0:MAXCYC-1];   // cal_img 的红通道(= 延时对齐后的源图)
reg  [7:0] cap_ct  [0:MAXCYC-1];   // cal_tx_img(透射率图)
reg  [7:0] cap_ca  [0:MAXCYC-1];   // cal_A(大气光)
reg        cap_inc [0:MAXCYC-1];   // 输入行有效
reg        cap_ihs [0:MAXCYC-1];   // 输入 href(实际驱动给 DUT 的那个)
reg        cap_oec [0:MAXCYC-1];   // 输出行有效
reg        cap_src [0:MAXCYC-1];   // cal_src_frame_clken
reg        cap_txc [0:MAXCYC-1];   // cal_tx_frame_clken
reg        cap_ohs [0:MAXCYC-1];   // 输出 href
reg  [7:0] cap_dc  [0:MAXCYC-1];   // dark_channel 的输出 = 暗通道 dc 本身
reg        cap_dcc [0:MAXCYC-1];   // dark_channel 自己的行有效(它是 dc 的合法窗口)
reg [15:0] cap_l   [0:MAXCYC-1];   // 该拍激励像素的行号(vcnt)
reg [15:0] cap_c   [0:MAXCYC-1];   // 该拍激励像素的列号(hcnt)

always @(posedge clk) begin
    if (run) begin
        cap_in [cyc] <= pix;
        cap_out[cyc] <= post_data;
        cap_ci [cyc] <= u_dut.cal_img[23:16];
        cap_ct [cyc] <= u_dut.cal_tx_img;
        cap_ca [cyc] <= u_dut.cal_A;
        cap_inc[cyc] <= de_w;
        cap_ihs[cyc] <= href_w;
        cap_oec[cyc] <= post_de;
        cap_src[cyc] <= u_dut.cal_src_frame_clken;
        cap_txc[cyc] <= u_dut.cal_tx_frame_clken;
        cap_ohs[cyc] <= post_hs;
        // dc 用**它自己的** valid 做门控,而不是用最终输出的 cap_oec:两者在流水线里
        // 相差十几拍,拿输出的 valid 去采 dc,会采到 dc 处于行消隐清零值的那些拍。
        cap_dc [cyc] <= u_dut.dark_channel_img;
        cap_dcc[cyc] <= u_dut.dark_channel_frame_clken;
        cap_l  [cyc] <= vcnt;
        cap_c  [cyc] <= hcnt;
    end
end
always @(posedge clk) if (run && cyc < MAXCYC - 1) cyc <= cyc + 1;

// ============================================================ 逐位模型
// 复刻 haze_removal_cal 的 `else` 分支(Y_ENHANCE_ENABLE=0 走的这条)。
// 注意 RTL 里分子和除数是**错开一拍**的:
//     value_tem_r@n  <- 来自输入 (n-1)   (延迟 1)
//     recip_r@n      <- recip_rom[tx_value_d1@(n-1)] = 来自输入 (n-2) (延迟 2)
//     prod_r@n       <- value_tem_r@(n-1) * recip_r@(n-1)
// 所以 out[k] 用的是 I/A/t 在 k-2、而除数是 t 在 k-3。这里如实照搬。
function [11:0] recip_of(input integer v);
    begin
        if (v < 26) recip_of = 12'd2521;
        else        recip_of = (65536 + (v >> 1)) / v;
    end
endfunction

function [7:0] j_of(input [7:0] ipix, input [7:0] a,
                    input [7:0] tsrc, input [7:0] tdiv);
    integer si, sa, txv, txvd, valtem, prod, q;
    begin
        si = ipix;
        sa = a;
        txv  = (tsrc < 26) ? 26 : tsrc;   // haze_removal_cal 里的 tx_min 兜底
        txvd = (tdiv < 26) ? 26 : tdiv;
        valtem = (si - sa) * 256 + sa * txv;
        prod   = valtem * recip_of(txvd);
        q      = (prod + 32768) >>> 16;   // 带符号算术右移
        if (q > 255)    j_of = 8'd255;    // 饱和
        else if (q < 0) j_of = 8'd0;
        else            j_of = q[7:0];
    end
endfunction

// ============================================================ 主流程
integer i, d, hi;
integer n_in, n_out;
integer lcur, lmin, lmax, nline, lstart;
integer ilcur, ilm, ils;                    // 输入行长扫描用的游标
integer hs_run, hs_maxrun, hs_minrun, hs_nrun, hs_first, hs_firstlen;
integer sum_out, sum_ca, sum_ct;            // 跨模式比对用的校验和
integer best_d, best_mm, best_tot, best_delta;
integer ex_d, ex_tot;
integer lhist [0:40];
integer mm, tot, delta, maxdelta;
integer ca_min, ca_max, ct_min, ct_max;
integer ca_min2, ca_max2, ct_min2, ct_max2;
integer mod_best, mod_mm, mod_tot, mod_tot_of_best;
integer dc_d, dc_mm, dc_tot;
integer pass;
reg [23:0] ta, tb;
reg  [7:0] ti, tv;
reg  [7:0] tdc;

initial begin
    // 复位
    repeat (8) @(posedge clk);
    rst_n = 1'b1;
    @(posedge clk);
    cyc = 0;
    run = 1'b1;

    wait (cyc == MAXCYC - 1);
    @(posedge clk);
    run = 1'b0;
    repeat (4) @(posedge clk);

    $display("");
    $display("==================== HREF_MODE = %s ====================", mode_name);

    // ---------------------------------------------------- 传输计数与行结构
    n_in = 0; n_out = 0;
    for (i = 0; i < MAXCYC; i = i + 1) begin
        if (cap_inc[i]) n_in  = n_in  + 1;
        if (cap_oec[i]) n_out = n_out + 1;
    end

    lcur = 0; lmin = 999999; lmax = 0; nline = 0;
    for (i = 0; i < MAXCYC; i = i + 1) begin
        if (cap_oec[i]) lcur = lcur + 1;
        else if (lcur > 0) begin
            if (lcur < lmin) lmin = lcur;
            if (lcur > lmax) lmax = lcur;
            nline = nline + 1;
            lcur  = 0;
        end
    end

    $display("输入有效像素传输数 = %0d", n_in);
    $display("输出有效像素传输数 = %0d   (行数 %0d)", n_out, nline);
    $display("输出每行传输数     = min %0d / max %0d   (期望 %0d)", lmin, lmax, H_ACTIVE);
    // 每行长度的直方图:正常应全部是 H_ACTIVE。用直方图而不是只看 min/max,
    // 是为了能直接指出到底哪几行不对,而不是猜。
    for (i = 0; i <= 40; i = i + 1) lhist[i] = 0;
    lcur = 0; lstart = 0;
    for (i = 0; i < MAXCYC; i = i + 1) begin
        if (cap_oec[i]) begin
            if (lcur == 0) lstart = i;
            lcur = lcur + 1;
        end
        else if (lcur > 0) begin
            if (lcur <= 40) lhist[lcur] = lhist[lcur] + 1;
            if (lcur != H_ACTIVE)
                $display("  !! 异常行: 第 %0d..%0d 拍,长度 %0d", lstart, i-1, lcur);
            lcur = 0;
        end
    end
    $write("  行长度直方图:");
    for (i = 0; i <= 40; i = i + 1)
        if (lhist[i] > 0) $write(" %0d x %0d行", i, lhist[i]);
    $display("");

    // 同一套扫描对**输入** clken 也做一遍。输入应当恰好是 24 行 x 32 拍;如果
    // 输入侧本身就有第 1 行偏长,那"输出第 1 行偏长"就与 DUT 无关,是采集窗口
    // 相对激励的相位问题,而不是丢/多像素。
    ilcur = 0; ilm = 0; ils = 0;
    $write("  输入行长直方图:");
    for (i = 0; i <= 40; i = i + 1) lhist[i] = 0;
    for (i = 0; i < MAXCYC; i = i + 1) begin
        if (cap_inc[i]) begin
            if (ilcur == 0) ils = i;
            ilcur = ilcur + 1;
        end
        else if (ilcur > 0) begin
            if (ilcur <= 40) lhist[ilcur] = lhist[ilcur] + 1;
            if (ilcur != H_ACTIVE)
                $display("  !! 输入异常行: 第 %0d..%0d 拍,长度 %0d", ils, i-1, ilcur);
            if (ilm == 0) $display("  输入首行: 第 %0d..%0d 拍,长度 %0d", ils, i-1, ilcur);
            ilm = ilm + 1;
            ilcur = 0;
        end
    end
    for (i = 0; i <= 40; i = i + 1)
        if (lhist[i] > 0) $write(" %0d x %0d行", i, lhist[i]);
    $display("");

    // post_frame_href 的脉冲宽度:修复后它必须仍是**窄脉冲**(默认模式),而不是
    // 被撑成整行电平。de 模式下端口 href 本身就是整行电平,故那里期望 H_ACTIVE。
    // 判据用"最宽 == 最窄"而不是脉冲个数:个数取决于采集窗口里正好装下几条线,
    // 而宽度是窗口无关的性质 —— 修复后每一行的 HS 都应当是同一个宽度。
    hs_run = 0; hs_maxrun = 0; hs_minrun = 999999; hs_nrun = 0;
    hs_first = -1; hs_firstlen = 0;
    for (i = 0; i < MAXCYC; i = i + 1) begin
        if (cap_ohs[i]) begin
            if (hs_run == 0) begin
                if (hs_first < 0) hs_first = i;
                hs_nrun = hs_nrun + 1;
            end
            hs_run = hs_run + 1;
            if (hs_run > hs_maxrun) hs_maxrun = hs_run;
        end
        else if (hs_run > 0) begin
            if (hs_firstlen == 0) hs_firstlen = hs_run;
            if (hs_run < hs_minrun) hs_minrun = hs_run;
            hs_run = 0;
        end
    end
    $display("post_frame_href 脉冲: 宽 %0d..%0d 拍, 共 %0d 个   (窄脉冲期望 %0d,整行电平期望 %0d)",
             hs_minrun, hs_maxrun, hs_nrun, H_SYNC_LEN, H_ACTIVE);

    // 校验和:两个模式各跑一次,把这三行 diff 一下就能证明数据结果逐位相同。
    sum_out = 0; sum_ca = 0; sum_ct = 0;
    for (i = 0; i < MAXCYC; i = i + 1) begin
        sum_out = sum_out + cap_out[i];
        sum_ca  = sum_ca  + cap_ca[i];
        sum_ct  = sum_ct  + cap_ct[i];
    end
    $display("校验和: out %0d  A %0d  tx %0d", sum_out, sum_ca, sum_ct);

    // ---------------------------------------------------- cal_A / cal_tx_img
    // 只在**稳态窗口** SS0..SS1 里量(第 1 帧,跳过窗口未填满的开头)。
    // 第 0 帧不具代表性:A_value_out 的复位默认值是 230,要到第一个 vsync 下降沿
    // 才会被 (A_value > 1) ? A_value : 1 覆盖成帧最大值或兜底 1。
    //
    // 最大值初值必须用 0 而不是 -1:cap_ca 是无符号 8 位,和 integer 比较时整个
    // 表达式按无符号处理,-1 会变成 4294967295,最大值永远不会更新。
    ca_min = 255; ca_max = 0; ct_min = 255; ct_max = 0;
    ca_min2 = 255; ca_max2 = 0; ct_min2 = 255; ct_max2 = 0;
    for (i = 0; i < MAXCYC; i = i + 1)
        if (cap_oec[i]) begin
            if (cap_ca[i] < ca_min) ca_min = cap_ca[i];
            if (cap_ca[i] > ca_max) ca_max = cap_ca[i];
            if (cap_ct[i] < ct_min) ct_min = cap_ct[i];
            if (cap_ct[i] > ct_max) ct_max = cap_ct[i];
            if (i > SS0 && i < SS1) begin
                if (cap_ca[i] < ca_min2) ca_min2 = cap_ca[i];
                if (cap_ca[i] > ca_max2) ca_max2 = cap_ca[i];
                if (cap_ct[i] < ct_min2) ct_min2 = cap_ct[i];
                if (cap_ct[i] > ct_max2) ct_max2 = cap_ct[i];
            end
        end
    $display("cal_A      (全程)  = min %0d / max %0d   (230 是复位默认值)", ca_min, ca_max);
    $display("cal_tx_img (全程)  = min %0d / max %0d", ct_min, ct_max);
    $display("cal_A      (稳态)  = min %0d / max %0d", ca_min2, ca_max2);
    $display("cal_tx_img (稳态)  = min %0d / max %0d", ct_min2, ct_max2);

    // ---------------------------------------------------- 延迟扫描
    // out[T] 是否等于 in[T-D]?逐位比较,顺带记录最大偏差。
    $display("");
    $display("--- 延迟扫描: out[T] 与 in[T-D] 比较 ---");
    // 判据是**最大偏差**,不是"不符个数"。
    // 恒等链路上 settle 出来的 J = I+1(见 haze_removal_cal 的定点代数),
    // 逐位比较会把每个这类像素都记成"不符",但它们全是 1 LSB,仍然是源图的副本。
    // 真正被变换过的输出,任何延迟下最大偏差都是几十级。
    best_d = -1; best_mm = 999999999; best_tot = 0; best_delta = 99999;
    ex_d = -1; ex_tot = 0;
    for (d = 0; d <= DMAX; d = d + 1) begin
        mm = 0; tot = 0; maxdelta = 0;
        for (i = d; i < MAXCYC; i = i + 1) begin
            if (cap_oec[i] && cap_inc[i-d]) begin
                tot = tot + 1;
                ta  = cap_out[i];
                tb  = cap_in[i-d];
                if (ta !== tb) begin
                    mm = mm + 1;
                    delta = (ta[23:16] > tb[23:16]) ? (ta[23:16] - tb[23:16])
                                                    : (tb[23:16] - ta[23:16]);
                    if (delta > maxdelta) maxdelta = delta;
                end
            end
        end
        $display("  D=%0d  比较 %0d  不符 %0d  最大偏差 %0d", d, tot, mm, maxdelta);
        if (tot > 64) begin
            if (maxdelta <= 1 && ex_d < 0) begin ex_d = d; ex_tot = tot; end
            if (maxdelta < best_delta) begin
                best_delta = maxdelta; best_d = d; best_tot = tot; best_mm = mm;
            end
        end
    end
    $display("最佳延迟 D = %0d : 最大偏差 %0d,不符 %0d / %0d",
             best_d, best_delta, best_mm, best_tot);
    if (ex_d >= 0)
        $display("存在延迟 D = %0d 使输出与输入逐个相等(偏差 <= 1 LSB)= 输出就是源图的延迟副本", ex_d);
    else
        $display("不存在任何延迟使输出等于输入(最小最大偏差 %0d)= 输出确实被变换过了", best_delta);

    // ---------------------------------------------------- 逐位模型核对
    $display("");
    $display("--- haze_removal_cal 逐位模型核对 ---");
    mod_best = -1; mod_mm = 999999999; mod_tot = 0; mod_tot_of_best = 0;
    for (d = 1; d <= 5; d = d + 1) begin
        mm = 0; tot = 0;
        for (i = d + 1; i < MAXCYC; i = i + 1) begin
            if (cap_oec[i] && cap_src[i-d] && cap_txc[i-d] && cap_txc[i-d-1]) begin
                tot = tot + 1;
                ti  = cap_ci[i-d];
                tv  = j_of(ti, cap_ca[i-d], cap_ct[i-d], cap_ct[i-d-1]);
                ta  = cap_out[i];
                if (ta[23:16] !== tv) mm = mm + 1;
            end
        end
        $display("  模型延迟 %0d: 比较 %0d  不符 %0d", d, tot, mm);
        if (tot > 64 && mm < mod_mm) begin
            mod_mm = mm; mod_best = d; mod_tot_of_best = tot;
        end
    end
    $display("最佳模型延迟 = %0d : 不符 %0d / %0d", mod_best, mod_mm, mod_tot_of_best);

    // ---------------------------------------------------- 暗通道窗口的直接核对
    // 前面那段只核对了 haze_removal_cal(这次没改)。窗口改动的证据不能只靠 A/tx
    // 间接推,所以这里拿 cap_dc(= dark_channel 的输出)直接对:
    // 对每个候选延迟 D,把 cap_dc[i] 与 src_pmin 的因果 KWIN x KWIN 盒式最小值比,
    // 只比内部区域。这一条证明的就是"3 级 3x3 串联 == 精确的 7x7 盒式最小"这个
    // 设计主张本身;`-d WP1` 编译时 KWIN=3,同一段代码应当同样全过。
    $display("");
    $display("--- 暗通道窗口直接核对 (因果 %0dx%0d 盒式最小值, 只比内部区域) ---", KWIN, KWIN);
    dc_d = -1; dc_mm = 999999999; dc_tot = 0;
    for (d = 1; d <= DMAX; d = d + 1) begin
        mm = 0; tot = 0;
        for (i = d; i < MAXCYC; i = i + 1) begin
            // 门控用 dc 自己的 valid,不要用最终输出的 cap_oec
            if (cap_dcc[i] && cap_l[i-d] >= VC0 + KWIN && cap_c[i-d] >= KWIN
                           && cap_l[i-d] <  VC0 + V_ACTIVE) begin
                tot = tot + 1;
                tdc = dc_box(cap_l[i-d], cap_c[i-d]);
                if (cap_dc[i] !== tdc) mm = mm + 1;
            end
        end
        if (tot > 64) begin
            $display("  模型延迟 %0d: 比较 %0d  不符 %0d", d, tot, mm);
            if (mm < dc_mm) begin dc_mm = mm; dc_d = d; dc_tot = tot; end
        end
    end
    $display("最佳延迟 D = %0d : 不符 %0d / %0d", dc_d, dc_mm, dc_tot);

    // ---------------------------------------------------- 延迟审计
    // 输出的 href / clken 相对输入的 href / clken 各是多少拍。
    $display("");
    $display("--- 延迟审计(输出标记相对输入标记的拍数) ---");
    // 与**实际驱动的**输入 href 逐拍比较,不要另写一个波形公式去重构 ——
    // 那样算出来的相位对不上,会得出"延迟 0 拍"这种假结果。
    //
    // 而且必须比**全部**时钟拍,不能只用 cap_oec 框住:输出行有效期间 href 本来就
    // 是 0(hs 在行消隐里),拿这个窗口做比较,任何延迟都能"对得上",退化成假阳性。
    for (d = 0; d <= DMAX; d = d + 1) begin
        mm = 0; tot = 0;
        for (i = 64; i < MAXCYC; i = i + 1) begin
            tot = tot + 1;
            if (cap_ohs[i] !== cap_ihs[i-d]) mm = mm + 1;
        end
        $display("  href 延迟 %0d: 比较 %0d  不符 %0d", d, tot, mm);
        if (tot > 64 && mm == 0) begin
            $display("  => post_frame_href 相对输入 href 延迟 %0d 拍", d);
            d = DMAX + 1;
        end
    end
    for (d = 0; d <= DMAX; d = d + 1) begin
        mm = 0; tot = 0;
        for (i = d; i < MAXCYC; i = i + 1) begin
            if (cap_oec[i]) begin
                tot = tot + 1;
                if (cap_oec[i] !== cap_inc[i-d]) mm = mm + 1;
            end
        end
        if (tot > 64 && mm == 0) begin
            $display("  post_frame_clken 相对输入 clken 延迟 %0d 拍", d);
            d = DMAX + 1;
        end
    end

    // ---------------------------------------------------- 判据
    // 修复后,数据结果必须**与端口 href 的形状无关**:默认模式喂的是窄脉冲、
    // +DE 喂的是整行电平,两者算出来的图必须一样(这时 D2 的值就该相同)。
    // 修复前两者截然不同(一个恒等、一个真变换),这正是 bug 的定义。
    $display("");
    pass = (n_in == FRAMES*V_ACTIVE*H_ACTIVE)         // 激励没丢拍
           && (lmin == H_ACTIVE)                      // 没有一行短于行长 = 没丢像素
           && (ca_max2 > 1)                           // A 是真正的帧最大值,没有兜底成 1
           && (ct_min2 < ct_max2)                     // 透射率不再恒定
           && (ex_d < 0) && (best_delta > 30)         // 不是任何延迟的副本
           && (mod_mm == 0)                           // haze_removal_cal 与逐位模型完全一致
           && (dc_mm == 0);                           // 暗通道 == 因果 KWIN x KWIN 盒式最小值

    // D3:输出标记仍是输入标记的延迟副本。默认模式的输入标记是窄脉冲,所以这一条
    // 同时证明"出去的 HS 仍是合格同步脉冲"——直连模式用 vin_hs_d[1] 能正常驱动
    // SiI9134,已证明 TX 要的就是脉冲而非整行电平。
    if (href_hs) begin
        pass = pass
               && (hs_minrun == H_SYNC_LEN)           // 仍是窄脉冲,没被撑成整行
               && (hs_maxrun == H_SYNC_LEN)           // 而且每一行宽度一致,没有毛刺
               && (hs_nrun > 0);
        $display("期望: 输出被真正变换;输出 HS 仍是每行 %0d 拍的窄脉冲(与源同步脉冲同形)",
                 H_SYNC_LEN);
    end
    else begin
        pass = pass
               && (hs_minrun == H_ACTIVE)             // 端口 href 是整行电平,输出跟着它
               && (hs_maxrun == H_ACTIVE);
        $display("期望: 输出被真正变换;端口 href 这里喂的是整行电平,输出同样跟随");
    end
    $display("  实测: 稳态 A=%0d, 透射率 %0d..%0d, 最佳延迟 D=%0d 最大偏差 %0d, 模型不符 %0d",
             ca_max2, ct_min2, ct_max2, best_d, best_delta, mod_mm);
    $display("  实测: 暗通道窗口 %0dx%0d 核对, 最佳延迟 %0d, 不符 %0d / %0d",
             KWIN, KWIN, dc_d, dc_mm, dc_tot);
    $display("  实测: post_frame_href 宽 %0d..%0d 拍, 共 %0d 个",
             hs_minrun, hs_maxrun, hs_nrun);

    if (pass) $display("RESULT: PASS");
    else      $display("RESULT: FAIL");
    $display("");
    $finish;
end

endmodule
