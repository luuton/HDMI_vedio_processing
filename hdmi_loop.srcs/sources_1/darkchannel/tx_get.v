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

reg         [15 : 0]    modify_A            ;

reg                     pre_frame_vsync_d1  ;
reg                     pre_frame_href_d1   ;
reg                     pre_frame_clken_d1  ;
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
        A_value_d1              <=  0                   ;
    end
    else begin
        pre_frame_vsync_d1      <=  pre_frame_vsync     ;
        pre_frame_href_d1       <=  pre_frame_href      ;
        pre_frame_clken_d1      <=  pre_frame_clken     ;
        A_value_d1              <=  A_value             ;
    end
end


wire    [15 : 0]    tx_q    =   modify_A / A_value_d1;  //floor(243*dc/A); <=243 while dc<=A (same frame)
assign      post_frame_vsync    =   pre_frame_vsync_d1  ;
assign      post_frame_href     =   pre_frame_href_d1   ;
assign      post_frame_clken    =   pre_frame_clken_d1  ;
// If the scene is brighter than the previous frame's A (dc > A right after a scene
// change), tx_q may exceed 255 and the unsigned 255-q below would wrap; saturate to
// 0 instead (= fully hazy). The downstream tx_min floor in haze_removal_cal applies,
// so normal in-frame operation is unchanged.
assign      post_img            =   (tx_q > 16'd255) ? 8'd0 : (8'd255 - tx_q[7:0]);

endmodule
