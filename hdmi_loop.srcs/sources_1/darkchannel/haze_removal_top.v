module haze_removal_top#(
        parameter Y_ENHANCE_ENABLE = 0          ,
        parameter PIC_WIDTH        = 1920       ,
        // 暗通道窗口:级联的 3x3 最小值处理,(2*W+1)^2 的方框。3 -> 7x7。
        // 由 dark_channel 和 time_alignment 共用,这样窗口大小与
        // tx 通路延迟永远不会不一致;7x7 背后的实测依据
        // 见 dark_channel.v。
        parameter WINDOW_PASSES    = 3          ,
        // t = 1 - omega*(dc/A) 里的 omega * 2^8。218 = round(0.85*2^8)。
        // He et al. 的 0.95(243)是更强、更暗的设置;实测的
        // 亮度/对比度/偏色取舍见 tx_get.v。
        parameter MODIFICATION_VALUE = 16'd218
)(
        input           clk                     ,
        input           rst_n                   ,
        //待处理的图像数据
        input           pre_frame_vsync         ,
        input           pre_frame_href          ,
        input           pre_frame_clken         ,
        input   [23:0]  pre_img                 ,
        //已处理的图像数据 
        output          post_frame_vsync        , 
        output          post_frame_href         ,  
        output          post_frame_clken        , 
        output  [23:0]  post_img                
);

wire                 dark_channel_frame_vsync    ;
wire                 dark_channel_frame_href     ; 
wire                 dark_channel_frame_clken    ;
wire    [7  : 0]     dark_channel_img            ; 
     
wire                 src_cal_A_frame_vsync       ;
wire                 src_cal_A_frame_href        ; 
wire                 src_cal_A_frame_clken       ;
wire    [7  : 0]     src_cal_A_result            ; 
wire                 src_cal_A_valid             ; 
     
wire                 src_tx_frame_vsync          ;
wire                 src_tx_frame_href           ; 
wire                 src_tx_frame_clken          ;
wire    [7  : 0]     src_tx_img                  ; 
     
wire                 cal_src_frame_vsync         ;
wire                 cal_src_frame_href          ;
wire                 cal_src_frame_clken         ;
wire    [23 : 0]     cal_img                     ;
wire                 cal_tx_frame_vsync          ;
wire                 cal_tx_frame_href           ;
wire                 cal_tx_frame_clken          ;
wire    [7  : 0]     cal_tx_img                  ;
wire    [7  : 0]     cal_A                       ;

// ---------------------------------------------------------------------------
// href_line —— 去雾数据通路所需的行有效选通
//
// pre_frame_href 接的是 HDMI 接收器的 HSYNC 引脚,它是水平消隐期内的
// 一根窄脉冲,不是行有效电平。在 1080p60 下
// (CEA-861 VIC 16,正极性 H),它在全部 1920 个有效像素期间
// 都是低电平,所以任何以它为选通的模块都会停摆:
//   matrix_generate_3x3  read_frame_href 为低时把 3x3 窗口强制清零
//   src_min / calculate_A  以 href & clken 选通,而脉冲落在消隐期内,
//                          那里的 clken(DE)为 0 —— 这个与永远不成立
// 于是暗通道读到 0,t 饱和到 255,J = I 只差 1 个 LSB,
// 也就是输出是源的一份拷贝。已在
// tools/tb_haze_removal_top.v 中实测并复现(它的默认模式驱动的正是板上的接法)。
//
// 因此数据通路改为由 DE 电平选通。pre_frame_href 并没有被直接替换掉:
// 交给 HDMI 发送器的输出标记必须仍然是一根真正的同步脉冲
// (旁路通路从 vin_hs_d[1] 驱动它,SiI9134 锁定到它),
// 所以这根脉冲是在数据通路之后重新注入的,而不是由 href_line 派生 ——
// 见下面的说明。
// ---------------------------------------------------------------------------
wire href_line = pre_frame_clken;

