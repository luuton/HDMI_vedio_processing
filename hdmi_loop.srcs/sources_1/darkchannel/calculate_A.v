module calculate_A(
        input           clk                 ,
        input           rst_n               ,  
        input           pre_frame_vsync     , 
        input           pre_frame_href      ,  
        input           pre_frame_clken     , 
        input   [23:0]  pre_img             ,       
        output          post_frame_vsync    , 
        output          post_frame_href     ,  
        output          post_frame_clken    ,
        output  [7 :0]  post_result         , 
        output          post_done
);

reg     [7 : 0]     A_value                 ;
reg     [7 : 0]     A_value_out             ;
reg                 A_value_valid           ;

reg                 pre_frame_vsync_d1      ; 
reg                 pre_frame_href_d1       ;  
reg                 pre_frame_clken_d1      ; 



wire    [7 : 0]     pixel_of_r;
wire    [7 : 0]     pixel_of_g;
wire    [7 : 0]     pixel_of_b;
wire    [7 : 0]     pixel_max_of_rgb_1st;
wire    [7 : 0]     pixel_max_of_rgb_2st;

assign      pixel_of_r  =   pre_img[23 : 16];
assign      pixel_of_g  =   pre_img[15 :  8];
assign      pixel_of_b  =   pre_img[ 7 :  0];

assign  pixel_max_of_rgb_1st    =   pixel_of_r > pixel_of_g ? pixel_of_r : pixel_of_g;
assign  pixel_max_of_rgb_2st    =   pixel_of_b > pixel_max_of_rgb_1st ? pixel_of_b : pixel_max_of_rgb_1st;


always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        A_value <=  0;
    end
    // 每帧估计 A:在 vsync 下降沿清空累加器(上一帧
    // 像素一处理完就清),然后只在当前帧上
    // 重新累加通道最大值。没有这个复位,A_value 会漂向
    // 历史全局最大值,场景切换时就永远得不到新的大气光估计。
    else if(pre_frame_vsync_d1 & !pre_frame_vsync) begin
        A_value <=  0;
    end
    else if(pre_frame_href & pre_frame_clken) begin
        A_value <=  A_value > pixel_max_of_rgb_2st ? A_value : pixel_max_of_rgb_2st;
    end
end


always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        pre_frame_vsync_d1      <=  0               ;
        pre_frame_href_d1       <=  0               ;
        pre_frame_clken_d1      <=  0               ;
    end
    else begin
        pre_frame_vsync_d1      <=  pre_frame_vsync ;
        pre_frame_href_d1       <=  pre_frame_href  ;
        pre_frame_clken_d1      <=  pre_frame_clken ;
    end
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        A_value_out <=  8'd230;
    end
    else if(pre_frame_vsync_d1 & !pre_frame_vsync)begin
        // 下限 1 用于防止 A = 0(全黑帧),那会让
        // 下游以 A 为除数的除法除零,从而毁掉整帧。
        A_value_out <=  (A_value > 8'd1) ? A_value : 8'd1;
    end
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        A_value_valid   <=  0;
    end
    else if(pre_frame_vsync_d1 & !pre_frame_vsync)begin
        A_value_valid   <=  1;
    end
    else begin
        A_value_valid   <=  0;
    end
end



assign  post_frame_vsync    =   pre_frame_vsync_d1  ;
assign  post_frame_href     =   pre_frame_href_d1   ;
assign  post_frame_clken    =   pre_frame_clken_d1  ;
assign  post_result         =   A_value_out         ;
assign  post_done           =   A_value_valid       ;

endmodule