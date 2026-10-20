module tx_get(
        input               clk                 ,
        input               rst_n               ,
        input               pre_frame_vsync     ,
        input               pre_frame_href      ,
        input               pre_frame_clken     ,
        input   [7  : 0]    pre_img             ,
        input   [7  : 0]    A_value             ,
        output              post_frame_vsync    ,
        output              post_frame_href     ,
        output              post_frame_clken    ,
        output  [7  : 0]    post_img
);

// modification_value = omega * 2^8,即 He et al. 的 t = 1 - omega*(dc/A) 中的 omega。
// 243 = floor(0.95*2^8) 是论文的取值,也是此前出厂的默认值;
// 本工程改用 218 = round(0.85*2^8)。
//
// 原因:论文的系数能去雾,但画面偏暗,而这份残留的暗
// 不是 bug —— 它正是模型所隐含的结果。基于
// tools/out.avi_20260921_212043.311.jpg 恢复出的源上实测(该帧亮度 143):
//   omega=0.95 -> 输出亮度  52.5   (He et al. 自己的设置给出 60.0)
//   omega=0.85 -> 输出亮度  81.5
//   omega=0.75 -> 输出亮度  98.6
// 所以 0.85 用约 25% 更少的局部对比度增益换来 +55% 的输出亮度。
// 用户反馈的偏色也随之下降:输出的 R-B 差值是源自身的 R-B
// (该帧中仅 +5.2,即接近中性)乘以去雾所施加的同一个 1/t 增益,
// 所以它几乎完全跟随对比度增益(R-B 在
// omega=0.95 时为 +15.6,在 0.85 时为 +11.9,基于 RTL 实际实现的因果窗口)。
// 对暖色调的雾去雾会放大这种色调;这不是通道交换,
// RTL 里也不存在通道交换。
//
// 被 haze_removal_top 的 MODIFICATION_VALUE 覆盖。
parameter modification_value = 16'd218;

// 透射率下限。原来这个钳位在 haze_removal_cal 的入路上
// (`pre_tx_img < 26 ? 26 : pre_tx_img`),实现出来是 LUT4+LUT4+LUT2
// 三级加约 1.1 ns 布线,正好落在 post_img_r -> A*tx -> value_tem 这条
// 已经差 0.134 ns 的路径上。把钳位并进这一级的饱和判断(见下),
// 下游就只剩乘法,而且**不增加任何延迟**(本拍本来就要寄存)。
// 必须与 haze_removal_cal 的 tx_min 一致,由顶层统一传入。
parameter tx_min = 8'd26;

// 用倒数表代替组合逻辑的 16/8 除法。原来的除法器需要远
// 多于一个 6.734 ns 周期(148.5 MHz),属于最严重的失败路径之一。
// recip[v] = round(2^16 / v)。调用方把 v 的下限钳到 tx_min = 26,所以
// 26 以下的表项不可达;它们镜像 v = 26,以保证每个表项都在 12 位以内。
// 代价:一次 LUTRAM 读 + 一次 DSP48 乘法,以及固定的额外 2 个周期延迟
// (time_alignment.src_delay 必须等于本模块的总延迟)。
reg     [11 : 0]    recip_rom   [0:255];
integer             ri;
initial begin
    for(ri = 0; ri < 256; ri = ri + 1)
        if(ri < 26) recip_rom[ri] = 12'd2521;
        else        recip_rom[ri] = (65536 + (ri >> 1)) / ri;
end

reg         [15 : 0]    modify_A            ;
reg         [11 : 0]    recip_r             ;
reg         [27 : 0]    tx_prod_r           ;
reg         [15 : 0]    tx_q_r              ;
reg         [7  : 0]    post_img_r          ;

reg                     pre_frame_vsync_d1  ;
reg                     pre_frame_href_d1   ;
reg                     pre_frame_clken_d1  ;
reg                     pre_frame_vsync_d2  ;
reg                     pre_frame_href_d2   ;
reg                     pre_frame_clken_d2  ;
reg                     pre_frame_vsync_d3  ;
reg                     pre_frame_href_d3   ;
reg                     pre_frame_clken_d3  ;
reg                     pre_frame_vsync_d4  ;
reg                     pre_frame_href_d4   ;
reg                     pre_frame_clken_d4  ;
reg                     pre_frame_vsync_d5  ;
reg                     pre_frame_href_d5   ;
reg                     pre_frame_clken_d5  ;
reg         [7  : 0]    A_value_d1          ;

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        modify_A    <=  0;
    end
    else begin
        modify_A    <=  pre_img * modification_value;   //显式 16 位乘法,最大 255*218=55590
    end
end