// pre_frame_href 仍由 time_alignment 的 src 通路传递,该通路把它延迟
// src_delay —— 与 cal_img 完全相同 —— 并以
// cal_src_frame_href 输出。从那里起,haze_removal_cal 自带的 3 级标记寄存器让它
// 与 post_img 同步延迟,因此无论
// src_delay 取多少,脉冲都始终与画面对齐。把 pre_tx_frame_href 接成 cal_tx_frame_href
// 正是当初 bug 的做法:该网络被 href_line 选通,于是退化成一根 1920 周期的
// "脉冲"。cal_tx_frame_href 现已不用;保留接线是为了让
// time_alignment 的 tx 通路的意图仍可读。
dark_channel#(
        .PIC_WIDTH              (PIC_WIDTH                      ),
        .WINDOW_PASSES          (WINDOW_PASSES                  )
)u_dark_channel(
        .clk                    (clk                            ),
        .rst_n                  (rst_n                          ),
        //待处理的图像数据
        .pre_frame_vsync        (pre_frame_vsync                ),
        .pre_frame_href         (href_line                      ),
        .pre_frame_clken        (pre_frame_clken                ),
        .pre_img                (pre_img                        ),
        //已处理的图像数据 
        .post_frame_vsync       (dark_channel_frame_vsync       ), 
        .post_frame_href        (dark_channel_frame_href        ),  
        .post_frame_clken       (dark_channel_frame_clken       ), 
        .post_img               (dark_channel_img               )
);

calculate_A u_calculate_A(
        .clk                    (clk                            ),
        .rst_n                  (rst_n                          ),  
        //待处理的图像数据
        .pre_frame_vsync        (pre_frame_vsync                ),
        .pre_frame_href         (href_line                      ),
        .pre_frame_clken        (pre_frame_clken                ),
        .pre_img                (pre_img                        ),
        //已处理的图像数据
        .post_frame_vsync       (src_cal_A_frame_vsync          ),
        .post_frame_href        (src_cal_A_frame_href           ),  
        .post_frame_clken       (src_cal_A_frame_clken          ),
        .post_result            (src_cal_A_result               ), 
        .post_done              (src_cal_A_valid                )
);

tx_get#(
        .modification_value     (MODIFICATION_VALUE             )
)u_tx_get(
        .clk                    (clk                            ),
        .rst_n                  (rst_n                          ), 
        //待处理的图像数据
        .pre_frame_vsync        (dark_channel_frame_vsync       ),
        .pre_frame_href         (dark_channel_frame_href        ), 
        .pre_frame_clken        (dark_channel_frame_clken       ),
        .pre_img                (dark_channel_img               ),
        .A_value                (src_cal_A_result               ),
        //已处理的图像数据 
        .post_frame_vsync       (src_tx_frame_vsync             ),
        .post_frame_href        (src_tx_frame_href              ),
        .post_frame_clken       (src_tx_frame_clken             ),
        .post_img               (src_tx_img                     )
);

time_alignment#(
        .WINDOW_PASSES          (WINDOW_PASSES                  )
)u_time_alignment(
        .clk                    (clk                            ),
        .rst_n                  (rst_n                          ),
        //待处理的图像数据
        .pre_src_frame_vsync    (pre_frame_vsync                ), 
        .pre_src_frame_href     (pre_frame_href                 ),
        .pre_src_frame_clken    (pre_frame_clken                ), 
        .pre_img                (pre_img                        ),

        .pre_tx_frame_vsync     (src_tx_frame_vsync             ),
        .pre_tx_frame_href      (src_tx_frame_href              ),
        .pre_tx_frame_clken     (src_tx_frame_clken             ),
        .pre_tx_img             (src_tx_img                     ),

        .pre_A                  (src_cal_A_result               ),
        //已处理的图像数据 
        .post_src_frame_vsync   (cal_src_frame_vsync            ),
        .post_src_frame_href    (cal_src_frame_href             ),
        .post_src_frame_clken   (cal_src_frame_clken            ),
        .post_img               (cal_img                        ),

        .post_tx_frame_vsync    (cal_tx_frame_vsync             ),
        .post_tx_frame_href     (cal_tx_frame_href              ),
        .post_tx_frame_clken    (cal_tx_frame_clken             ),
        .post_tx_img            (cal_tx_img                     ),

        .post_A                 (cal_A                          ) 
);

