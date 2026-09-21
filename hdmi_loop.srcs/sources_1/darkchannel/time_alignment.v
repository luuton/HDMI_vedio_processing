module time_alignment(
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
        output              post_src_frame_vsync    , 
        output              post_src_frame_href     ,  
        output              post_src_frame_clken    , 
        output  [23 : 0]    post_img                ,

        output              post_tx_frame_vsync     ,
        output              post_tx_frame_href      ,
        output              post_tx_frame_clken     ,
        output  [7  : 0]    post_tx_img             ,

        output  [7  : 0]    post_A                   
);
integer i;

// 必须等于 tx 通路的总延迟(src_min 1 + WINDOW_PASSES * 4 +
// tx_get 3),这样被延迟的 src 才能与透射率图对齐,否则
// 画面与它自己的透射率图会水平错位,去雾就会
// 拖影。这两个数字以前都变过:tx_get 在把它的
// 组合逻辑除法换成寄存的倒数乘法时多了 2 个周期(6 -> 8),而每多
// 一级暗通道窗口处理又多 4 个(8 -> 16,对应 WINDOW_PASSES = 3)。
//
// 这里是推导出来的而不是写死的,这样两者就不会漂移 —— 以前
// 手工维护的 8 加上"改一个就得改另一个"的注释是个陷阱,
// 只有仿真才能发现。WINDOW_PASSES 必须与 dark_channel 的一致。
parameter WINDOW_PASSES = 3;
parameter src_delay = 1 + 4 * WINDOW_PASSES + 3;

reg                         pre_src_frame_vsync_d[src_delay - 1 : 0]    ;
reg                         pre_src_frame_href_d[src_delay - 1 : 0]     ;
reg                         pre_src_frame_clken_d[src_delay - 1 : 0]    ;
reg     [23 : 0]            pre_img_d[src_delay - 1 : 0]                ;

//src_delay
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        for(i = 0; i< src_delay; i = i + 1)begin
            pre_src_frame_vsync_d   [ i ]   <=    0;
            pre_src_frame_href_d    [ i ]   <=    0;
            pre_src_frame_clken_d   [ i ]   <=    0;
            pre_img_d               [ i ]   <=    0;
        end
    end
    else begin
        pre_src_frame_vsync_d   [ 0 ]          <=    pre_src_frame_vsync               ;
        pre_src_frame_href_d    [ 0 ]          <=    pre_src_frame_href                ;
        pre_src_frame_clken_d   [ 0 ]          <=    pre_src_frame_clken               ;
        pre_img_d               [ 0 ]          <=    pre_img                           ;
        for(i = 1; i< src_delay; i = i + 1)begin
            pre_src_frame_vsync_d   [ i ]      <=    pre_src_frame_vsync_d  [ i - 1 ]  ;
            pre_src_frame_href_d    [ i ]      <=    pre_src_frame_href_d   [ i - 1 ]  ;
            pre_src_frame_clken_d   [ i ]      <=    pre_src_frame_clken_d  [ i - 1 ]  ;
            pre_img_d               [ i ]      <=    pre_img_d              [ i - 1 ]  ;
        end
    end
end

assign      post_src_frame_vsync    =   pre_src_frame_vsync_d   [ src_delay - 1 ]   ;
assign      post_src_frame_href     =   pre_src_frame_href_d    [ src_delay - 1 ]   ; 
assign      post_src_frame_clken    =   pre_src_frame_clken_d   [ src_delay - 1 ]   ;
assign      post_img                =   pre_img_d               [ src_delay - 1 ]   ;            



assign      post_tx_frame_vsync     =   pre_tx_frame_vsync      ;
assign      post_tx_frame_href      =   pre_tx_frame_href       ;
assign      post_tx_frame_clken     =   pre_tx_frame_clken      ;
assign      post_tx_img             =   pre_tx_img              ;

assign      post_A                  =   pre_A;


endmodule
