module dark_channel#(
        parameter       PIC_WIDTH  =   640   ,
        // 级联 3x3 最小值处理的次数;窗口为 (2*WINDOW_PASSES+1)^2。
        // 3 -> 7x7(本工程),1 -> 原始的 3x3。
        parameter       WINDOW_PASSES = 3
)(
        input           clk,             //cmos 像素时钟
        input           rst_n,  
        //处理前数据
        input           pre_frame_vsync, 
        input           pre_frame_href,  
        input           pre_frame_clken, 
        input   [23:0]  pre_img,       
        //处理后的数据
        output          post_frame_vsync    , 
        output          post_frame_href     ,  
        output          post_frame_clken    , 
        output  [7 :0]  post_img  
);


wire            src_min_frame_vsync         ;
wire            src_min_frame_href          ; 
wire            src_min_frame_clken         ;
wire    [7 :0]  src_min_img                 ; 

wire            src_block_min_frame_vsync   ;
wire            src_block_min_frame_href    ; 
wire            src_block_min_frame_clken   ;
wire    [7 :0]  src_block_min_img           ; 


src_min u_src_min(
        .clk                    (clk                            ),              
        .rst_n                  (rst_n                          ),    
        //处理前数据
        .pre_frame_vsync        (pre_frame_vsync                ), 
        .pre_frame_href         (pre_frame_href                 ),   
        .pre_frame_clken        (pre_frame_clken                ),
        .pre_img                (pre_img                        ),
        //处理后的数据
        .post_frame_vsync       (src_min_frame_vsync            ), 
        .post_frame_href        (src_min_frame_href             ),  
        .post_frame_clken       (src_min_frame_clken            ), 
        .post_img               (src_min_img                    )
);

search_block_min#(
        .PIC_WIDTH              (PIC_WIDTH                      )
)u_search_block_min(
        .clk                    (clk                            ),
        .rst_n                  (rst_n                          ),  
        //处理前数据
        .pre_frame_vsync        (src_min_frame_vsync            ), 
        .pre_frame_href         (src_min_frame_href             ),  
        .pre_frame_clken        (src_min_frame_clken            ), 
        .pre_img                (src_min_img                    ),       
        //处理后的数据
        .post_frame_vsync       (src_block_min_frame_vsync      ), 
        .post_frame_href        (src_block_min_frame_href       ),  
        .post_frame_clken       (src_block_min_frame_clken      ), 
        .post_img               (src_block_min_img              )
);



// ---------------------------------------------------------------------------
// 暗通道窗口:把上面的 3x3 处理级联 WINDOW_PASSES 次。
//
// 3x3 盒最小值是对正方形 [-1,1]^2 的形态学腐蚀,
// 而腐蚀按结构元的 Minkowski 和复合:
//     [-1,1]^2 (+) [-1,1]^2 (+) [-1,1]^2 = [-3,3]^2
// 所以三次处理得到的正是精确的 7x7 盒最小值。既不用设计新模块,
// 也不用改动行缓存:每一次处理都复用 search_block_min,它本身就自带行缓存
// 和标记链。代价是每多一次处理增加 4 个周期延迟和 2 个行缓存
// (1920 像素时为 2 个 BRAM18)。
//
// He et al. 规定的是 15x15。基于
// tools/out.avi_20260921_212043.311.jpg 恢复出的源上实测,局部对比度增益到 7x7
// 就已饱和(3x3 1.87x、5x5 2.66x、7x7 3.04x、9x9 3.23x、15x15 3.25x、21x21 3.10x),
// 所以 15x15 用多 8 个行缓存只换来约 4% 的输出亮度。更宽的窗口并不是
// 主要为了亮度 —— 而是为了让估计值正确。3x3 小窗口
// 在近场找不到暗内容,于是细节区域得到 t < 1,
// 被压暗而不是原样通过。在相同输出亮度下,更宽的
// 窗口优势明显(omega=0.85):
//     3x3  78.9 输出亮度,局部对比度增益 1.66x
//     7x7  81.5 输出亮度,局部对比度增益 2.02x
//
// 已知偏差,原本就有、现在被放大到三倍:每一次处理的窗口都是因果的
// (锚定在当前像素、向上向左延伸),所以 (x,y) 处的 dc 是 x-6..x、y-6..y 上的
// 最小值,而不是居中的 7x7。readme.md 已经记录了 3x3 情形下的这个偏移。
// 要改成居中,需要在 time_alignment 的 src 通路上加 3 行、3 像素的延迟;
// 此处未做。
//
// WINDOW_PASSES = 1 可逐位精确恢复原始的 3x3 行为。
// ---------------------------------------------------------------------------
wire        blk_vsync [0:WINDOW_PASSES-1];
wire        blk_href  [0:WINDOW_PASSES-1];
wire        blk_clken [0:WINDOW_PASSES-1];
wire [7:0]  blk_img   [0:WINDOW_PASSES-1];

// 第 1 级就是上面的 search_block_min 实例
assign blk_vsync[0] = src_block_min_frame_vsync;
assign blk_href [0] = src_block_min_frame_href ;
assign blk_clken[0] = src_block_min_frame_clken;
assign blk_img  [0] = src_block_min_img        ;

genvar gp;
generate
for (gp = 0; gp < WINDOW_PASSES - 1; gp = gp + 1) begin : g_block_min_pass
    search_block_min#(
            .PIC_WIDTH              (PIC_WIDTH                      )
    )u_search_block_min(
            .clk                    (clk                            ),
            .rst_n                  (rst_n                          ),
            .pre_frame_vsync        (blk_vsync[gp]                  ),
            .pre_frame_href         (blk_href [gp]                  ),
            .pre_frame_clken        (blk_clken[gp]                  ),
            .pre_img                (blk_img  [gp]                  ),
            .post_frame_vsync       (blk_vsync[gp+1]                ),
            .post_frame_href        (blk_href [gp+1]                ),
            .post_frame_clken       (blk_clken[gp+1]                ),
            .post_img               (blk_img  [gp+1]                )
    );
end
endgenerate


assign  post_frame_vsync    =   blk_vsync [WINDOW_PASSES-1] ;
assign  post_frame_href     =   blk_href  [WINDOW_PASSES-1] ;
assign  post_frame_clken    =   blk_clken [WINDOW_PASSES-1] ;
assign  post_img            =   blk_img   [WINDOW_PASSES-1] ;



endmodule