generate 
if(Y_ENHANCE_ENABLE == 0) begin
        haze_removal_cal u_haze_removal_cal(
                .clk                     (clk                           ),
                .rst_n                   (rst_n                         ),  

                .pre_src_frame_vsync     (cal_src_frame_vsync           ), 
                .pre_src_frame_href      (cal_src_frame_href            ),  
                .pre_src_frame_clken     (cal_src_frame_clken           ), 
                .pre_img                 (cal_img                       ),

                .pre_tx_frame_vsync      (cal_tx_frame_vsync            ),
                // 真正的 HSYNC 脉冲,已与 cal_img 对齐;见 href_line
                .pre_tx_frame_href       (cal_src_frame_href           ),
                .pre_tx_frame_clken      (cal_tx_frame_clken            ),
                .pre_tx_img              (cal_tx_img                    ),

                .pre_A                   (cal_A                         ),

                .post_frame_vsync        (post_frame_vsync              ), 
                .post_frame_href         (post_frame_href               ),  
                .post_frame_clken        (post_frame_clken              ), 
                .post_img                (post_img                      )
        );
end
else begin


        wire                 haze_removal_vsync         ;
        wire                 haze_removal_hsync         ;
        wire                 haze_removal_de            ;
        wire    [23 : 0]     haze_removal_data          ;
        wire                 tem_YCbCr_vsync            ;
        wire                 tem_YCbCr_hsync            ;
        wire                 tem_YCbCr_de               ;
        wire    [07 : 0]     tem_Y_data                 ;
        wire    [07 : 0]     tem_Cb_data                ;
        wire    [07 : 0]     tem_Cr_data                ;

        haze_removal_cal u_haze_removal_cal(
                .clk                     (clk                           ),
                .rst_n                   (rst_n                         ),  

                .pre_src_frame_vsync     (cal_src_frame_vsync           ), 
                .pre_src_frame_href      (cal_src_frame_href            ),  
                .pre_src_frame_clken     (cal_src_frame_clken           ), 
                .pre_img                 (cal_img                       ),

                .pre_tx_frame_vsync      (cal_tx_frame_vsync            ),
                // 真正的 HSYNC 脉冲,已与 cal_img 对齐;见 href_line
                .pre_tx_frame_href       (cal_src_frame_href           ),
                .pre_tx_frame_clken      (cal_tx_frame_clken            ),
                .pre_tx_img              (cal_tx_img                    ),

                .pre_A                   (cal_A                         ),

                .post_frame_vsync        (haze_removal_vsync            ), 
                .post_frame_href         (haze_removal_hsync            ),  
                .post_frame_clken        (haze_removal_de               ), 
                .post_img                (haze_removal_data             )
        );

        VIP_RGB888_YCbCr444 u_rgb_ycncr_haze(
                //全局时钟
                .clk                    (clk                            ),
                .rst_n                  (rst_n                          ),

                //待处理的图像数据
                .pre_frame_vsync        (haze_removal_vsync             ),
                .pre_frame_href         (haze_removal_hsync             ),
                .pre_frame_clken        (haze_removal_de                ),
                .pre_img_red            (haze_removal_data[16+:8]       ),
                .pre_img_green          (haze_removal_data[ 8+:8]       ),
                .pre_img_blue           (haze_removal_data[ 0+:8]       ),
                
                //已处理的图像数据
                .post_frame_vsync       (tem_YCbCr_vsync                ),
                .post_frame_href        (tem_YCbCr_hsync                ),
                .post_frame_clken       (tem_YCbCr_de                   ),
                .post_img_Y             (tem_Y_data                     ),
                .post_img_Cb            (tem_Cb_data                    ),
                .post_img_Cr            (tem_Cr_data                    )
        ); 

        YCbCr2RGB u_ycbcr_to_rgb(
                .i_sys_clk              (clk                            ),

                .i_vs                   (tem_YCbCr_vsync                ),
                .i_hs                   (tem_YCbCr_hsync                ),
                .i_convert_en           (tem_YCbCr_de                   ),
                .i_y_data               (tem_Y_data + 50                ),
                .i_cr_data              (tem_Cb_data                    ),
                .i_cb_data              (tem_Cr_data                    ),

                .o_vs                   (post_frame_vsync               ),
                .o_hs                   (post_frame_href                ),
                .o_convert_en           (post_frame_clken               ),  
                .o_red                  (post_img[ 0+:8]                ),
                .o_green                (post_img[ 8+:8]                ),
                .o_blue                 (post_img[16+:8]                )
        );
end     
endgenerate


endmodule
