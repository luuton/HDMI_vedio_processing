module haze_removal_cal(
    input               clk                     ,
    input               rst_n                   ,  
    input               pre_src_frame_vsync     , 
    input               pre_src_frame_href      ,  
    input               pre_src_frame_clken     , 
    input   [23 : 0]    pre_img                 ,

    input               pre_tx_frame_vsync      ,
    input               pre_tx_frame_href       ,
    input               pre_tx_frame_clken      ,
    input   [7  : 0]    pre_tx_img              ,

    input   [7  : 0]    pre_A                   ,

    
    output              post_frame_vsync        , 
    output              post_frame_href         ,  
    output              post_frame_clken        , 
    output  [23 : 0]    post_img                
);
// `define Xilinx_IP

parameter   tx_min   =   8'd26;//A 的最小值,0.1 * 2*8

wire        [7  : 0]    tx_value                 ;
assign                  tx_value =    pre_tx_img < tx_min ? tx_min : pre_tx_img;

// 带符号的 (pre_img - A) 与 (A * tx) 项。图像差值必须用带符号运算:
// 大多数有雾像素满足 I < A,而无符号 8 位减法会回绕成
// 一个很大的正数。各项都在带符号 18 位以内,所以累加值
// value_tem = (I - A)*256 + A*tx 是精确的(范围 -65280 .. 130305,18 位可容纳)。
wire signed [8  : 0]    s_r     = $signed({1'b0, pre_img[23:16]}) - $signed({1'b0, pre_A});
wire signed [8  : 0]    s_g     = $signed({1'b0, pre_img[15: 8]}) - $signed({1'b0, pre_A});
wire signed [8  : 0]    s_b     = $signed({1'b0, pre_img[ 7: 0]}) - $signed({1'b0, pre_A});
wire signed [17 : 0]    a_tx    = $signed({10'b0, pre_A}) * $signed({10'b0, tx_value});

reg signed  [17 : 0]    value_tem_r             ;
reg signed  [17 : 0]    value_tem_g             ;
reg signed  [17 : 0]    value_tem_b             ;

reg         [7  : 0]    pre_A_d1                ;
reg         [7  : 0]    tx_value_d1              ;


