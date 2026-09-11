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

parameter modification_value = 16'd243;   //modification_value = floor(0.95*2^8) = 243

// Reciprocal table instead of a combinational 16/8 divide. The divider needed far
// more than one 6.734 ns period at 148.5 MHz and was among the worst failing paths.
// recip[v] = round(2^16 / v). v is floored at tx_min = 26 by the caller, so entries
// below 26 are unreachable; they mirror v = 26 to keep every entry inside 12 bits.
// Cost: one LUTRAM read + one DSP48 multiply, and a fixed 2 extra cycles of latency
// (time_alignment.src_delay must stay equal to this module's total latency).
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

reg                     pre_frame_vsync_d1  ;
reg                     pre_frame_href_d1   ;
reg                     pre_frame_clken_d1  ;
reg                     pre_frame_vsync_d2  ;
reg                     pre_frame_href_d2   ;
reg                     pre_frame_clken_d2  ;
reg                     pre_frame_vsync_d3  ;
reg                     pre_frame_href_d3   ;
reg                     pre_frame_clken_d3  ;
reg         [7  : 0]    A_value_d1          ;

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        modify_A    <=  0;
    end
    else begin
        modify_A    <=  pre_img * modification_value;   //explicit 16-bit mult, max 255*243=61965
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
        A_value_d1              <=  A_value             ;
    end
end

// 1) reciprocal lookup, registered so the LUTRAM read stays off the multiply path
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)  recip_r     <=  12'd0;
    else        recip_r     <=  recip_rom[A_value_d1];
end

// 2) one DSP48: max 61965 * 2521 = 156,213,765 < 2^28
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)  tx_prod_r   <=  28'd0;
    else        tx_prod_r   <=  modify_A * recip_r;
end

// 3) divide by 2^16 (round to nearest; +-1 LSB on a 0..243 result is well below the
//    /256 quantisation already present in tx) and saturate instead of wrapping.
//    tx_q > 255 only happens when the scene is brighter than the previous frame's A
//    (dc > A right after a scene change); clamp those to 0 = fully hazy. Normal
//    in-frame operation is unchanged and the downstream tx_min floor still applies.
wire    [15 : 0]    tx_q    =   (tx_prod_r + 28'd32768) >> 16;

assign      post_frame_vsync    =   pre_frame_vsync_d3  ;
assign      post_frame_href     =   pre_frame_href_d3   ;
assign      post_frame_clken    =   pre_frame_clken_d3  ;
assign      post_img            =   (tx_q > 16'd255) ? 8'd0 : (8'd255 - tx_q[7:0]);

endmodule
