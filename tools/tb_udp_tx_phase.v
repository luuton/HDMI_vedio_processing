// 针对 udp_tx 读窗口修正的 testbench(udp_send_cnt 上的 off-by-one)。
//
// 建模的拓扑(与 mac_test -> mac_top -> udp_tx 一致):
//   udp_tx.fifo_rd_en(寄存器)        +1
//   mac_test.fifo_rd_en(再打一拍)    +1
//   FIFO 标准模式读延迟              +1
//   udp_tx.ram_rdata_d0              +1
//   udp_tx.udp_tx_data               +1
// 所以在第 n 拍满足窗口条件时发出的读,会在第 n+5 拍落到 udp_tx_data 上。
//
// udp_tx_data 是个寄存器,采的是 case(udp_send_cnt) 的结果,所以为 cnt = n 选出的
// 那个字节是在第 n+1 拍输出。于是整个数据报占据 cnt = 1..1032:UDP 头的第 0 个字节
// 在 cnt = 1 上线,载荷第 j 个字节在 cnt = 9+j。
//
// FIFO 被建模成一条无限的只读数据流:mem[i] = i 的低 8 位,dout 相对 rd_en 恰好
// 晚一拍。
//
// 通过判据:
//   1. 1024 字节的载荷恰好发出 1024 个 rd_en 脉冲(参考工程发的是 1025 个);
//   2. 对每个包,载荷第 j 个字节都等于 mem[p*1024 + j]。
// 第 (2) 条才是关键:多读一次就会让数据流错位,每个包把画面错开一个字节。参考工程
// 那个 "total-3" 的窗口过不了这一条。

`timescale 1ns/1ps

module tb_udp_tx_phase;

localparam integer PKTS = 3;
localparam integer PAYLOAD = 1024;
localparam integer DGLEN = PAYLOAD + 8;             // 1032,最后一个用到的 cnt
localparam integer STRIDE = DGLEN + 1;              // cnt 0..DGLEN 每个一个槽位

reg         clk = 1'b0;
reg         rst_n = 1'b0;
always #4 clk = ~clk;                               // 125 MHz gmii_tx_clk

reg  [15:0] udp_send_data_length = PAYLOAD;
reg         udp_tx_req = 1'b0;
reg         udp_data_req = 1'b0;

wire [7:0]  fifo_data;
wire        fifo_rd_en;
wire [7:0]  udp_tx_data;
wire        udp_tx_ready;
wire        udp_tx_end;

// ---------------------------------------------------------------- mac_test 那一级
reg rd_en_sync;
always @(posedge clk or negedge rst_n)
  if (!rst_n) rd_en_sync <= 1'b0;
  else        rd_en_sync <= fifo_rd_en;

// ------------------------------------------------------------------ FIFO 模型
reg  [7:0]   mem [0:8191];
reg  [7:0]   dout_r;
reg  [12:0]  rdp;
integer      i;
initial for (i = 0; i < 8192; i = i + 1) mem[i] = i[7:0];

always @(posedge clk or negedge rst_n)
  if (!rst_n) begin dout_r <= 8'h00; rdp <= 13'd0; end
  else if (rd_en_sync) begin dout_r <= mem[rdp]; rdp <= rdp + 1'b1; end

assign fifo_data = dout_r;

// ------------------------------------------------------------------------ 被测模块
udp_tx dut (
  .clk                       (clk),
  .rst_n                     (rst_n),
  .source_ip_addr            (32'hc0a80002),
  .destination_ip_addr       (32'hc0a80003),
  .udp_send_source_port      (16'h1f90),
  .udp_send_destination_port (16'h1f90),
  .udp_send_data_length      (udp_send_data_length),
  .fifo_data                 (fifo_data),
  .fifo_rd_en                (fifo_rd_en),
  .ram_wr_data               (8'h00),
  .ram_wr_en                 (1'b0),
  .udp_ram_data_req          (),
  .udp_tx_req                (udp_tx_req),
  .udp_data_req              (udp_data_req),
  .udp_tx_ready              (udp_tx_ready),
  .udp_tx_data               (udp_tx_data),
  .udp_tx_end                (udp_tx_end)
);

// ------------------------------------------------------------------- 采集
// dg[pkt*DGLEN + cnt] = 该包第 cnt 拍时 udp_tx_data 上的字节
reg  [7:0]  dg [0:PKTS*STRIDE-1];
integer     pkt = 0;
integer     rd_pulses = 0;

always @(posedge clk) begin
  if (rd_en_sync) rd_pulses <= rd_pulses + 1;
  if (dut.state == 7'b100_0000) begin
    if (dut.udp_send_cnt <= DGLEN) dg[pkt*STRIDE + dut.udp_send_cnt] <= udp_tx_data;
    if (dut.udp_send_cnt == DGLEN) pkt <= pkt + 1;   // 最后一个用到的 cnt 的下一拍
  end
end

// ---------------------------------------------------------------------- 激励
integer p, j, mismatches;
initial begin
  repeat (10) @(posedge clk);
  rst_n = 1'b1;
  repeat (10) @(posedge clk);
  udp_data_req = 1'b1;

  for (p = 0; p < PKTS; p = p + 1) begin
    @(posedge clk); udp_tx_req = 1'b1;
    @(posedge clk); udp_tx_req = 1'b0;
    wait (dut.state == 7'b100_0000);
    wait (dut.state == 7'b000_0001);                 // 回到 IDLE
    repeat (4) @(posedge clk);
  end
  repeat (20) @(posedge clk);

  $display("");
  $display("packets sent           = %0d", pkt);
  $display("rd_en pulses total     = %0d   (expect %0d)", rd_pulses, PKTS*PAYLOAD);
  $display("FIFO rd pointer        = %0d   (expect %0d)", rdp, PKTS*PAYLOAD);
  $display("pkt0 header at cnt 1..8= %0d %0d %0d %0d %0d %0d %0d %0d",
           dg[1],dg[2],dg[3],dg[4],dg[5],dg[6],dg[7],dg[8]);

  mismatches = 0;
  for (p = 0; p < PKTS; p = p + 1)
    for (j = 0; j < PAYLOAD; j = j + 1)
      if (dg[p*STRIDE + 9 + j] !== mem[p*PAYLOAD + j]) begin
        if (mismatches < 8)
          $display("  MISMATCH pkt%0d payload[%0d] = %0d, expected %0d",
                   p, j, dg[p*STRIDE + 9 + j], mem[p*PAYLOAD + j]);
        mismatches = mismatches + 1;
      end
  $display("payload mismatches     = %0d / %0d", mismatches, PKTS*PAYLOAD);
  $display(rd_pulses == PKTS*PAYLOAD && rdp == PKTS*PAYLOAD && mismatches == 0
           ? "RESULT: PASS" : "RESULT: FAIL");
  $display("");
  $finish;
end

endmodule