always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        pre_A_d1                <=  0                       ;
        tx_value_d1             <=  0                       ;
    end
    else begin
        pre_A_d1                <=  pre_A                   ;
        tx_value_d1             <=  tx_value                ;
    end
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        value_tem_r     <=  0;
        value_tem_g     <=  0;
        value_tem_b     <=  0;
    end
    else begin
        // 定点还原的分子:value_tem = (I - A)*256 + A*tx(带符号)。
        value_tem_r     <=  ( s_r * 18'sd256 ) + a_tx;
        value_tem_g     <=  ( s_g * 18'sd256 ) + a_tx;
        value_tem_b     <=  ( s_b * 18'sd256 ) + a_tx;
    end
end

`ifdef Xilinx_IP
    wire  signed    [10 : 0]    post_img_r;
    wire  signed    [10 : 0]    post_img_g;
    wire  signed    [10 : 0]    post_img_b;
    wire            [7  : 0]    temp_r;
    wire            [7  : 0]    temp_g;
    wire            [7  : 0]    temp_b;

    integer i;

    reg                     pre_tx_frame_vsync_d      [36:0] ;
    reg                     pre_tx_frame_href_d       [36:0] ;
    reg                     pre_tx_frame_clken_d      [36:0] ;

    div_gen_0 u_div_gen_0(
    .aclk                     (clk    ),                                      // 输入 wire aclk
    .s_axis_divisor_tvalid    (1      ),    // 输入 wire s_axis_divisor_tvalid
    .s_axis_divisor_tdata     (tx_value_d1),      // 输入 wire [7 : 0] s_axis_divisor_tdata
    .s_axis_dividend_tvalid   (1),  // 输入 wire s_axis_dividend_tvalid
    .s_axis_dividend_tdata    (value_tem_r),    // 输入 wire [39 : 0] s_axis_dividend_tdata
    .m_axis_dout_tvalid       (),          // 输出 wire m_axis_dout_tvalid
    .m_axis_dout_tdata        ({post_img_r,temp_r})            // 输出 wire [47 : 0] m_axis_dout_tdata
    );
    div_gen_0 u_div_gen_1(
    .aclk                     (clk    ),                                      // 输入 wire aclk
    .s_axis_divisor_tvalid    (1      ),    // 输入 wire s_axis_divisor_tvalid
    .s_axis_divisor_tdata     (tx_value_d1),      // 输入 wire [7 : 0] s_axis_divisor_tdata
    .s_axis_dividend_tvalid   (1),  // 输入 wire s_axis_dividend_tvalid
    .s_axis_dividend_tdata    (value_tem_g),    // 输入 wire [39 : 0] s_axis_dividend_tdata
    .m_axis_dout_tvalid       (),          // 输出 wire m_axis_dout_tvalid
    .m_axis_dout_tdata        ({post_img_g,temp_g})            // 输出 wire [47 : 0] m_axis_dout_tdata
    );
    div_gen_0 u_div_gen_2(
    .aclk                     (clk    ),                                      // 输入 wire aclk
    .s_axis_divisor_tvalid    (1      ),    // 输入 wire s_axis_divisor_tvalid
    .s_axis_divisor_tdata     (tx_value_d1),      // 输入 wire [7 : 0] s_axis_divisor_tdata
    .s_axis_dividend_tvalid   (1),  // 输入 wire s_axis_dividend_tvalid
    .s_axis_dividend_tdata    (value_tem_b),    // 输入 wire [39 : 0] s_axis_dividend_tdata
    .m_axis_dout_tvalid       (),          // 输出 wire m_axis_dout_tvalid
    .m_axis_dout_tdata        ({post_img_b,temp_b})            // 输出 wire [47 : 0] m_axis_dout_tdata
    );

    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            for(i = 0; i < 37; i = i + 1) begin
                pre_tx_frame_vsync_d[i]   <=  0                       ;
                pre_tx_frame_href_d[i]    <=  0                       ;
                pre_tx_frame_clken_d[i]   <=  0                       ;
            end
        end
        else begin
            pre_tx_frame_vsync_d[0]     <=  pre_tx_frame_vsync      ;
            pre_tx_frame_href_d[0]      <=  pre_tx_frame_href       ;
            pre_tx_frame_clken_d[0]     <=  pre_tx_frame_clken      ;
            for(i = 1; i < 37; i = i + 1) begin
                pre_tx_frame_vsync_d[i]     <=  pre_tx_frame_vsync_d[i-1] ;
                pre_tx_frame_href_d[i]      <=  pre_tx_frame_href_d[i-1]  ;
                pre_tx_frame_clken_d[i]     <=  pre_tx_frame_clken_d[i-1] ;
            end
        end
    end
    
    assign  post_img            =   {post_img_b[7 : 0],post_img_g[7 : 0],post_img_r[7 : 0]}     ;
    assign  post_frame_vsync    =   pre_tx_frame_vsync_d[36]                                    ;
    assign  post_frame_href     =   pre_tx_frame_href_d[36]                                     ;
    assign  post_frame_clken    =   pre_tx_frame_clken_d[36]                                    ;
`else

    // 用倒数表代替组合逻辑的 18/8 除法。原来的除法器在
    // 148.5 MHz 下、6.734 ns 的周期里需要约 32 ns,而且是实现(implementation)中
    // 最糟糕的失败路径 (value_tem_r_reg[*] -> post_img_*_reg[*])。
    // recip[v] = round(2^16 / v);tx_value 在到达这里之前已被钳到下限 tx_min = 26,
    // 所以 26 以下的表项不可达,它们镜像 v = 26 以保持在 12 位以内。
    // 代价:每通道一次 LUTRAM 读 + 一个 DSP48,以及 1 个额外周期延迟
    // (在模块内部被吸收 —— src 和 tx 进入本模块时已经对齐)。
    reg     [11 : 0]    recip_rom   [0:255];
    integer             ri;
    initial begin
        for(ri = 0; ri < 256; ri = ri + 1)
            if(ri < 26) recip_rom[ri] = 12'd2521;
            else        recip_rom[ri] = (65536 + (ri >> 1)) / ri;
    end

    reg         [11 : 0]    recip_r                 ;
    reg     signed [29 : 0] prod_r                  ;
    reg     signed [29 : 0] prod_g                  ;
    reg     signed [29 : 0] prod_b                  ;

    reg         [7  : 0]    post_img_r;
    reg         [7  : 0]    post_img_g;
    reg         [7  : 0]    post_img_b;
    reg                     pre_tx_frame_vsync_d1   ;
    reg                     pre_tx_frame_href_d1    ;
    reg                     pre_tx_frame_clken_d1   ;
    reg                     pre_tx_frame_vsync_d2   ;
    reg                     pre_tx_frame_href_d2    ;
    reg                     pre_tx_frame_clken_d2   ;
    reg                     pre_tx_frame_vsync_d3   ;
    reg                     pre_tx_frame_href_d3    ;
    reg                     pre_tx_frame_clken_d3   ;

    // 查倒数表并打一拍寄存,使 LUTRAM 读不落在乘法路径上
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)  recip_r <=  12'd0;
        else        recip_r <=  recip_rom[tx_value_d1];
    end

    // value_tem 是带符号 18 位(|v| <= 130305),recip 是 12 位(<= 2521),所以
    // 乘积 < 2^29,可用带符号 30 位容纳。每通道一个 DSP48。
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            prod_r  <=  30'sd0;
            prod_g  <=  30'sd0;
            prod_b  <=  30'sd0;
        end
        else begin
            prod_r  <=  value_tem_r * $signed({6'b0, recip_r});
            prod_g  <=  value_tem_g * $signed({6'b0, recip_r});
            prod_b  <=  value_tem_b * $signed({6'b0, recip_r});
        end
    end

    // 还原除法 J = value_tem / tx 的带符号商,再按 2^16
    // 缩放回去,采用四舍五入。保持带符号,以便负结果(像素比 A 更暗)
    // 可在使用前被检出并做饱和。
    wire signed [29 : 0]    qsum_r  =   prod_r + 30'sd32768;
    wire signed [29 : 0]    qsum_g  =   prod_g + 30'sd32768;
    wire signed [29 : 0]    qsum_b  =   prod_b + 30'sd32768;
    wire signed [17 : 0]    q_r     =   qsum_r >>> 16;
    wire signed [17 : 0]    q_g     =   qsum_g >>> 16;
    wire signed [17 : 0]    q_b     =   qsum_b >>> 16;

    // 把还原结果饱和到 [0, 255];tx 有下限(>= tx_min),
    // 所以 q 是有限的。q_r[17] 是符号位 -> 负数钳到 0。
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            post_img_r      <=  8'd0;
            post_img_g      <=  8'd0;
            post_img_b      <=  8'd0;
        end
        else begin
            post_img_r      <=  (q_r > 18'sd255) ? 8'hff : (q_r[17] ? 8'h00 : q_r[7:0]);
            post_img_g      <=  (q_g > 18'sd255) ? 8'hff : (q_g[17] ? 8'h00 : q_g[7:0]);
            post_img_b      <=  (q_b > 18'sd255) ? 8'hff : (q_b[17] ? 8'h00 : q_b[7:0]);
        end
    end

    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            pre_tx_frame_vsync_d1   <=  0                       ;
            pre_tx_frame_href_d1    <=  0                       ;
            pre_tx_frame_clken_d1   <=  0                       ;
            pre_tx_frame_vsync_d2   <=  0                       ;
            pre_tx_frame_href_d2    <=  0                       ;
            pre_tx_frame_clken_d2   <=  0                       ;
            pre_tx_frame_vsync_d3   <=  0                       ;
            pre_tx_frame_href_d3    <=  0                       ;
            pre_tx_frame_clken_d3   <=  0                       ;
        end
        else begin
            pre_tx_frame_vsync_d1   <=  pre_tx_frame_vsync      ;
            pre_tx_frame_href_d1    <=  pre_tx_frame_href       ;
            pre_tx_frame_clken_d1   <=  pre_tx_frame_clken      ;
            pre_tx_frame_vsync_d2   <=  pre_tx_frame_vsync_d1   ;
            pre_tx_frame_href_d2    <=  pre_tx_frame_href_d1    ;
            pre_tx_frame_clken_d2   <=  pre_tx_frame_clken_d1   ;
            pre_tx_frame_vsync_d3   <=  pre_tx_frame_vsync_d2   ;
            pre_tx_frame_href_d3    <=  pre_tx_frame_href_d2    ;
            pre_tx_frame_clken_d3   <=  pre_tx_frame_clken_d2   ;
        end
    end

    assign  post_img            =   {post_img_r[7 : 0],post_img_g[7 : 0],post_img_b[7 : 0]}     ;
    assign  post_frame_vsync    =   pre_tx_frame_vsync_d3                                       ;
    assign  post_frame_href     =   pre_tx_frame_href_d3                                        ;
    assign  post_frame_clken    =   pre_tx_frame_clken_d3                                       ;

`endif                                   


endmodule
