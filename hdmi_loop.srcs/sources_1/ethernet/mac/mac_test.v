//////////////////////////////////////////////////////////////////////////////////////
//Module Name : mac_top
//Description :
//
//////////////////////////////////////////////////////////////////////////////////////
`timescale 1 ns/1 ns
module mac_test
(
 input                rst_n  ,
 input                cmos_vsync,
 input                cmos_href,
 input                reg_conf_done,
// input                vsync_posedge,
// input  [15:0]        identify_code,
 input [15:0]         udp_send_data_length, 
 input [7:0]          fifo_data,                //FIFO中的数据
 input [11:0]         fifo_data_count,		  //FIFO中的数据数量
 output reg              fifo_rd_en,            //FIFO读使�? 
 
 input                gmii_tx_clk ,
 input                gmii_rx_clk ,
 input                gmii_rx_dv,
 input  [7:0]         gmii_rxd,
 output reg           gmii_tx_en,
 output reg [7:0]     gmii_txd,

 // 正在从 FIFO 里往外拉一个 UDP 包时该信号为 1。帧边界复位控制器会等它落下之后
 // 才去复位 FIFO,这样就不会出现读指针被拽回 0、把一个包从中间截断的情况。
 output reg           mac_sending,

 // 链路状态,引出来给 ILA 看。任何视频要发出去之前 ARP 必须先成功,所以板子上
 // mac_not_exist 一直为高就是第一个该去查的东西。
 output               mac_not_exist,
 output               arp_found

);



reg                  gmii_rx_dv_d0 ;
reg   [7:0]          gmii_rxd_d0 ;
wire                 gmii_tx_en_tmp ;
wire   [7:0]         gmii_txd_tmp ;

reg  [9:0]           vsync_posedge_buf ;
reg  [15:0]          identify_code_d0 ;

wire                 udp_tx_req ;
wire                 arp_request_req ;
wire                 mac_send_end ;
reg                  write_end ;

wire [7:0]           udp_rec_ram_rdata ;  
reg  [10:0]          udp_rec_ram_read_addr ;
wire [15:0]          udp_rec_data_length ;
wire                 udp_rec_data_valid ;

reg [11:0]           fifo_rdusedw ;
reg  [31:0]           wait_cnt ;
                     




wire button_negedge ;

wire fifo_rd_en_tmp ;

parameter IDLE          = 10'b0000000001 ;
parameter ARP_REQ       = 10'b0000000010 ;
parameter ARP_SEND      = 10'b0000000100 ;
parameter ARP_WAIT      = 10'b0000001000 ;
parameter GEN_REQ       = 10'b0000010000 ;
parameter CHECK_FIFO    = 10'b0000100000 ;
parameter SEND          = 10'b0001000000 ;
parameter WAIT          = 10'b0010000000 ;
parameter CHECK_ARP     = 10'b0100000000 ;
parameter WAIT_SYNC     = 10'b1000000000 ;


reg [9:0]    state  ;

always @(posedge gmii_tx_clk or negedge rst_n)
begin
  if (~rst_n)
    state  <=  IDLE  ;
  else
  begin
  case(state)
  IDLE        :  begin
                   if (wait_cnt == 32'd1250000 )  //wait for 10ms
						   state <= ARP_REQ ;
						 else
						   state <= IDLE ;
					  end
  
  ARP_REQ     :  state <= ARP_SEND ;
  ARP_SEND    :  begin
                   if (mac_send_end)
						   state <= ARP_WAIT ;
					    else
						   state <= ARP_SEND ;
					  end
  ARP_WAIT    :  begin
                   if (arp_found)
						   state <= WAIT_SYNC ; 
					    else if (wait_cnt == 32'd125_000_000)
						   state <= ARP_REQ ; 
					    else
						   state <= ARP_WAIT ;
					  end
  WAIT_SYNC    : begin
                   if (vsync_posedge_buf[9])
					      state <= CHECK_FIFO     ;
					    else
					      state <= WAIT_SYNC ;
				     end
  CHECK_FIFO   :  begin
                   // 只有**攒满**一个载荷时才起包。差一点点都不行:udp_tx 每次都
                   // 固定读 udp_send_data_length 个字节,不够的话它会读到 FIFO 末尾
                   // 之外,包尾全是垃圾字节——参考工程那个"1024 字节载荷配 `> 1000`
                   // 的门限"就是这么错的。
                   //
                   // 门限从载荷长度推导、而不是写死一个魔数,还让帧边界变成精确的:
                   // 详见 eth_video_tx 里关于 UDP_SEND_LEN 的说明。udp_tx 的第一个读
                   // 发生在其第一个载荷字节被需要之前 5 拍,而且它后面的读和线上是
                   // 严格步调一致的,所以计数**正好等于** udp_send_data_length 就够
                   // 了——它绝不会读空。
                   if (fifo_rdusedw >= udp_send_data_length)
					      state <= GEN_REQ     ;
					    else if (wait_cnt== 32'd125_000_000)
						   state <= WAIT_SYNC     ;
						 else
					      state <= CHECK_FIFO ;
				     end
  
  GEN_REQ     :  begin
						   state <= SEND ;
					  end     
					  
  SEND        :  begin
                   if (mac_send_end)
						   state <= CHECK_ARP ;
					    else
						   state <= SEND ;
					  end
  
  WAIT        :  begin
                   if (wait_cnt == 32'd1024)
					      state <= CHECK_ARP ;
					    else
					      state <= WAIT ;
				     end
  CHECK_ARP   :  begin 
                   if (mac_not_exist)
						   state <= ARP_REQ ;
					    else
						   state <= CHECK_FIFO ;
					  end
  default     :  state <= IDLE ;
endcase
end
end		

always@(posedge gmii_rx_clk or negedge rst_n)
begin	
  if(rst_n == 1'b0) 
  begin
    gmii_rx_dv_d0 <= 1'b0 ;
	 gmii_rxd_d0   <= 8'd0 ;
  end
  else
  begin
    gmii_rx_dv_d0 <= gmii_rx_dv ;
	 gmii_rxd_d0   <= gmii_rxd ;
  end
end

always@(posedge gmii_tx_clk or negedge rst_n)
begin	
  if(rst_n == 1'b0) 
  begin
    gmii_tx_en <= 1'b0 ;
	 gmii_txd   <= 8'd0 ;
  end
  else
  begin
    gmii_tx_en <= gmii_tx_en_tmp ;
	 gmii_txd   <= gmii_txd_tmp ;
  end
end

mac_top mac_top0
(
 .gmii_tx_clk                 (gmii_tx_clk)                  ,
 .gmii_rx_clk                 (gmii_rx_clk)                  ,
 .rst_n                       (rst_n)  ,

 .source_mac_addr             (48'h00_0a_35_01_fe_c0)   ,       //source mac address 
 .identify_code               (identify_code_d0              ), 
 .TTL                         (8'h80),
 .source_ip_addr              (32'hc0a80002),
 .destination_ip_addr         (32'hc0a80003), 
 // 行号被放进 UDP **源端口**,形式是 0x1000 + 行号(4096..4635)。目的端口仍然是
 // 8080,所以普通 UDP 套接字照样收得到——但这样一来 `recvfrom` 返回的发送方地址
 // 里就带着行号,接收端既不需要原始套接字、不需要管理员权限,也不用在 8.1 万包/秒
 // 的速率下去解析 IP 包头。
 //
 // 走 IP 包头当然也行(identify_code 依然送给 ip_tx 当 IP 的 Identification 字段),
 // 只是在 Windows 上需要管理员权限;两条都留着,是为了让两种定界方式能互相校验,
 // 而且**必须始终一致**。
 //
 // 这个掩码是刻意加的:即使 identify_code 哪天跑飞,源端口也永远落在
 // 0x1000..0x13FF 里,于是"这个 bitstream 用源端口携带行号"始终是个可靠的判据,
 // 且 行号 == 端口 - 0x1000 恒成立。
 //
 // 让它整包期间保持稳定是安全的:udp_tx 发 UDP 头时是组合取这个值,而
 // identify_code_d0 只在 CHECK_FIFO 里锁存,状态机在 mac_send_end 之前回不到
 // CHECK_FIFO。
 .udp_send_source_port        (16'h1000 | (identify_code_d0 & 16'h03FF)),
 .udp_send_destination_port   (16'h1f90),
 
 .fifo_data                      (fifo_data),         
 .fifo_rd_en                     (fifo_rd_en_tmp), 
 .ram_wr_data                 () ,
 .ram_wr_en                   (),
 .udp_ram_data_req            (),
 .udp_send_data_length        (udp_send_data_length),
 
 .udp_tx_req                  (udp_tx_req),
 .arp_request_req             (arp_request_req ),
 
 .mac_send_end                (mac_send_end),  
 .mac_data_valid              (gmii_tx_en_tmp),   
 .mac_tx_data                 (gmii_txd_tmp), 
 .rx_dv                       (gmii_rx_dv_d0   ),
 .mac_rx_datain               (gmii_rxd_d0 ),
    
 .udp_rec_ram_rdata           (udp_rec_ram_rdata),  
 .udp_rec_ram_read_addr       (udp_rec_ram_read_addr),
 .udp_rec_data_length         (udp_rec_data_length ),
    
 .udp_rec_data_valid          (udp_rec_data_valid),
 .arp_found                   (arp_found ),
 .mac_not_exist               (mac_not_exist )
) ;



	


assign udp_tx_req = (state == GEN_REQ) ;
assign arp_request_req = (state == ARP_REQ) ;



always @(posedge gmii_tx_clk or negedge rst_n)
begin
  if (!rst_n)
    fifo_rdusedw <= 12'd0 ;
  else  
    fifo_rdusedw <= fifo_data_count ;
end

reg cmos_vsync_d0 ;
reg cmos_vsync_d1 ;
reg cmos_vsync_d2 ;
wire vsync_posedge ;
reg cmos_href_d0 ;
reg cmos_href_d1 ;
reg cmos_href_d2 ;
reg [15:0] identify_code ;

always @(posedge gmii_tx_clk or negedge rst_n)
begin
  if (!rst_n)
  begin
    cmos_vsync_d0 <= 1'b0 ;
	 cmos_vsync_d1 <= 1'b0 ;
	 cmos_vsync_d2 <= 1'b0 ;
  end
  else
  begin
    cmos_vsync_d0 <= cmos_vsync ;
    cmos_vsync_d1 <= cmos_vsync_d0 ;
	 cmos_vsync_d2 <= cmos_vsync_d1 ;
  end
end

assign vsync_posedge = ~cmos_vsync_d2 & cmos_vsync_d1 ;

always @(posedge gmii_tx_clk or negedge rst_n)
begin
  if (!rst_n)
  begin
    cmos_href_d0 <= 1'b0 ;
	 cmos_href_d1 <= 1'b0 ;
	 cmos_href_d2 <= 1'b0 ;
  end
  else
  begin
    cmos_href_d0 <= cmos_href ;
    cmos_href_d1 <= cmos_href_d0 ;
	 cmos_href_d2 <= cmos_href_d1 ;
  end
end

always @(posedge gmii_tx_clk or negedge rst_n)
begin
  if (!rst_n)
    identify_code <= 16'd0 ;
  else if (vsync_posedge)
    identify_code <= 16'd0 ;
  else if (cmos_href_d1 == 1'b1 && cmos_href_d2 == 1'b0)
    identify_code <= identify_code + 1'b1 ;
end


always@(posedge gmii_tx_clk or negedge rst_n)
begin	
  if(rst_n == 1'b0) 
    wait_cnt <= 0 ;
  else if (state == IDLE ||state == CHECK_FIFO || state == WAIT || state == ARP_WAIT)
    wait_cnt <= wait_cnt + 1'b1 ;
  else
    wait_cnt <= 0 ;
end

always@(posedge gmii_tx_clk or negedge rst_n)
begin	
  if(rst_n == 1'b0) 
    vsync_posedge_buf <= 10'd0 ;
  else 
    vsync_posedge_buf <= {vsync_posedge_buf[8:0], vsync_posedge} ;
end

always@(posedge gmii_tx_clk or negedge rst_n)
begin	
  if(rst_n == 1'b0)
    identify_code_d0 <= 16'd0 ;
  else if (state == CHECK_FIFO)
    identify_code_d0 <= identify_code ;
end

always@(posedge gmii_tx_clk or negedge rst_n)
begin
  if(rst_n == 1'b0)
    fifo_rd_en <= 1'b0 ;
  else
    fifo_rd_en <= fifo_rd_en_tmp ;
end

// GEN_REQ 就是 udp_tx_req 被拉高的那一拍,SEND 一直持续到 mac_send_end。
// WAIT 刻意不算在内:到那时候包已经出去了。
always@(posedge gmii_tx_clk or negedge rst_n)
begin
  if(rst_n == 1'b0)
    mac_sending <= 1'b0 ;
  else
    mac_sending <= (state == GEN_REQ) || (state == SEND) ;
end

endmodule