always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        pre_frame_vsync_d1      <=  0                   ;
        pre_frame_href_d1       <=  0                   ;
        pre_frame_clken_d1      <=  0                   ;
        pre_frame_vsync_d2      <=  0                   ;
        pre_frame_href_d2       <=  0                   ;
        pre_frame_clken_d2      <=  0                   ;
        pre_frame_vsync_d3      <=  0                   ;
        pre_frame_href_d3       <=  0                   ;
        pre_frame_clken_d3      <=  0                   ;
        pre_frame_vsync_d4      <=  0                   ;
        pre_frame_href_d4       <=  0                   ;
        pre_frame_clken_d4      <=  0                   ;
        pre_frame_vsync_d5      <=  0                   ;
        pre_frame_href_d5       <=  0                   ;
        pre_frame_clken_d5      <=  0                   ;
        A_value_d1              <=  0                   ;
    end
    else begin
        pre_frame_vsync_d1      <=  pre_frame_vsync     ;
        pre_frame_href_d1       <=  pre_frame_href      ;
        pre_frame_clken_d1      <=  pre_frame_clken     ;
        pre_frame_vsync_d2      <=  pre_frame_vsync_d1  ;
        pre_frame_href_d2       <=  pre_frame_href_d1   ;
        pre_frame_clken_d2      <=  pre_frame_clken_d1  ;
        pre_frame_vsync_d3      <=  pre_frame_vsync_d2  ;
        pre_frame_href_d3       <=  pre_frame_href_d2   ;
        pre_frame_clken_d3      <=  pre_frame_clken_d2  ;
        pre_frame_vsync_d4      <=  pre_frame_vsync_d3  ;
        pre_frame_href_d4       <=  pre_frame_href_d3   ;
        pre_frame_clken_d4      <=  pre_frame_clken_d3  ;
        pre_frame_vsync_d5      <=  pre_frame_vsync_d4  ;
        pre_frame_href_d5       <=  pre_frame_href_d4   ;
        pre_frame_clken_d5      <=  pre_frame_clken_d4  ;
        A_value_d1              <=  A_value             ;
    end
end

// 1) 查倒数表并打一拍寄存,使 LUTRAM 读不落在乘法路径上
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)  recip_r     <=  12'd0;
    else        recip_r     <=  recip_rom[A_value_d1];
end

// 2) 一个 DSP48:最大 55590 * 2521 = 140,142,390 < 2^28
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)  tx_prod_r   <=  28'd0;
    else        tx_prod_r   <=  modify_A * recip_r;
end

// 3) 除以 2^16(四舍五入;对 0..218 的结果 ±1 LSB 远低于
//    tx 中本就存在的 /256 量化),并做饱和而不是回绕。
//
//    tx_q > 255 意味着 omega*dc/A > 1,即透射率估计
//    变成了负值。这是可达的,而且并不罕见:A 有一帧的滞后
//    (calculate_A 在 vsync 时锁存它),所以任何比上一帧 A
//    更亮的像素都会触发 —— 场景切换到更亮的画面、一次闪光,
//    或复位后的第一帧(此时 A_value_out 仍保持复位默认值 8'd230)。
//    这种情况下正确答案是"该像素不去雾":t = 1,J = I。
//
//    这里此前钳到 8'd0,在兜底之前是 255 - 0 = 255,但到了
//    haze_removal_cal 里会变成 tx_min = 26 —— t = 26/256,即最小
//    透射率,因而也就是最大去雾。这与钳位所声称的意图正好相反,
//    而且是对场景变化最糟糕的响应:它恰好把那些估计值刚刚
//    超出量程的像素变黑。
//    8'd255 才是表示"不去雾"的取值。
//
//    [时序] 这一级的和、饱和判断曾经全是组合逻辑,和下游
//    calculate_A 的 a_tx = A*tx 乘法、加上跨模块布线凑成一条
//    8.75 ns 的路径(要求 6.734 ns),是 vin_clk 域 31 个失败端点的
//    唯一来源。现在分两刀切:
//      第一刀:把 (tx_prod_r + 32768) >> 16 单独打一拍(tx_q_r),
//              断开 DSP 输出与下游乘法;
//      第二刀:把饱和判断也从下一级的主路径上摘出来(post_img_r),
//              否则 tx_q_r -> 饱和 mux -> 跨模块 -> A*tx -> value_tem
//              仍有约 6.8 ns,差 0.3 ns 凑不拢(实测 7 个失败端点)。
//    代价:tx 通路共 5 拍,故下面的控制信号加到 d5,
//    time_alignment.src_delay 里的 "+ 4" 改成 "+ 5"。
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)  tx_q_r  <=  16'd0;
    else        tx_q_r  <=  (tx_prod_r + 28'd32768) >> 16;
end

// 饱和 + 透射率下限,合成一次寄存。
// 三个区间:tx_q > 255 -> 不去雾(t=255);255-tx_q < tx_min -> 钳到 tx_min;
// 其余 -> t = 255 - tx_q。三者在数学上等价于
// haze_removal_cal 原来的 saturate() 后再 max(tx_min)。
wire [15 : 0] tx_lim = 16'd255 - tx_min;   // = 229

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)  post_img_r  <=  8'd0;
    else        post_img_r  <=  (tx_q_r > 16'd255) ? 8'd255      :
                                (tx_q_r > tx_lim)  ? tx_min      :
                                                     (8'd255 - tx_q_r[7:0]);
end

assign      post_frame_vsync    =   pre_frame_vsync_d5  ;
assign      post_frame_href     =   pre_frame_href_d5   ;
assign      post_frame_clken    =   pre_frame_clken_d5  ;
assign      post_img            =   post_img_r          ;

endmodule
