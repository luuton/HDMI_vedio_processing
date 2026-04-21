//Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2021.2 (win64) Build 3367213 Tue Oct 19 02:48:09 MDT 2021
//Date        : Mon Apr 20 22:14:24 2026
//Host        : MagicBook-Pro-16-For-ZzzLTT running 64-bit major release  (build 9200)
//Command     : generate_target exdes.bd
//Design      : exdes
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module audio_ss_0_imp_L2LLI5
   (ACLK,
    ARESETN,
    S00_AXI_araddr,
    S00_AXI_arprot,
    S00_AXI_arready,
    S00_AXI_arvalid,
    S00_AXI_awaddr,
    S00_AXI_awprot,
    S00_AXI_awready,
    S00_AXI_awvalid,
    S00_AXI_bready,
    S00_AXI_bresp,
    S00_AXI_bvalid,
    S00_AXI_rdata,
    S00_AXI_rready,
    S00_AXI_rresp,
    S00_AXI_rvalid,
    S00_AXI_wdata,
    S00_AXI_wready,
    S00_AXI_wstrb,
    S00_AXI_wvalid,
    aud_acr_cts_in,
    aud_acr_cts_out,
    aud_acr_n_in,
    aud_acr_n_out,
    aud_acr_valid_in,
    aud_acr_valid_out,
    aud_rstn,
    audio_clk,
    axis_audio_in_tdata,
    axis_audio_in_tid,
    axis_audio_in_tready,
    axis_audio_in_tvalid,
    axis_audio_out_tdata,
    axis_audio_out_tid,
    axis_audio_out_tready,
    axis_audio_out_tvalid,
    hdmi_clk);
  input ACLK;
  input ARESETN;
  input [31:0]S00_AXI_araddr;
  input [2:0]S00_AXI_arprot;
  output [0:0]S00_AXI_arready;
  input [0:0]S00_AXI_arvalid;
  input [31:0]S00_AXI_awaddr;
  input [2:0]S00_AXI_awprot;
  output [0:0]S00_AXI_awready;
  input [0:0]S00_AXI_awvalid;
  input [0:0]S00_AXI_bready;
  output [1:0]S00_AXI_bresp;
  output [0:0]S00_AXI_bvalid;
  output [31:0]S00_AXI_rdata;
  input [0:0]S00_AXI_rready;
  output [1:0]S00_AXI_rresp;
  output [0:0]S00_AXI_rvalid;
  input [31:0]S00_AXI_wdata;
  output [0:0]S00_AXI_wready;
  input [3:0]S00_AXI_wstrb;
  input [0:0]S00_AXI_wvalid;
  input [19:0]aud_acr_cts_in;
  output [19:0]aud_acr_cts_out;
  input [19:0]aud_acr_n_in;
  output [19:0]aud_acr_n_out;
  input aud_acr_valid_in;
  output aud_acr_valid_out;
  output aud_rstn;
  output audio_clk;
  input [31:0]axis_audio_in_tdata;
  input [7:0]axis_audio_in_tid;
  output axis_audio_in_tready;
  input axis_audio_in_tvalid;
  output [31:0]axis_audio_out_tdata;
  output [2:0]axis_audio_out_tid;
  input axis_audio_out_tready;
  output axis_audio_out_tvalid;
  input hdmi_clk;

  wire [31:0]intf_net_aud_pat_gen_axis_audio_out_TDATA;
  wire [2:0]intf_net_aud_pat_gen_axis_audio_out_TID;
  wire intf_net_aud_pat_gen_axis_audio_out_TREADY;
  wire intf_net_aud_pat_gen_axis_audio_out_TVALID;
  wire [31:0]intf_net_axi_interconnect_M00_AXI_ARADDR;
  wire [2:0]intf_net_axi_interconnect_M00_AXI_ARPROT;
  wire intf_net_axi_interconnect_M00_AXI_ARREADY;
  wire intf_net_axi_interconnect_M00_AXI_ARVALID;
  wire [31:0]intf_net_axi_interconnect_M00_AXI_AWADDR;
  wire [2:0]intf_net_axi_interconnect_M00_AXI_AWPROT;
  wire intf_net_axi_interconnect_M00_AXI_AWREADY;
  wire intf_net_axi_interconnect_M00_AXI_AWVALID;
  wire intf_net_axi_interconnect_M00_AXI_BREADY;
  wire [1:0]intf_net_axi_interconnect_M00_AXI_BRESP;
  wire intf_net_axi_interconnect_M00_AXI_BVALID;
  wire [31:0]intf_net_axi_interconnect_M00_AXI_RDATA;
  wire intf_net_axi_interconnect_M00_AXI_RREADY;
  wire [1:0]intf_net_axi_interconnect_M00_AXI_RRESP;
  wire intf_net_axi_interconnect_M00_AXI_RVALID;
  wire [31:0]intf_net_axi_interconnect_M00_AXI_WDATA;
  wire intf_net_axi_interconnect_M00_AXI_WREADY;
  wire [3:0]intf_net_axi_interconnect_M00_AXI_WSTRB;
  wire intf_net_axi_interconnect_M00_AXI_WVALID;
  wire [31:0]intf_net_axi_interconnect_M01_AXI_ARADDR;
  wire intf_net_axi_interconnect_M01_AXI_ARREADY;
  wire intf_net_axi_interconnect_M01_AXI_ARVALID;
  wire [31:0]intf_net_axi_interconnect_M01_AXI_AWADDR;
  wire intf_net_axi_interconnect_M01_AXI_AWREADY;
  wire intf_net_axi_interconnect_M01_AXI_AWVALID;
  wire intf_net_axi_interconnect_M01_AXI_BREADY;
  wire [1:0]intf_net_axi_interconnect_M01_AXI_BRESP;
  wire intf_net_axi_interconnect_M01_AXI_BVALID;
  wire [31:0]intf_net_axi_interconnect_M01_AXI_RDATA;
  wire intf_net_axi_interconnect_M01_AXI_RREADY;
  wire [1:0]intf_net_axi_interconnect_M01_AXI_RRESP;
  wire intf_net_axi_interconnect_M01_AXI_RVALID;
  wire [31:0]intf_net_axi_interconnect_M01_AXI_WDATA;
  wire intf_net_axi_interconnect_M01_AXI_WREADY;
  wire [3:0]intf_net_axi_interconnect_M01_AXI_WSTRB;
  wire intf_net_axi_interconnect_M01_AXI_WVALID;
  wire [31:0]intf_net_axi_interconnect_M02_AXI_ARADDR;
  wire intf_net_axi_interconnect_M02_AXI_ARREADY;
  wire intf_net_axi_interconnect_M02_AXI_ARVALID;
  wire [31:0]intf_net_axi_interconnect_M02_AXI_AWADDR;
  wire intf_net_axi_interconnect_M02_AXI_AWREADY;
  wire intf_net_axi_interconnect_M02_AXI_AWVALID;
  wire intf_net_axi_interconnect_M02_AXI_BREADY;
  wire [1:0]intf_net_axi_interconnect_M02_AXI_BRESP;
  wire intf_net_axi_interconnect_M02_AXI_BVALID;
  wire [31:0]intf_net_axi_interconnect_M02_AXI_RDATA;
  wire intf_net_axi_interconnect_M02_AXI_RREADY;
  wire [1:0]intf_net_axi_interconnect_M02_AXI_RRESP;
  wire intf_net_axi_interconnect_M02_AXI_RVALID;
  wire [31:0]intf_net_axi_interconnect_M02_AXI_WDATA;
  wire intf_net_axi_interconnect_M02_AXI_WREADY;
  wire [3:0]intf_net_axi_interconnect_M02_AXI_WSTRB;
  wire intf_net_axi_interconnect_M02_AXI_WVALID;
  wire [31:0]intf_net_bdry_in_S00_AXI_ARADDR;
  wire [2:0]intf_net_bdry_in_S00_AXI_ARPROT;
  wire [0:0]intf_net_bdry_in_S00_AXI_ARREADY;
  wire [0:0]intf_net_bdry_in_S00_AXI_ARVALID;
  wire [31:0]intf_net_bdry_in_S00_AXI_AWADDR;
  wire [2:0]intf_net_bdry_in_S00_AXI_AWPROT;
  wire [0:0]intf_net_bdry_in_S00_AXI_AWREADY;
  wire [0:0]intf_net_bdry_in_S00_AXI_AWVALID;
  wire [0:0]intf_net_bdry_in_S00_AXI_BREADY;
  wire [1:0]intf_net_bdry_in_S00_AXI_BRESP;
  wire [0:0]intf_net_bdry_in_S00_AXI_BVALID;
  wire [31:0]intf_net_bdry_in_S00_AXI_RDATA;
  wire [0:0]intf_net_bdry_in_S00_AXI_RREADY;
  wire [1:0]intf_net_bdry_in_S00_AXI_RRESP;
  wire [0:0]intf_net_bdry_in_S00_AXI_RVALID;
  wire [31:0]intf_net_bdry_in_S00_AXI_WDATA;
  wire [0:0]intf_net_bdry_in_S00_AXI_WREADY;
  wire [3:0]intf_net_bdry_in_S00_AXI_WSTRB;
  wire [0:0]intf_net_bdry_in_S00_AXI_WVALID;
  wire [31:0]intf_net_bdry_in_axis_audio_in_TDATA;
  wire [7:0]intf_net_bdry_in_axis_audio_in_TID;
  wire intf_net_bdry_in_axis_audio_in_TREADY;
  wire intf_net_bdry_in_axis_audio_in_TVALID;
  wire net_bdry_in_ACLK;
  wire net_bdry_in_ARESETN;
  wire [19:0]net_bdry_in_aud_acr_cts_in;
  wire [19:0]net_bdry_in_aud_acr_n_in;
  wire net_bdry_in_aud_acr_valid_in;
  wire net_bdry_in_hdmi_clk;
  wire net_clk_wiz_clk_out1;
  wire net_clk_wiz_locked;
  wire [19:0]net_hdmi_acr_ctrl_aud_acr_cts_out;
  wire [19:0]net_hdmi_acr_ctrl_aud_acr_n_out;
  wire net_hdmi_acr_ctrl_aud_acr_valid_out;
  wire net_hdmi_acr_ctrl_aud_resetn_out;

  assign S00_AXI_arready[0] = intf_net_bdry_in_S00_AXI_ARREADY;
  assign S00_AXI_awready[0] = intf_net_bdry_in_S00_AXI_AWREADY;
  assign S00_AXI_bresp[1:0] = intf_net_bdry_in_S00_AXI_BRESP;
  assign S00_AXI_bvalid[0] = intf_net_bdry_in_S00_AXI_BVALID;
  assign S00_AXI_rdata[31:0] = intf_net_bdry_in_S00_AXI_RDATA;
  assign S00_AXI_rresp[1:0] = intf_net_bdry_in_S00_AXI_RRESP;
  assign S00_AXI_rvalid[0] = intf_net_bdry_in_S00_AXI_RVALID;
  assign S00_AXI_wready[0] = intf_net_bdry_in_S00_AXI_WREADY;
  assign aud_acr_cts_out[19:0] = net_hdmi_acr_ctrl_aud_acr_cts_out;
  assign aud_acr_n_out[19:0] = net_hdmi_acr_ctrl_aud_acr_n_out;
  assign aud_acr_valid_out = net_hdmi_acr_ctrl_aud_acr_valid_out;
  assign aud_rstn = net_hdmi_acr_ctrl_aud_resetn_out;
  assign audio_clk = net_clk_wiz_clk_out1;
  assign axis_audio_in_tready = intf_net_bdry_in_axis_audio_in_TREADY;
  assign axis_audio_out_tdata[31:0] = intf_net_aud_pat_gen_axis_audio_out_TDATA;
  assign axis_audio_out_tid[2:0] = intf_net_aud_pat_gen_axis_audio_out_TID;
  assign axis_audio_out_tvalid = intf_net_aud_pat_gen_axis_audio_out_TVALID;
  assign intf_net_aud_pat_gen_axis_audio_out_TREADY = axis_audio_out_tready;
  assign intf_net_bdry_in_S00_AXI_ARADDR = S00_AXI_araddr[31:0];
  assign intf_net_bdry_in_S00_AXI_ARPROT = S00_AXI_arprot[2:0];
  assign intf_net_bdry_in_S00_AXI_ARVALID = S00_AXI_arvalid[0];
  assign intf_net_bdry_in_S00_AXI_AWADDR = S00_AXI_awaddr[31:0];
  assign intf_net_bdry_in_S00_AXI_AWPROT = S00_AXI_awprot[2:0];
  assign intf_net_bdry_in_S00_AXI_AWVALID = S00_AXI_awvalid[0];
  assign intf_net_bdry_in_S00_AXI_BREADY = S00_AXI_bready[0];
  assign intf_net_bdry_in_S00_AXI_RREADY = S00_AXI_rready[0];
  assign intf_net_bdry_in_S00_AXI_WDATA = S00_AXI_wdata[31:0];
  assign intf_net_bdry_in_S00_AXI_WSTRB = S00_AXI_wstrb[3:0];
  assign intf_net_bdry_in_S00_AXI_WVALID = S00_AXI_wvalid[0];
  assign intf_net_bdry_in_axis_audio_in_TDATA = axis_audio_in_tdata[31:0];
  assign intf_net_bdry_in_axis_audio_in_TID = axis_audio_in_tid[7:0];
  assign intf_net_bdry_in_axis_audio_in_TVALID = axis_audio_in_tvalid;
  assign net_bdry_in_ACLK = ACLK;
  assign net_bdry_in_ARESETN = ARESETN;
  assign net_bdry_in_aud_acr_cts_in = aud_acr_cts_in[19:0];
  assign net_bdry_in_aud_acr_n_in = aud_acr_n_in[19:0];
  assign net_bdry_in_aud_acr_valid_in = aud_acr_valid_in;
  assign net_bdry_in_hdmi_clk = hdmi_clk;
  exdes_aud_pat_gen_0 aud_pat_gen
       (.aud_clk(net_clk_wiz_clk_out1),
        .axi_aclk(net_bdry_in_ACLK),
        .axi_araddr(intf_net_axi_interconnect_M00_AXI_ARADDR),
        .axi_aresetn(net_bdry_in_ARESETN),
        .axi_arprot(intf_net_axi_interconnect_M00_AXI_ARPROT),
        .axi_arready(intf_net_axi_interconnect_M00_AXI_ARREADY),
        .axi_arvalid(intf_net_axi_interconnect_M00_AXI_ARVALID),
        .axi_awaddr(intf_net_axi_interconnect_M00_AXI_AWADDR),
        .axi_awprot(intf_net_axi_interconnect_M00_AXI_AWPROT),
        .axi_awready(intf_net_axi_interconnect_M00_AXI_AWREADY),
        .axi_awvalid(intf_net_axi_interconnect_M00_AXI_AWVALID),
        .axi_bready(intf_net_axi_interconnect_M00_AXI_BREADY),
        .axi_bresp(intf_net_axi_interconnect_M00_AXI_BRESP),
        .axi_bvalid(intf_net_axi_interconnect_M00_AXI_BVALID),
        .axi_rdata(intf_net_axi_interconnect_M00_AXI_RDATA),
        .axi_rready(intf_net_axi_interconnect_M00_AXI_RREADY),
        .axi_rresp(intf_net_axi_interconnect_M00_AXI_RRESP),
        .axi_rvalid(intf_net_axi_interconnect_M00_AXI_RVALID),
        .axi_wdata(intf_net_axi_interconnect_M00_AXI_WDATA),
        .axi_wready(intf_net_axi_interconnect_M00_AXI_WREADY),
        .axi_wstrb(intf_net_axi_interconnect_M00_AXI_WSTRB),
        .axi_wvalid(intf_net_axi_interconnect_M00_AXI_WVALID),
        .axis_aud_pattern_tdata_in(intf_net_bdry_in_axis_audio_in_TDATA),
        .axis_aud_pattern_tdata_out(intf_net_aud_pat_gen_axis_audio_out_TDATA),
        .axis_aud_pattern_tid_in(intf_net_bdry_in_axis_audio_in_TID[2:0]),
        .axis_aud_pattern_tid_out(intf_net_aud_pat_gen_axis_audio_out_TID),
        .axis_aud_pattern_tready_in(intf_net_aud_pat_gen_axis_audio_out_TREADY),
        .axis_aud_pattern_tready_out(intf_net_bdry_in_axis_audio_in_TREADY),
        .axis_aud_pattern_tvalid_in(intf_net_bdry_in_axis_audio_in_TVALID),
        .axis_aud_pattern_tvalid_out(intf_net_aud_pat_gen_axis_audio_out_TVALID),
        .axis_clk(net_clk_wiz_clk_out1),
        .axis_resetn(net_hdmi_acr_ctrl_aud_resetn_out));
  exdes_axi_interconnect_0 axi_interconnect
       (.ACLK(net_bdry_in_ACLK),
        .ARESETN(net_bdry_in_ARESETN),
        .M00_ACLK(net_bdry_in_ACLK),
        .M00_ARESETN(net_bdry_in_ARESETN),
        .M00_AXI_araddr(intf_net_axi_interconnect_M00_AXI_ARADDR),
        .M00_AXI_arprot(intf_net_axi_interconnect_M00_AXI_ARPROT),
        .M00_AXI_arready(intf_net_axi_interconnect_M00_AXI_ARREADY),
        .M00_AXI_arvalid(intf_net_axi_interconnect_M00_AXI_ARVALID),
        .M00_AXI_awaddr(intf_net_axi_interconnect_M00_AXI_AWADDR),
        .M00_AXI_awprot(intf_net_axi_interconnect_M00_AXI_AWPROT),
        .M00_AXI_awready(intf_net_axi_interconnect_M00_AXI_AWREADY),
        .M00_AXI_awvalid(intf_net_axi_interconnect_M00_AXI_AWVALID),
        .M00_AXI_bready(intf_net_axi_interconnect_M00_AXI_BREADY),
        .M00_AXI_bresp(intf_net_axi_interconnect_M00_AXI_BRESP),
        .M00_AXI_bvalid(intf_net_axi_interconnect_M00_AXI_BVALID),
        .M00_AXI_rdata(intf_net_axi_interconnect_M00_AXI_RDATA),
        .M00_AXI_rready(intf_net_axi_interconnect_M00_AXI_RREADY),
        .M00_AXI_rresp(intf_net_axi_interconnect_M00_AXI_RRESP),
        .M00_AXI_rvalid(intf_net_axi_interconnect_M00_AXI_RVALID),
        .M00_AXI_wdata(intf_net_axi_interconnect_M00_AXI_WDATA),
        .M00_AXI_wready(intf_net_axi_interconnect_M00_AXI_WREADY),
        .M00_AXI_wstrb(intf_net_axi_interconnect_M00_AXI_WSTRB),
        .M00_AXI_wvalid(intf_net_axi_interconnect_M00_AXI_WVALID),
        .M01_ACLK(net_bdry_in_ACLK),
        .M01_ARESETN(net_bdry_in_ARESETN),
        .M01_AXI_araddr(intf_net_axi_interconnect_M01_AXI_ARADDR),
        .M01_AXI_arready(intf_net_axi_interconnect_M01_AXI_ARREADY),
        .M01_AXI_arvalid(intf_net_axi_interconnect_M01_AXI_ARVALID),
        .M01_AXI_awaddr(intf_net_axi_interconnect_M01_AXI_AWADDR),
        .M01_AXI_awready(intf_net_axi_interconnect_M01_AXI_AWREADY),
        .M01_AXI_awvalid(intf_net_axi_interconnect_M01_AXI_AWVALID),
        .M01_AXI_bready(intf_net_axi_interconnect_M01_AXI_BREADY),
        .M01_AXI_bresp(intf_net_axi_interconnect_M01_AXI_BRESP),
        .M01_AXI_bvalid(intf_net_axi_interconnect_M01_AXI_BVALID),
        .M01_AXI_rdata(intf_net_axi_interconnect_M01_AXI_RDATA),
        .M01_AXI_rready(intf_net_axi_interconnect_M01_AXI_RREADY),
        .M01_AXI_rresp(intf_net_axi_interconnect_M01_AXI_RRESP),
        .M01_AXI_rvalid(intf_net_axi_interconnect_M01_AXI_RVALID),
        .M01_AXI_wdata(intf_net_axi_interconnect_M01_AXI_WDATA),
        .M01_AXI_wready(intf_net_axi_interconnect_M01_AXI_WREADY),
        .M01_AXI_wstrb(intf_net_axi_interconnect_M01_AXI_WSTRB),
        .M01_AXI_wvalid(intf_net_axi_interconnect_M01_AXI_WVALID),
        .M02_ACLK(net_bdry_in_ACLK),
        .M02_ARESETN(net_bdry_in_ARESETN),
        .M02_AXI_araddr(intf_net_axi_interconnect_M02_AXI_ARADDR),
        .M02_AXI_arready(intf_net_axi_interconnect_M02_AXI_ARREADY),
        .M02_AXI_arvalid(intf_net_axi_interconnect_M02_AXI_ARVALID),
        .M02_AXI_awaddr(intf_net_axi_interconnect_M02_AXI_AWADDR),
        .M02_AXI_awready(intf_net_axi_interconnect_M02_AXI_AWREADY),
        .M02_AXI_awvalid(intf_net_axi_interconnect_M02_AXI_AWVALID),
        .M02_AXI_bready(intf_net_axi_interconnect_M02_AXI_BREADY),
        .M02_AXI_bresp(intf_net_axi_interconnect_M02_AXI_BRESP),
        .M02_AXI_bvalid(intf_net_axi_interconnect_M02_AXI_BVALID),
        .M02_AXI_rdata(intf_net_axi_interconnect_M02_AXI_RDATA),
        .M02_AXI_rready(intf_net_axi_interconnect_M02_AXI_RREADY),
        .M02_AXI_rresp(intf_net_axi_interconnect_M02_AXI_RRESP),
        .M02_AXI_rvalid(intf_net_axi_interconnect_M02_AXI_RVALID),
        .M02_AXI_wdata(intf_net_axi_interconnect_M02_AXI_WDATA),
        .M02_AXI_wready(intf_net_axi_interconnect_M02_AXI_WREADY),
        .M02_AXI_wstrb(intf_net_axi_interconnect_M02_AXI_WSTRB),
        .M02_AXI_wvalid(intf_net_axi_interconnect_M02_AXI_WVALID),
        .S00_ACLK(net_bdry_in_ACLK),
        .S00_ARESETN(net_bdry_in_ARESETN),
        .S00_AXI_araddr(intf_net_bdry_in_S00_AXI_ARADDR),
        .S00_AXI_arprot(intf_net_bdry_in_S00_AXI_ARPROT),
        .S00_AXI_arready(intf_net_bdry_in_S00_AXI_ARREADY),
        .S00_AXI_arvalid(intf_net_bdry_in_S00_AXI_ARVALID),
        .S00_AXI_awaddr(intf_net_bdry_in_S00_AXI_AWADDR),
        .S00_AXI_awprot(intf_net_bdry_in_S00_AXI_AWPROT),
        .S00_AXI_awready(intf_net_bdry_in_S00_AXI_AWREADY),
        .S00_AXI_awvalid(intf_net_bdry_in_S00_AXI_AWVALID),
        .S00_AXI_bready(intf_net_bdry_in_S00_AXI_BREADY),
        .S00_AXI_bresp(intf_net_bdry_in_S00_AXI_BRESP),
        .S00_AXI_bvalid(intf_net_bdry_in_S00_AXI_BVALID),
        .S00_AXI_rdata(intf_net_bdry_in_S00_AXI_RDATA),
        .S00_AXI_rready(intf_net_bdry_in_S00_AXI_RREADY),
        .S00_AXI_rresp(intf_net_bdry_in_S00_AXI_RRESP),
        .S00_AXI_rvalid(intf_net_bdry_in_S00_AXI_RVALID),
        .S00_AXI_wdata(intf_net_bdry_in_S00_AXI_WDATA),
        .S00_AXI_wready(intf_net_bdry_in_S00_AXI_WREADY),
        .S00_AXI_wstrb(intf_net_bdry_in_S00_AXI_WSTRB),
        .S00_AXI_wvalid(intf_net_bdry_in_S00_AXI_WVALID));
  exdes_clk_wiz_0 clk_wiz
       (.clk_in1(net_bdry_in_ACLK),
        .clk_out1(net_clk_wiz_clk_out1),
        .locked(net_clk_wiz_locked),
        .s_axi_aclk(net_bdry_in_ACLK),
        .s_axi_araddr(intf_net_axi_interconnect_M02_AXI_ARADDR[10:0]),
        .s_axi_aresetn(net_bdry_in_ARESETN),
        .s_axi_arready(intf_net_axi_interconnect_M02_AXI_ARREADY),
        .s_axi_arvalid(intf_net_axi_interconnect_M02_AXI_ARVALID),
        .s_axi_awaddr(intf_net_axi_interconnect_M02_AXI_AWADDR[10:0]),
        .s_axi_awready(intf_net_axi_interconnect_M02_AXI_AWREADY),
        .s_axi_awvalid(intf_net_axi_interconnect_M02_AXI_AWVALID),
        .s_axi_bready(intf_net_axi_interconnect_M02_AXI_BREADY),
        .s_axi_bresp(intf_net_axi_interconnect_M02_AXI_BRESP),
        .s_axi_bvalid(intf_net_axi_interconnect_M02_AXI_BVALID),
        .s_axi_rdata(intf_net_axi_interconnect_M02_AXI_RDATA),
        .s_axi_rready(intf_net_axi_interconnect_M02_AXI_RREADY),
        .s_axi_rresp(intf_net_axi_interconnect_M02_AXI_RRESP),
        .s_axi_rvalid(intf_net_axi_interconnect_M02_AXI_RVALID),
        .s_axi_wdata(intf_net_axi_interconnect_M02_AXI_WDATA),
        .s_axi_wready(intf_net_axi_interconnect_M02_AXI_WREADY),
        .s_axi_wstrb(intf_net_axi_interconnect_M02_AXI_WSTRB),
        .s_axi_wvalid(intf_net_axi_interconnect_M02_AXI_WVALID));
  exdes_hdmi_acr_ctrl_0 hdmi_acr_ctrl
       (.aud_acr_cts_in(net_bdry_in_aud_acr_cts_in),
        .aud_acr_cts_out(net_hdmi_acr_ctrl_aud_acr_cts_out),
        .aud_acr_n_in(net_bdry_in_aud_acr_n_in),
        .aud_acr_n_out(net_hdmi_acr_ctrl_aud_acr_n_out),
        .aud_acr_valid_in(net_bdry_in_aud_acr_valid_in),
        .aud_acr_valid_out(net_hdmi_acr_ctrl_aud_acr_valid_out),
        .aud_clk(net_clk_wiz_clk_out1),
        .aud_resetn_out(net_hdmi_acr_ctrl_aud_resetn_out),
        .axi_aclk(net_bdry_in_ACLK),
        .axi_araddr(intf_net_axi_interconnect_M01_AXI_ARADDR),
        .axi_aresetn(net_bdry_in_ARESETN),
        .axi_arready(intf_net_axi_interconnect_M01_AXI_ARREADY),
        .axi_arvalid(intf_net_axi_interconnect_M01_AXI_ARVALID),
        .axi_awaddr(intf_net_axi_interconnect_M01_AXI_AWADDR),
        .axi_awready(intf_net_axi_interconnect_M01_AXI_AWREADY),
        .axi_awvalid(intf_net_axi_interconnect_M01_AXI_AWVALID),
        .axi_bready(intf_net_axi_interconnect_M01_AXI_BREADY),
        .axi_bresp(intf_net_axi_interconnect_M01_AXI_BRESP),
        .axi_bvalid(intf_net_axi_interconnect_M01_AXI_BVALID),
        .axi_rdata(intf_net_axi_interconnect_M01_AXI_RDATA),
        .axi_rready(intf_net_axi_interconnect_M01_AXI_RREADY),
        .axi_rresp(intf_net_axi_interconnect_M01_AXI_RRESP),
        .axi_rvalid(intf_net_axi_interconnect_M01_AXI_RVALID),
        .axi_wdata(intf_net_axi_interconnect_M01_AXI_WDATA),
        .axi_wready(intf_net_axi_interconnect_M01_AXI_WREADY),
        .axi_wstrb(intf_net_axi_interconnect_M01_AXI_WSTRB),
        .axi_wvalid(intf_net_axi_interconnect_M01_AXI_WVALID),
        .hdmi_clk(net_bdry_in_hdmi_clk),
        .pll_lock_in(net_clk_wiz_locked));
endmodule

(* CORE_GENERATION_INFO = "exdes,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=exdes,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=50,numReposBlks=31,numNonXlnxBlks=0,numHierBlks=19,maxHierDepth=1,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "exdes.hwdef" *) 
module exdes
   (DRU_CLK_IN_clk_n,
    DRU_CLK_IN_clk_p,
    HDMI_RX_CLK_N_IN,
    HDMI_RX_CLK_P_IN,
    HDMI_RX_DAT_N_IN,
    HDMI_RX_DAT_P_IN,
    HDMI_TX_CLK_N_OUT,
    HDMI_TX_CLK_P_OUT,
    HDMI_TX_DAT_N_OUT,
    HDMI_TX_DAT_P_OUT,
    LED0,
    RX_DDC_OUT_scl_i,
    RX_DDC_OUT_scl_o,
    RX_DDC_OUT_scl_t,
    RX_DDC_OUT_sda_i,
    RX_DDC_OUT_sda_o,
    RX_DDC_OUT_sda_t,
    RX_DET_IN,
    RX_HPD_OUT,
    RX_I2C_EN_N_OUT,
    RX_REFCLK_N_OUT,
    RX_REFCLK_P_OUT,
    SI5324_LOL_IN,
    SI5324_RST_OUT,
    TX_CLKSEL_OUT,
    TX_DDC_OUT_scl_i,
    TX_DDC_OUT_scl_o,
    TX_DDC_OUT_scl_t,
    TX_DDC_OUT_sda_i,
    TX_DDC_OUT_sda_o,
    TX_DDC_OUT_sda_t,
    TX_EN_OUT,
    TX_HPD_IN,
    TX_REFCLK_N_IN,
    TX_REFCLK_P_IN,
    fmch_iic_scl_i,
    fmch_iic_scl_o,
    fmch_iic_scl_t,
    fmch_iic_sda_i,
    fmch_iic_sda_o,
    fmch_iic_sda_t,
    reset,
    rs232_uart_rxd,
    rs232_uart_txd,
    sys_diff_clock_clk_n,
    sys_diff_clock_clk_p);
  (* X_INTERFACE_INFO = "xilinx.com:interface:diff_clock:1.0 DRU_CLK_IN CLK_N" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME DRU_CLK_IN, CAN_DEBUG false, FREQ_HZ 125000000" *) input [0:0]DRU_CLK_IN_clk_n;
  (* X_INTERFACE_INFO = "xilinx.com:interface:diff_clock:1.0 DRU_CLK_IN CLK_P" *) input [0:0]DRU_CLK_IN_clk_p;
  input HDMI_RX_CLK_N_IN;
  input HDMI_RX_CLK_P_IN;
  input [2:0]HDMI_RX_DAT_N_IN;
  input [2:0]HDMI_RX_DAT_P_IN;
  output HDMI_TX_CLK_N_OUT;
  output HDMI_TX_CLK_P_OUT;
  output [2:0]HDMI_TX_DAT_N_OUT;
  output [2:0]HDMI_TX_DAT_P_OUT;
  output LED0;
  (* X_INTERFACE_INFO = "xilinx.com:interface:iic:1.0 RX_DDC_OUT SCL_I" *) input RX_DDC_OUT_scl_i;
  (* X_INTERFACE_INFO = "xilinx.com:interface:iic:1.0 RX_DDC_OUT SCL_O" *) output RX_DDC_OUT_scl_o;
  (* X_INTERFACE_INFO = "xilinx.com:interface:iic:1.0 RX_DDC_OUT SCL_T" *) output RX_DDC_OUT_scl_t;
  (* X_INTERFACE_INFO = "xilinx.com:interface:iic:1.0 RX_DDC_OUT SDA_I" *) input RX_DDC_OUT_sda_i;
  (* X_INTERFACE_INFO = "xilinx.com:interface:iic:1.0 RX_DDC_OUT SDA_O" *) output RX_DDC_OUT_sda_o;
  (* X_INTERFACE_INFO = "xilinx.com:interface:iic:1.0 RX_DDC_OUT SDA_T" *) output RX_DDC_OUT_sda_t;
  input RX_DET_IN;
  output [0:0]RX_HPD_OUT;
  output [0:0]RX_I2C_EN_N_OUT;
  output RX_REFCLK_N_OUT;
  output RX_REFCLK_P_OUT;
  input SI5324_LOL_IN;
  output [0:0]SI5324_RST_OUT;
  output [0:0]TX_CLKSEL_OUT;
  (* X_INTERFACE_INFO = "xilinx.com:interface:iic:1.0 TX_DDC_OUT SCL_I" *) input TX_DDC_OUT_scl_i;
  (* X_INTERFACE_INFO = "xilinx.com:interface:iic:1.0 TX_DDC_OUT SCL_O" *) output TX_DDC_OUT_scl_o;
  (* X_INTERFACE_INFO = "xilinx.com:interface:iic:1.0 TX_DDC_OUT SCL_T" *) output TX_DDC_OUT_scl_t;
  (* X_INTERFACE_INFO = "xilinx.com:interface:iic:1.0 TX_DDC_OUT SDA_I" *) input TX_DDC_OUT_sda_i;
  (* X_INTERFACE_INFO = "xilinx.com:interface:iic:1.0 TX_DDC_OUT SDA_O" *) output TX_DDC_OUT_sda_o;
  (* X_INTERFACE_INFO = "xilinx.com:interface:iic:1.0 TX_DDC_OUT SDA_T" *) output TX_DDC_OUT_sda_t;
  output [0:0]TX_EN_OUT;
  input TX_HPD_IN;
  input TX_REFCLK_N_IN;
  input TX_REFCLK_P_IN;
  (* X_INTERFACE_INFO = "xilinx.com:interface:iic:1.0 fmch_iic SCL_I" *) input fmch_iic_scl_i;
  (* X_INTERFACE_INFO = "xilinx.com:interface:iic:1.0 fmch_iic SCL_O" *) output fmch_iic_scl_o;
  (* X_INTERFACE_INFO = "xilinx.com:interface:iic:1.0 fmch_iic SCL_T" *) output fmch_iic_scl_t;
  (* X_INTERFACE_INFO = "xilinx.com:interface:iic:1.0 fmch_iic SDA_I" *) input fmch_iic_sda_i;
  (* X_INTERFACE_INFO = "xilinx.com:interface:iic:1.0 fmch_iic SDA_O" *) output fmch_iic_sda_o;
  (* X_INTERFACE_INFO = "xilinx.com:interface:iic:1.0 fmch_iic SDA_T" *) output fmch_iic_sda_t;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.RESET RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.RESET, INSERT_VIP 0, POLARITY ACTIVE_HIGH" *) input reset;
  (* X_INTERFACE_INFO = "xilinx.com:interface:uart:1.0 rs232_uart RxD" *) input rs232_uart_rxd;
  (* X_INTERFACE_INFO = "xilinx.com:interface:uart:1.0 rs232_uart TxD" *) output rs232_uart_txd;
  (* X_INTERFACE_INFO = "xilinx.com:interface:diff_clock:1.0 sys_diff_clock CLK_N" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME sys_diff_clock, CAN_DEBUG false, FREQ_HZ 200000000" *) input sys_diff_clock_clk_n;
  (* X_INTERFACE_INFO = "xilinx.com:interface:diff_clock:1.0 sys_diff_clock CLK_P" *) input sys_diff_clock_clk_p;

  wire [31:0]intf_net_audio_ss_0_axis_audio_out_TDATA;
  wire [2:0]intf_net_audio_ss_0_axis_audio_out_TID;
  wire intf_net_audio_ss_0_axis_audio_out_TREADY;
  wire intf_net_audio_ss_0_axis_audio_out_TVALID;
  wire [0:0]intf_net_bdry_in_DRU_CLK_IN_CLK_N;
  wire [0:0]intf_net_bdry_in_DRU_CLK_IN_CLK_P;
  wire intf_net_mb_ss_0_IIC_SCL_I;
  wire intf_net_mb_ss_0_IIC_SCL_O;
  wire intf_net_mb_ss_0_IIC_SCL_T;
  wire intf_net_mb_ss_0_IIC_SDA_I;
  wire intf_net_mb_ss_0_IIC_SDA_O;
  wire intf_net_mb_ss_0_IIC_SDA_T;
  wire [31:0]intf_net_mb_ss_0_M00_AXI_ARADDR;
  wire [2:0]intf_net_mb_ss_0_M00_AXI_ARPROT;
  wire intf_net_mb_ss_0_M00_AXI_ARREADY;
  wire [0:0]intf_net_mb_ss_0_M00_AXI_ARVALID;
  wire [31:0]intf_net_mb_ss_0_M00_AXI_AWADDR;
  wire [2:0]intf_net_mb_ss_0_M00_AXI_AWPROT;
  wire intf_net_mb_ss_0_M00_AXI_AWREADY;
  wire [0:0]intf_net_mb_ss_0_M00_AXI_AWVALID;
  wire [0:0]intf_net_mb_ss_0_M00_AXI_BREADY;
  wire [1:0]intf_net_mb_ss_0_M00_AXI_BRESP;
  wire intf_net_mb_ss_0_M00_AXI_BVALID;
  wire [31:0]intf_net_mb_ss_0_M00_AXI_RDATA;
  wire [0:0]intf_net_mb_ss_0_M00_AXI_RREADY;
  wire [1:0]intf_net_mb_ss_0_M00_AXI_RRESP;
  wire intf_net_mb_ss_0_M00_AXI_RVALID;
  wire [31:0]intf_net_mb_ss_0_M00_AXI_WDATA;
  wire intf_net_mb_ss_0_M00_AXI_WREADY;
  wire [3:0]intf_net_mb_ss_0_M00_AXI_WSTRB;
  wire [0:0]intf_net_mb_ss_0_M00_AXI_WVALID;
  wire [31:0]intf_net_mb_ss_0_M01_AXI_ARADDR;
  wire [2:0]intf_net_mb_ss_0_M01_AXI_ARPROT;
  wire intf_net_mb_ss_0_M01_AXI_ARREADY;
  wire [0:0]intf_net_mb_ss_0_M01_AXI_ARVALID;
  wire [31:0]intf_net_mb_ss_0_M01_AXI_AWADDR;
  wire [2:0]intf_net_mb_ss_0_M01_AXI_AWPROT;
  wire intf_net_mb_ss_0_M01_AXI_AWREADY;
  wire [0:0]intf_net_mb_ss_0_M01_AXI_AWVALID;
  wire [0:0]intf_net_mb_ss_0_M01_AXI_BREADY;
  wire [1:0]intf_net_mb_ss_0_M01_AXI_BRESP;
  wire intf_net_mb_ss_0_M01_AXI_BVALID;
  wire [31:0]intf_net_mb_ss_0_M01_AXI_RDATA;
  wire [0:0]intf_net_mb_ss_0_M01_AXI_RREADY;
  wire [1:0]intf_net_mb_ss_0_M01_AXI_RRESP;
  wire intf_net_mb_ss_0_M01_AXI_RVALID;
  wire [31:0]intf_net_mb_ss_0_M01_AXI_WDATA;
  wire intf_net_mb_ss_0_M01_AXI_WREADY;
  wire [3:0]intf_net_mb_ss_0_M01_AXI_WSTRB;
  wire [0:0]intf_net_mb_ss_0_M01_AXI_WVALID;
  wire [31:0]intf_net_mb_ss_0_M02_AXI_ARADDR;
  wire [2:0]intf_net_mb_ss_0_M02_AXI_ARPROT;
  wire [0:0]intf_net_mb_ss_0_M02_AXI_ARREADY;
  wire [0:0]intf_net_mb_ss_0_M02_AXI_ARVALID;
  wire [31:0]intf_net_mb_ss_0_M02_AXI_AWADDR;
  wire [2:0]intf_net_mb_ss_0_M02_AXI_AWPROT;
  wire [0:0]intf_net_mb_ss_0_M02_AXI_AWREADY;
  wire [0:0]intf_net_mb_ss_0_M02_AXI_AWVALID;
  wire [0:0]intf_net_mb_ss_0_M02_AXI_BREADY;
  wire [1:0]intf_net_mb_ss_0_M02_AXI_BRESP;
  wire [0:0]intf_net_mb_ss_0_M02_AXI_BVALID;
  wire [31:0]intf_net_mb_ss_0_M02_AXI_RDATA;
  wire [0:0]intf_net_mb_ss_0_M02_AXI_RREADY;
  wire [1:0]intf_net_mb_ss_0_M02_AXI_RRESP;
  wire [0:0]intf_net_mb_ss_0_M02_AXI_RVALID;
  wire [31:0]intf_net_mb_ss_0_M02_AXI_WDATA;
  wire [0:0]intf_net_mb_ss_0_M02_AXI_WREADY;
  wire [3:0]intf_net_mb_ss_0_M02_AXI_WSTRB;
  wire [0:0]intf_net_mb_ss_0_M02_AXI_WVALID;
  wire [7:0]intf_net_mb_ss_0_M05_AXI_ARADDR;
  wire intf_net_mb_ss_0_M05_AXI_ARREADY;
  wire intf_net_mb_ss_0_M05_AXI_ARVALID;
  wire [7:0]intf_net_mb_ss_0_M05_AXI_AWADDR;
  wire intf_net_mb_ss_0_M05_AXI_AWREADY;
  wire intf_net_mb_ss_0_M05_AXI_AWVALID;
  wire intf_net_mb_ss_0_M05_AXI_BREADY;
  wire [1:0]intf_net_mb_ss_0_M05_AXI_BRESP;
  wire intf_net_mb_ss_0_M05_AXI_BVALID;
  wire [31:0]intf_net_mb_ss_0_M05_AXI_RDATA;
  wire intf_net_mb_ss_0_M05_AXI_RREADY;
  wire [1:0]intf_net_mb_ss_0_M05_AXI_RRESP;
  wire intf_net_mb_ss_0_M05_AXI_RVALID;
  wire [31:0]intf_net_mb_ss_0_M05_AXI_WDATA;
  wire intf_net_mb_ss_0_M05_AXI_WREADY;
  wire [3:0]intf_net_mb_ss_0_M05_AXI_WSTRB;
  wire intf_net_mb_ss_0_M05_AXI_WVALID;
  wire [31:0]intf_net_mb_ss_0_M06_AXI_ARADDR;
  wire [2:0]intf_net_mb_ss_0_M06_AXI_ARPROT;
  wire [0:0]intf_net_mb_ss_0_M06_AXI_ARREADY;
  wire [0:0]intf_net_mb_ss_0_M06_AXI_ARVALID;
  wire [31:0]intf_net_mb_ss_0_M06_AXI_AWADDR;
  wire [2:0]intf_net_mb_ss_0_M06_AXI_AWPROT;
  wire [0:0]intf_net_mb_ss_0_M06_AXI_AWREADY;
  wire [0:0]intf_net_mb_ss_0_M06_AXI_AWVALID;
  wire [0:0]intf_net_mb_ss_0_M06_AXI_BREADY;
  wire [1:0]intf_net_mb_ss_0_M06_AXI_BRESP;
  wire [0:0]intf_net_mb_ss_0_M06_AXI_BVALID;
  wire [31:0]intf_net_mb_ss_0_M06_AXI_RDATA;
  wire [0:0]intf_net_mb_ss_0_M06_AXI_RREADY;
  wire [1:0]intf_net_mb_ss_0_M06_AXI_RRESP;
  wire [0:0]intf_net_mb_ss_0_M06_AXI_RVALID;
  wire [31:0]intf_net_mb_ss_0_M06_AXI_WDATA;
  wire [0:0]intf_net_mb_ss_0_M06_AXI_WREADY;
  wire [3:0]intf_net_mb_ss_0_M06_AXI_WSTRB;
  wire [0:0]intf_net_mb_ss_0_M06_AXI_WVALID;
  wire [8:0]intf_net_mb_ss_0_M08_AXI_ARADDR;
  wire intf_net_mb_ss_0_M08_AXI_ARREADY;
  wire intf_net_mb_ss_0_M08_AXI_ARVALID;
  wire [8:0]intf_net_mb_ss_0_M08_AXI_AWADDR;
  wire intf_net_mb_ss_0_M08_AXI_AWREADY;
  wire intf_net_mb_ss_0_M08_AXI_AWVALID;
  wire intf_net_mb_ss_0_M08_AXI_BREADY;
  wire [1:0]intf_net_mb_ss_0_M08_AXI_BRESP;
  wire intf_net_mb_ss_0_M08_AXI_BVALID;
  wire [31:0]intf_net_mb_ss_0_M08_AXI_RDATA;
  wire intf_net_mb_ss_0_M08_AXI_RREADY;
  wire [1:0]intf_net_mb_ss_0_M08_AXI_RRESP;
  wire intf_net_mb_ss_0_M08_AXI_RVALID;
  wire [31:0]intf_net_mb_ss_0_M08_AXI_WDATA;
  wire intf_net_mb_ss_0_M08_AXI_WREADY;
  wire [3:0]intf_net_mb_ss_0_M08_AXI_WSTRB;
  wire intf_net_mb_ss_0_M08_AXI_WVALID;
  wire intf_net_mb_ss_0_UART_RxD;
  wire intf_net_mb_ss_0_UART_TxD;
  wire [47:0]intf_net_rx_video_axis_reg_slice_M_AXIS_TDATA;
  wire intf_net_rx_video_axis_reg_slice_M_AXIS_TLAST;
  wire intf_net_rx_video_axis_reg_slice_M_AXIS_TREADY;
  wire [0:0]intf_net_rx_video_axis_reg_slice_M_AXIS_TUSER;
  wire intf_net_rx_video_axis_reg_slice_M_AXIS_TVALID;
  wire [47:0]intf_net_tx_video_axis_reg_slice_M_AXIS_TDATA;
  wire intf_net_tx_video_axis_reg_slice_M_AXIS_TLAST;
  wire intf_net_tx_video_axis_reg_slice_M_AXIS_TREADY;
  wire [0:0]intf_net_tx_video_axis_reg_slice_M_AXIS_TUSER;
  wire intf_net_tx_video_axis_reg_slice_M_AXIS_TVALID;
  wire [31:0]intf_net_v_hdmi_rx_ss_AUDIO_OUT_TDATA;
  wire [7:0]intf_net_v_hdmi_rx_ss_AUDIO_OUT_TID;
  wire intf_net_v_hdmi_rx_ss_AUDIO_OUT_TREADY;
  wire intf_net_v_hdmi_rx_ss_AUDIO_OUT_TVALID;
  wire intf_net_v_hdmi_rx_ss_DDC_OUT_SCL_I;
  wire intf_net_v_hdmi_rx_ss_DDC_OUT_SCL_O;
  wire intf_net_v_hdmi_rx_ss_DDC_OUT_SCL_T;
  wire intf_net_v_hdmi_rx_ss_DDC_OUT_SDA_I;
  wire intf_net_v_hdmi_rx_ss_DDC_OUT_SDA_O;
  wire intf_net_v_hdmi_rx_ss_DDC_OUT_SDA_T;
  wire [47:0]intf_net_v_hdmi_rx_ss_VIDEO_OUT_TDATA;
  wire intf_net_v_hdmi_rx_ss_VIDEO_OUT_TLAST;
  wire intf_net_v_hdmi_rx_ss_VIDEO_OUT_TREADY;
  wire intf_net_v_hdmi_rx_ss_VIDEO_OUT_TUSER;
  wire intf_net_v_hdmi_rx_ss_VIDEO_OUT_TVALID;
  wire intf_net_v_hdmi_tx_ss_DDC_OUT_SCL_I;
  wire intf_net_v_hdmi_tx_ss_DDC_OUT_SCL_O;
  wire intf_net_v_hdmi_tx_ss_DDC_OUT_SCL_T;
  wire intf_net_v_hdmi_tx_ss_DDC_OUT_SDA_I;
  wire intf_net_v_hdmi_tx_ss_DDC_OUT_SDA_O;
  wire intf_net_v_hdmi_tx_ss_DDC_OUT_SDA_T;
  wire [19:0]intf_net_v_hdmi_tx_ss_LINK_DATA0_OUT_TDATA;
  wire intf_net_v_hdmi_tx_ss_LINK_DATA0_OUT_TVALID;
  wire [19:0]intf_net_v_hdmi_tx_ss_LINK_DATA1_OUT_TDATA;
  wire intf_net_v_hdmi_tx_ss_LINK_DATA1_OUT_TVALID;
  wire [19:0]intf_net_v_hdmi_tx_ss_LINK_DATA2_OUT_TDATA;
  wire intf_net_v_hdmi_tx_ss_LINK_DATA2_OUT_TVALID;
  wire [47:0]intf_net_v_tpg_ss_0_m_axis_video_TDATA;
  wire [0:0]intf_net_v_tpg_ss_0_m_axis_video_TDEST;
  wire [0:0]intf_net_v_tpg_ss_0_m_axis_video_TID;
  wire [5:0]intf_net_v_tpg_ss_0_m_axis_video_TKEEP;
  wire [0:0]intf_net_v_tpg_ss_0_m_axis_video_TLAST;
  wire intf_net_v_tpg_ss_0_m_axis_video_TREADY;
  wire [5:0]intf_net_v_tpg_ss_0_m_axis_video_TSTRB;
  wire [0:0]intf_net_v_tpg_ss_0_m_axis_video_TUSER;
  wire intf_net_v_tpg_ss_0_m_axis_video_TVALID;
  wire [19:0]intf_net_vid_phy_controller_vid_phy_rx_axi4s_ch0_TDATA;
  wire intf_net_vid_phy_controller_vid_phy_rx_axi4s_ch0_TVALID;
  wire [19:0]intf_net_vid_phy_controller_vid_phy_rx_axi4s_ch1_TDATA;
  wire intf_net_vid_phy_controller_vid_phy_rx_axi4s_ch1_TVALID;
  wire [19:0]intf_net_vid_phy_controller_vid_phy_rx_axi4s_ch2_TDATA;
  wire intf_net_vid_phy_controller_vid_phy_rx_axi4s_ch2_TVALID;
  wire [1:0]intf_net_vid_phy_controller_vid_phy_status_sb_rx_TDATA;
  wire intf_net_vid_phy_controller_vid_phy_status_sb_rx_TVALID;
  wire [1:0]intf_net_vid_phy_controller_vid_phy_status_sb_tx_TDATA;
  wire intf_net_vid_phy_controller_vid_phy_status_sb_tx_TVALID;
  wire [19:0]net_audio_ss_0_aud_acr_cts_out;
  wire [19:0]net_audio_ss_0_aud_acr_n_out;
  wire net_audio_ss_0_aud_acr_valid_out;
  wire net_audio_ss_0_aud_rstn;
  wire net_audio_ss_0_audio_clk;
  wire net_bdry_in_HDMI_RX_CLK_N_IN;
  wire net_bdry_in_HDMI_RX_CLK_P_IN;
  wire [2:0]net_bdry_in_HDMI_RX_DAT_N_IN;
  wire [2:0]net_bdry_in_HDMI_RX_DAT_P_IN;
  wire net_bdry_in_RX_DET_IN;
  wire net_bdry_in_SI5324_LOL_IN;
  wire net_bdry_in_TX_HPD_IN;
  wire net_bdry_in_TX_REFCLK_N_IN;
  wire net_bdry_in_TX_REFCLK_P_IN;
  wire net_bdry_in_reset;
  wire [0:0]net_gnd_const_dout;
  wire [0:0]net_gt_refclk_buf_IBUF_OUT;
  wire net_mb_ss_0_clk_out2;
  wire [0:0]net_mb_ss_0_dcm_locked;
  wire [0:0]net_mb_ss_0_peripheral_aresetn;
  wire net_mb_ss_0_s_axi_aclk;
  wire [19:0]net_v_hdmi_rx_ss_acr_cts;
  wire [19:0]net_v_hdmi_rx_ss_acr_n;
  wire net_v_hdmi_rx_ss_acr_valid;
  wire net_v_hdmi_rx_ss_fid;
  wire [0:0]net_v_hdmi_rx_ss_hpd;
  wire net_v_hdmi_rx_ss_irq;
  wire net_v_hdmi_tx_ss_irq;
  wire net_v_hdmi_tx_ss_locked;
  wire [0:0]net_vcc_const_dout;
  wire net_vid_phy_controller_irq;
  wire [2:0]net_vid_phy_controller_phy_txn_out;
  wire [2:0]net_vid_phy_controller_phy_txp_out;
  wire net_vid_phy_controller_rx_tmds_clk_n;
  wire net_vid_phy_controller_rx_tmds_clk_p;
  wire net_vid_phy_controller_rx_video_clk;
  wire net_vid_phy_controller_rxoutclk;
  wire net_vid_phy_controller_tx_tmds_clk;
  wire net_vid_phy_controller_tx_tmds_clk_n;
  wire net_vid_phy_controller_tx_tmds_clk_p;
  wire net_vid_phy_controller_tx_video_clk;
  wire net_vid_phy_controller_txoutclk;
  wire sys_diff_clock_1_CLK_N;
  wire sys_diff_clock_1_CLK_P;

  assign HDMI_TX_CLK_N_OUT = net_vid_phy_controller_tx_tmds_clk_n;
  assign HDMI_TX_CLK_P_OUT = net_vid_phy_controller_tx_tmds_clk_p;
  assign HDMI_TX_DAT_N_OUT[2:0] = net_vid_phy_controller_phy_txn_out;
  assign HDMI_TX_DAT_P_OUT[2:0] = net_vid_phy_controller_phy_txp_out;
  assign LED0 = net_v_hdmi_tx_ss_locked;
  assign RX_DDC_OUT_scl_o = intf_net_v_hdmi_rx_ss_DDC_OUT_SCL_O;
  assign RX_DDC_OUT_scl_t = intf_net_v_hdmi_rx_ss_DDC_OUT_SCL_T;
  assign RX_DDC_OUT_sda_o = intf_net_v_hdmi_rx_ss_DDC_OUT_SDA_O;
  assign RX_DDC_OUT_sda_t = intf_net_v_hdmi_rx_ss_DDC_OUT_SDA_T;
  assign RX_HPD_OUT[0] = net_v_hdmi_rx_ss_hpd;
  assign RX_I2C_EN_N_OUT[0] = net_gnd_const_dout;
  assign RX_REFCLK_N_OUT = net_vid_phy_controller_rx_tmds_clk_n;
  assign RX_REFCLK_P_OUT = net_vid_phy_controller_rx_tmds_clk_p;
  assign SI5324_RST_OUT[0] = net_mb_ss_0_peripheral_aresetn;
  assign TX_CLKSEL_OUT[0] = net_vcc_const_dout;
  assign TX_DDC_OUT_scl_o = intf_net_v_hdmi_tx_ss_DDC_OUT_SCL_O;
  assign TX_DDC_OUT_scl_t = intf_net_v_hdmi_tx_ss_DDC_OUT_SCL_T;
  assign TX_DDC_OUT_sda_o = intf_net_v_hdmi_tx_ss_DDC_OUT_SDA_O;
  assign TX_DDC_OUT_sda_t = intf_net_v_hdmi_tx_ss_DDC_OUT_SDA_T;
  assign TX_EN_OUT[0] = net_vcc_const_dout;
  assign fmch_iic_scl_o = intf_net_mb_ss_0_IIC_SCL_O;
  assign fmch_iic_scl_t = intf_net_mb_ss_0_IIC_SCL_T;
  assign fmch_iic_sda_o = intf_net_mb_ss_0_IIC_SDA_O;
  assign fmch_iic_sda_t = intf_net_mb_ss_0_IIC_SDA_T;
  assign intf_net_bdry_in_DRU_CLK_IN_CLK_N = DRU_CLK_IN_clk_n[0];
  assign intf_net_bdry_in_DRU_CLK_IN_CLK_P = DRU_CLK_IN_clk_p[0];
  assign intf_net_mb_ss_0_IIC_SCL_I = fmch_iic_scl_i;
  assign intf_net_mb_ss_0_IIC_SDA_I = fmch_iic_sda_i;
  assign intf_net_mb_ss_0_UART_RxD = rs232_uart_rxd;
  assign intf_net_v_hdmi_rx_ss_DDC_OUT_SCL_I = RX_DDC_OUT_scl_i;
  assign intf_net_v_hdmi_rx_ss_DDC_OUT_SDA_I = RX_DDC_OUT_sda_i;
  assign intf_net_v_hdmi_tx_ss_DDC_OUT_SCL_I = TX_DDC_OUT_scl_i;
  assign intf_net_v_hdmi_tx_ss_DDC_OUT_SDA_I = TX_DDC_OUT_sda_i;
  assign net_bdry_in_HDMI_RX_CLK_N_IN = HDMI_RX_CLK_N_IN;
  assign net_bdry_in_HDMI_RX_CLK_P_IN = HDMI_RX_CLK_P_IN;
  assign net_bdry_in_HDMI_RX_DAT_N_IN = HDMI_RX_DAT_N_IN[2:0];
  assign net_bdry_in_HDMI_RX_DAT_P_IN = HDMI_RX_DAT_P_IN[2:0];
  assign net_bdry_in_RX_DET_IN = RX_DET_IN;
  assign net_bdry_in_SI5324_LOL_IN = SI5324_LOL_IN;
  assign net_bdry_in_TX_HPD_IN = TX_HPD_IN;
  assign net_bdry_in_TX_REFCLK_N_IN = TX_REFCLK_N_IN;
  assign net_bdry_in_TX_REFCLK_P_IN = TX_REFCLK_P_IN;
  assign net_bdry_in_reset = reset;
  assign rs232_uart_txd = intf_net_mb_ss_0_UART_TxD;
  assign sys_diff_clock_1_CLK_N = sys_diff_clock_clk_n;
  assign sys_diff_clock_1_CLK_P = sys_diff_clock_clk_p;
  audio_ss_0_imp_L2LLI5 audio_ss_0
       (.ACLK(net_mb_ss_0_s_axi_aclk),
        .ARESETN(net_mb_ss_0_peripheral_aresetn),
        .S00_AXI_araddr(intf_net_mb_ss_0_M06_AXI_ARADDR),
        .S00_AXI_arprot(intf_net_mb_ss_0_M06_AXI_ARPROT),
        .S00_AXI_arready(intf_net_mb_ss_0_M06_AXI_ARREADY),
        .S00_AXI_arvalid(intf_net_mb_ss_0_M06_AXI_ARVALID),
        .S00_AXI_awaddr(intf_net_mb_ss_0_M06_AXI_AWADDR),
        .S00_AXI_awprot(intf_net_mb_ss_0_M06_AXI_AWPROT),
        .S00_AXI_awready(intf_net_mb_ss_0_M06_AXI_AWREADY),
        .S00_AXI_awvalid(intf_net_mb_ss_0_M06_AXI_AWVALID),
        .S00_AXI_bready(intf_net_mb_ss_0_M06_AXI_BREADY),
        .S00_AXI_bresp(intf_net_mb_ss_0_M06_AXI_BRESP),
        .S00_AXI_bvalid(intf_net_mb_ss_0_M06_AXI_BVALID),
        .S00_AXI_rdata(intf_net_mb_ss_0_M06_AXI_RDATA),
        .S00_AXI_rready(intf_net_mb_ss_0_M06_AXI_RREADY),
        .S00_AXI_rresp(intf_net_mb_ss_0_M06_AXI_RRESP),
        .S00_AXI_rvalid(intf_net_mb_ss_0_M06_AXI_RVALID),
        .S00_AXI_wdata(intf_net_mb_ss_0_M06_AXI_WDATA),
        .S00_AXI_wready(intf_net_mb_ss_0_M06_AXI_WREADY),
        .S00_AXI_wstrb(intf_net_mb_ss_0_M06_AXI_WSTRB),
        .S00_AXI_wvalid(intf_net_mb_ss_0_M06_AXI_WVALID),
        .aud_acr_cts_in(net_v_hdmi_rx_ss_acr_cts),
        .aud_acr_cts_out(net_audio_ss_0_aud_acr_cts_out),
        .aud_acr_n_in(net_v_hdmi_rx_ss_acr_n),
        .aud_acr_n_out(net_audio_ss_0_aud_acr_n_out),
        .aud_acr_valid_in(net_v_hdmi_rx_ss_acr_valid),
        .aud_acr_valid_out(net_audio_ss_0_aud_acr_valid_out),
        .aud_rstn(net_audio_ss_0_aud_rstn),
        .audio_clk(net_audio_ss_0_audio_clk),
        .axis_audio_in_tdata(intf_net_v_hdmi_rx_ss_AUDIO_OUT_TDATA),
        .axis_audio_in_tid(intf_net_v_hdmi_rx_ss_AUDIO_OUT_TID),
        .axis_audio_in_tready(intf_net_v_hdmi_rx_ss_AUDIO_OUT_TREADY),
        .axis_audio_in_tvalid(intf_net_v_hdmi_rx_ss_AUDIO_OUT_TVALID),
        .axis_audio_out_tdata(intf_net_audio_ss_0_axis_audio_out_TDATA),
        .axis_audio_out_tid(intf_net_audio_ss_0_axis_audio_out_TID),
        .axis_audio_out_tready(intf_net_audio_ss_0_axis_audio_out_TREADY),
        .axis_audio_out_tvalid(intf_net_audio_ss_0_axis_audio_out_TVALID),
        .hdmi_clk(net_vid_phy_controller_tx_tmds_clk));
  exdes_gnd_const_0 gnd_const
       (.dout(net_gnd_const_dout));
  exdes_gt_refclk_buf_0 gt_refclk_buf
       (.IBUF_DS_N(intf_net_bdry_in_DRU_CLK_IN_CLK_N),
        .IBUF_DS_P(intf_net_bdry_in_DRU_CLK_IN_CLK_P),
        .IBUF_OUT(net_gt_refclk_buf_IBUF_OUT));
  mb_ss_0_imp_F1JHLQ mb_ss_0
       (.IIC_scl_i(intf_net_mb_ss_0_IIC_SCL_I),
        .IIC_scl_o(intf_net_mb_ss_0_IIC_SCL_O),
        .IIC_scl_t(intf_net_mb_ss_0_IIC_SCL_T),
        .IIC_sda_i(intf_net_mb_ss_0_IIC_SDA_I),
        .IIC_sda_o(intf_net_mb_ss_0_IIC_SDA_O),
        .IIC_sda_t(intf_net_mb_ss_0_IIC_SDA_T),
        .M00_AXI_araddr(intf_net_mb_ss_0_M00_AXI_ARADDR),
        .M00_AXI_arprot(intf_net_mb_ss_0_M00_AXI_ARPROT),
        .M00_AXI_arready(intf_net_mb_ss_0_M00_AXI_ARREADY),
        .M00_AXI_arvalid(intf_net_mb_ss_0_M00_AXI_ARVALID),
        .M00_AXI_awaddr(intf_net_mb_ss_0_M00_AXI_AWADDR),
        .M00_AXI_awprot(intf_net_mb_ss_0_M00_AXI_AWPROT),
        .M00_AXI_awready(intf_net_mb_ss_0_M00_AXI_AWREADY),
        .M00_AXI_awvalid(intf_net_mb_ss_0_M00_AXI_AWVALID),
        .M00_AXI_bready(intf_net_mb_ss_0_M00_AXI_BREADY),
        .M00_AXI_bresp(intf_net_mb_ss_0_M00_AXI_BRESP),
        .M00_AXI_bvalid(intf_net_mb_ss_0_M00_AXI_BVALID),
        .M00_AXI_rdata(intf_net_mb_ss_0_M00_AXI_RDATA),
        .M00_AXI_rready(intf_net_mb_ss_0_M00_AXI_RREADY),
        .M00_AXI_rresp(intf_net_mb_ss_0_M00_AXI_RRESP),
        .M00_AXI_rvalid(intf_net_mb_ss_0_M00_AXI_RVALID),
        .M00_AXI_wdata(intf_net_mb_ss_0_M00_AXI_WDATA),
        .M00_AXI_wready(intf_net_mb_ss_0_M00_AXI_WREADY),
        .M00_AXI_wstrb(intf_net_mb_ss_0_M00_AXI_WSTRB),
        .M00_AXI_wvalid(intf_net_mb_ss_0_M00_AXI_WVALID),
        .M01_AXI_araddr(intf_net_mb_ss_0_M01_AXI_ARADDR),
        .M01_AXI_arprot(intf_net_mb_ss_0_M01_AXI_ARPROT),
        .M01_AXI_arready(intf_net_mb_ss_0_M01_AXI_ARREADY),
        .M01_AXI_arvalid(intf_net_mb_ss_0_M01_AXI_ARVALID),
        .M01_AXI_awaddr(intf_net_mb_ss_0_M01_AXI_AWADDR),
        .M01_AXI_awprot(intf_net_mb_ss_0_M01_AXI_AWPROT),
        .M01_AXI_awready(intf_net_mb_ss_0_M01_AXI_AWREADY),
        .M01_AXI_awvalid(intf_net_mb_ss_0_M01_AXI_AWVALID),
        .M01_AXI_bready(intf_net_mb_ss_0_M01_AXI_BREADY),
        .M01_AXI_bresp(intf_net_mb_ss_0_M01_AXI_BRESP),
        .M01_AXI_bvalid(intf_net_mb_ss_0_M01_AXI_BVALID),
        .M01_AXI_rdata(intf_net_mb_ss_0_M01_AXI_RDATA),
        .M01_AXI_rready(intf_net_mb_ss_0_M01_AXI_RREADY),
        .M01_AXI_rresp(intf_net_mb_ss_0_M01_AXI_RRESP),
        .M01_AXI_rvalid(intf_net_mb_ss_0_M01_AXI_RVALID),
        .M01_AXI_wdata(intf_net_mb_ss_0_M01_AXI_WDATA),
        .M01_AXI_wready(intf_net_mb_ss_0_M01_AXI_WREADY),
        .M01_AXI_wstrb(intf_net_mb_ss_0_M01_AXI_WSTRB),
        .M01_AXI_wvalid(intf_net_mb_ss_0_M01_AXI_WVALID),
        .M02_AXI_araddr(intf_net_mb_ss_0_M02_AXI_ARADDR),
        .M02_AXI_arprot(intf_net_mb_ss_0_M02_AXI_ARPROT),
        .M02_AXI_arready(intf_net_mb_ss_0_M02_AXI_ARREADY),
        .M02_AXI_arvalid(intf_net_mb_ss_0_M02_AXI_ARVALID),
        .M02_AXI_awaddr(intf_net_mb_ss_0_M02_AXI_AWADDR),
        .M02_AXI_awprot(intf_net_mb_ss_0_M02_AXI_AWPROT),
        .M02_AXI_awready(intf_net_mb_ss_0_M02_AXI_AWREADY),
        .M02_AXI_awvalid(intf_net_mb_ss_0_M02_AXI_AWVALID),
        .M02_AXI_bready(intf_net_mb_ss_0_M02_AXI_BREADY),
        .M02_AXI_bresp(intf_net_mb_ss_0_M02_AXI_BRESP),
        .M02_AXI_bvalid(intf_net_mb_ss_0_M02_AXI_BVALID),
        .M02_AXI_rdata(intf_net_mb_ss_0_M02_AXI_RDATA),
        .M02_AXI_rready(intf_net_mb_ss_0_M02_AXI_RREADY),
        .M02_AXI_rresp(intf_net_mb_ss_0_M02_AXI_RRESP),
        .M02_AXI_rvalid(intf_net_mb_ss_0_M02_AXI_RVALID),
        .M02_AXI_wdata(intf_net_mb_ss_0_M02_AXI_WDATA),
        .M02_AXI_wready(intf_net_mb_ss_0_M02_AXI_WREADY),
        .M02_AXI_wstrb(intf_net_mb_ss_0_M02_AXI_WSTRB),
        .M02_AXI_wvalid(intf_net_mb_ss_0_M02_AXI_WVALID),
        .M05_AXI_araddr(intf_net_mb_ss_0_M05_AXI_ARADDR),
        .M05_AXI_arready(intf_net_mb_ss_0_M05_AXI_ARREADY),
        .M05_AXI_arvalid(intf_net_mb_ss_0_M05_AXI_ARVALID),
        .M05_AXI_awaddr(intf_net_mb_ss_0_M05_AXI_AWADDR),
        .M05_AXI_awready(intf_net_mb_ss_0_M05_AXI_AWREADY),
        .M05_AXI_awvalid(intf_net_mb_ss_0_M05_AXI_AWVALID),
        .M05_AXI_bready(intf_net_mb_ss_0_M05_AXI_BREADY),
        .M05_AXI_bresp(intf_net_mb_ss_0_M05_AXI_BRESP),
        .M05_AXI_bvalid(intf_net_mb_ss_0_M05_AXI_BVALID),
        .M05_AXI_rdata(intf_net_mb_ss_0_M05_AXI_RDATA),
        .M05_AXI_rready(intf_net_mb_ss_0_M05_AXI_RREADY),
        .M05_AXI_rresp(intf_net_mb_ss_0_M05_AXI_RRESP),
        .M05_AXI_rvalid(intf_net_mb_ss_0_M05_AXI_RVALID),
        .M05_AXI_wdata(intf_net_mb_ss_0_M05_AXI_WDATA),
        .M05_AXI_wready(intf_net_mb_ss_0_M05_AXI_WREADY),
        .M05_AXI_wstrb(intf_net_mb_ss_0_M05_AXI_WSTRB),
        .M05_AXI_wvalid(intf_net_mb_ss_0_M05_AXI_WVALID),
        .M06_AXI_araddr(intf_net_mb_ss_0_M06_AXI_ARADDR),
        .M06_AXI_arprot(intf_net_mb_ss_0_M06_AXI_ARPROT),
        .M06_AXI_arready(intf_net_mb_ss_0_M06_AXI_ARREADY),
        .M06_AXI_arvalid(intf_net_mb_ss_0_M06_AXI_ARVALID),
        .M06_AXI_awaddr(intf_net_mb_ss_0_M06_AXI_AWADDR),
        .M06_AXI_awprot(intf_net_mb_ss_0_M06_AXI_AWPROT),
        .M06_AXI_awready(intf_net_mb_ss_0_M06_AXI_AWREADY),
        .M06_AXI_awvalid(intf_net_mb_ss_0_M06_AXI_AWVALID),
        .M06_AXI_bready(intf_net_mb_ss_0_M06_AXI_BREADY),
        .M06_AXI_bresp(intf_net_mb_ss_0_M06_AXI_BRESP),
        .M06_AXI_bvalid(intf_net_mb_ss_0_M06_AXI_BVALID),
        .M06_AXI_rdata(intf_net_mb_ss_0_M06_AXI_RDATA),
        .M06_AXI_rready(intf_net_mb_ss_0_M06_AXI_RREADY),
        .M06_AXI_rresp(intf_net_mb_ss_0_M06_AXI_RRESP),
        .M06_AXI_rvalid(intf_net_mb_ss_0_M06_AXI_RVALID),
        .M06_AXI_wdata(intf_net_mb_ss_0_M06_AXI_WDATA),
        .M06_AXI_wready(intf_net_mb_ss_0_M06_AXI_WREADY),
        .M06_AXI_wstrb(intf_net_mb_ss_0_M06_AXI_WSTRB),
        .M06_AXI_wvalid(intf_net_mb_ss_0_M06_AXI_WVALID),
        .M08_AXI_araddr(intf_net_mb_ss_0_M08_AXI_ARADDR),
        .M08_AXI_arready(intf_net_mb_ss_0_M08_AXI_ARREADY),
        .M08_AXI_arvalid(intf_net_mb_ss_0_M08_AXI_ARVALID),
        .M08_AXI_awaddr(intf_net_mb_ss_0_M08_AXI_AWADDR),
        .M08_AXI_awready(intf_net_mb_ss_0_M08_AXI_AWREADY),
        .M08_AXI_awvalid(intf_net_mb_ss_0_M08_AXI_AWVALID),
        .M08_AXI_bready(intf_net_mb_ss_0_M08_AXI_BREADY),
        .M08_AXI_bresp(intf_net_mb_ss_0_M08_AXI_BRESP),
        .M08_AXI_bvalid(intf_net_mb_ss_0_M08_AXI_BVALID),
        .M08_AXI_rdata(intf_net_mb_ss_0_M08_AXI_RDATA),
        .M08_AXI_rready(intf_net_mb_ss_0_M08_AXI_RREADY),
        .M08_AXI_rresp(intf_net_mb_ss_0_M08_AXI_RRESP),
        .M08_AXI_rvalid(intf_net_mb_ss_0_M08_AXI_RVALID),
        .M08_AXI_wdata(intf_net_mb_ss_0_M08_AXI_WDATA),
        .M08_AXI_wready(intf_net_mb_ss_0_M08_AXI_WREADY),
        .M08_AXI_wstrb(intf_net_mb_ss_0_M08_AXI_WSTRB),
        .M08_AXI_wvalid(intf_net_mb_ss_0_M08_AXI_WVALID),
        .UART_rxd(intf_net_mb_ss_0_UART_RxD),
        .UART_txd(intf_net_mb_ss_0_UART_TxD),
        .clk_out2(net_mb_ss_0_clk_out2),
        .dcm_locked(net_mb_ss_0_dcm_locked),
        .ext_reset_in(net_bdry_in_reset),
        .hdmi_rx_irq(net_v_hdmi_rx_ss_irq),
        .hdmi_tx_irq(net_v_hdmi_tx_ss_irq),
        .peripheral_aresetn(net_mb_ss_0_peripheral_aresetn),
        .s_axi_aclk(net_mb_ss_0_s_axi_aclk),
        .sys_diff_clock_clk_n(sys_diff_clock_1_CLK_N),
        .sys_diff_clock_clk_p(sys_diff_clock_1_CLK_P),
        .vphy_irq(net_vid_phy_controller_irq));
  exdes_rx_video_axis_reg_slice_0 rx_video_axis_reg_slice
       (.aclk(net_mb_ss_0_clk_out2),
        .aresetn(net_mb_ss_0_dcm_locked),
        .m_axis_tdata(intf_net_rx_video_axis_reg_slice_M_AXIS_TDATA),
        .m_axis_tlast(intf_net_rx_video_axis_reg_slice_M_AXIS_TLAST),
        .m_axis_tready(intf_net_rx_video_axis_reg_slice_M_AXIS_TREADY),
        .m_axis_tuser(intf_net_rx_video_axis_reg_slice_M_AXIS_TUSER),
        .m_axis_tvalid(intf_net_rx_video_axis_reg_slice_M_AXIS_TVALID),
        .s_axis_tdata(intf_net_v_hdmi_rx_ss_VIDEO_OUT_TDATA),
        .s_axis_tlast(intf_net_v_hdmi_rx_ss_VIDEO_OUT_TLAST),
        .s_axis_tready(intf_net_v_hdmi_rx_ss_VIDEO_OUT_TREADY),
        .s_axis_tuser(intf_net_v_hdmi_rx_ss_VIDEO_OUT_TUSER),
        .s_axis_tvalid(intf_net_v_hdmi_rx_ss_VIDEO_OUT_TVALID));
  exdes_tx_video_axis_reg_slice_0 tx_video_axis_reg_slice
       (.aclk(net_mb_ss_0_clk_out2),
        .aresetn(net_mb_ss_0_dcm_locked),
        .m_axis_tdata(intf_net_tx_video_axis_reg_slice_M_AXIS_TDATA),
        .m_axis_tlast(intf_net_tx_video_axis_reg_slice_M_AXIS_TLAST),
        .m_axis_tready(intf_net_tx_video_axis_reg_slice_M_AXIS_TREADY),
        .m_axis_tuser(intf_net_tx_video_axis_reg_slice_M_AXIS_TUSER),
        .m_axis_tvalid(intf_net_tx_video_axis_reg_slice_M_AXIS_TVALID),
        .s_axis_tdata(intf_net_v_tpg_ss_0_m_axis_video_TDATA),
        .s_axis_tdest(intf_net_v_tpg_ss_0_m_axis_video_TDEST),
        .s_axis_tid(intf_net_v_tpg_ss_0_m_axis_video_TID),
        .s_axis_tkeep(intf_net_v_tpg_ss_0_m_axis_video_TKEEP),
        .s_axis_tlast(intf_net_v_tpg_ss_0_m_axis_video_TLAST),
        .s_axis_tready(intf_net_v_tpg_ss_0_m_axis_video_TREADY),
        .s_axis_tstrb(intf_net_v_tpg_ss_0_m_axis_video_TSTRB),
        .s_axis_tuser(intf_net_v_tpg_ss_0_m_axis_video_TUSER),
        .s_axis_tvalid(intf_net_v_tpg_ss_0_m_axis_video_TVALID));
  exdes_v_hdmi_rx_ss_0 v_hdmi_rx_ss
       (.AUDIO_OUT_tdata(intf_net_v_hdmi_rx_ss_AUDIO_OUT_TDATA),
        .AUDIO_OUT_tid(intf_net_v_hdmi_rx_ss_AUDIO_OUT_TID),
        .AUDIO_OUT_tready(intf_net_v_hdmi_rx_ss_AUDIO_OUT_TREADY),
        .AUDIO_OUT_tvalid(intf_net_v_hdmi_rx_ss_AUDIO_OUT_TVALID),
        .DDC_OUT_scl_i(intf_net_v_hdmi_rx_ss_DDC_OUT_SCL_I),
        .DDC_OUT_scl_o(intf_net_v_hdmi_rx_ss_DDC_OUT_SCL_O),
        .DDC_OUT_scl_t(intf_net_v_hdmi_rx_ss_DDC_OUT_SCL_T),
        .DDC_OUT_sda_i(intf_net_v_hdmi_rx_ss_DDC_OUT_SDA_I),
        .DDC_OUT_sda_o(intf_net_v_hdmi_rx_ss_DDC_OUT_SDA_O),
        .DDC_OUT_sda_t(intf_net_v_hdmi_rx_ss_DDC_OUT_SDA_T),
        .LINK_DATA0_IN_tdata(intf_net_vid_phy_controller_vid_phy_rx_axi4s_ch0_TDATA),
        .LINK_DATA0_IN_tvalid(intf_net_vid_phy_controller_vid_phy_rx_axi4s_ch0_TVALID),
        .LINK_DATA1_IN_tdata(intf_net_vid_phy_controller_vid_phy_rx_axi4s_ch1_TDATA),
        .LINK_DATA1_IN_tvalid(intf_net_vid_phy_controller_vid_phy_rx_axi4s_ch1_TVALID),
        .LINK_DATA2_IN_tdata(intf_net_vid_phy_controller_vid_phy_rx_axi4s_ch2_TDATA),
        .LINK_DATA2_IN_tvalid(intf_net_vid_phy_controller_vid_phy_rx_axi4s_ch2_TVALID),
        .SB_STATUS_IN_tdata(intf_net_vid_phy_controller_vid_phy_status_sb_rx_TDATA),
        .SB_STATUS_IN_tvalid(intf_net_vid_phy_controller_vid_phy_status_sb_rx_TVALID),
        .S_AXI_CPU_IN_araddr(intf_net_mb_ss_0_M01_AXI_ARADDR[8:0]),
        .S_AXI_CPU_IN_arprot(intf_net_mb_ss_0_M01_AXI_ARPROT),
        .S_AXI_CPU_IN_arready(intf_net_mb_ss_0_M01_AXI_ARREADY),
        .S_AXI_CPU_IN_arvalid(intf_net_mb_ss_0_M01_AXI_ARVALID),
        .S_AXI_CPU_IN_awaddr(intf_net_mb_ss_0_M01_AXI_AWADDR[8:0]),
        .S_AXI_CPU_IN_awprot(intf_net_mb_ss_0_M01_AXI_AWPROT),
        .S_AXI_CPU_IN_awready(intf_net_mb_ss_0_M01_AXI_AWREADY),
        .S_AXI_CPU_IN_awvalid(intf_net_mb_ss_0_M01_AXI_AWVALID),
        .S_AXI_CPU_IN_bready(intf_net_mb_ss_0_M01_AXI_BREADY),
        .S_AXI_CPU_IN_bresp(intf_net_mb_ss_0_M01_AXI_BRESP),
        .S_AXI_CPU_IN_bvalid(intf_net_mb_ss_0_M01_AXI_BVALID),
        .S_AXI_CPU_IN_rdata(intf_net_mb_ss_0_M01_AXI_RDATA),
        .S_AXI_CPU_IN_rready(intf_net_mb_ss_0_M01_AXI_RREADY),
        .S_AXI_CPU_IN_rresp(intf_net_mb_ss_0_M01_AXI_RRESP),
        .S_AXI_CPU_IN_rvalid(intf_net_mb_ss_0_M01_AXI_RVALID),
        .S_AXI_CPU_IN_wdata(intf_net_mb_ss_0_M01_AXI_WDATA),
        .S_AXI_CPU_IN_wready(intf_net_mb_ss_0_M01_AXI_WREADY),
        .S_AXI_CPU_IN_wstrb(intf_net_mb_ss_0_M01_AXI_WSTRB),
        .S_AXI_CPU_IN_wvalid(intf_net_mb_ss_0_M01_AXI_WVALID),
        .VIDEO_OUT_tdata(intf_net_v_hdmi_rx_ss_VIDEO_OUT_TDATA),
        .VIDEO_OUT_tlast(intf_net_v_hdmi_rx_ss_VIDEO_OUT_TLAST),
        .VIDEO_OUT_tready(intf_net_v_hdmi_rx_ss_VIDEO_OUT_TREADY),
        .VIDEO_OUT_tuser(intf_net_v_hdmi_rx_ss_VIDEO_OUT_TUSER),
        .VIDEO_OUT_tvalid(intf_net_v_hdmi_rx_ss_VIDEO_OUT_TVALID),
        .acr_cts(net_v_hdmi_rx_ss_acr_cts),
        .acr_n(net_v_hdmi_rx_ss_acr_n),
        .acr_valid(net_v_hdmi_rx_ss_acr_valid),
        .cable_detect(net_bdry_in_RX_DET_IN),
        .fid(net_v_hdmi_rx_ss_fid),
        .hpd(net_v_hdmi_rx_ss_hpd),
        .irq(net_v_hdmi_rx_ss_irq),
        .link_clk(net_vid_phy_controller_rxoutclk),
        .s_axi_cpu_aclk(net_mb_ss_0_s_axi_aclk),
        .s_axi_cpu_aresetn(net_mb_ss_0_peripheral_aresetn),
        .s_axis_audio_aclk(net_audio_ss_0_audio_clk),
        .s_axis_audio_aresetn(net_audio_ss_0_aud_rstn),
        .s_axis_video_aclk(net_mb_ss_0_clk_out2),
        .s_axis_video_aresetn(net_mb_ss_0_dcm_locked),
        .video_clk(net_vid_phy_controller_rx_video_clk));
  exdes_v_hdmi_tx_ss_0 v_hdmi_tx_ss
       (.AUDIO_IN_tdata(intf_net_audio_ss_0_axis_audio_out_TDATA),
        .AUDIO_IN_tid({1'b0,1'b0,1'b0,1'b0,1'b0,intf_net_audio_ss_0_axis_audio_out_TID}),
        .AUDIO_IN_tready(intf_net_audio_ss_0_axis_audio_out_TREADY),
        .AUDIO_IN_tvalid(intf_net_audio_ss_0_axis_audio_out_TVALID),
        .DDC_OUT_scl_i(intf_net_v_hdmi_tx_ss_DDC_OUT_SCL_I),
        .DDC_OUT_scl_o(intf_net_v_hdmi_tx_ss_DDC_OUT_SCL_O),
        .DDC_OUT_scl_t(intf_net_v_hdmi_tx_ss_DDC_OUT_SCL_T),
        .DDC_OUT_sda_i(intf_net_v_hdmi_tx_ss_DDC_OUT_SDA_I),
        .DDC_OUT_sda_o(intf_net_v_hdmi_tx_ss_DDC_OUT_SDA_O),
        .DDC_OUT_sda_t(intf_net_v_hdmi_tx_ss_DDC_OUT_SDA_T),
        .LINK_DATA0_OUT_tdata(intf_net_v_hdmi_tx_ss_LINK_DATA0_OUT_TDATA),
        .LINK_DATA0_OUT_tvalid(intf_net_v_hdmi_tx_ss_LINK_DATA0_OUT_TVALID),
        .LINK_DATA1_OUT_tdata(intf_net_v_hdmi_tx_ss_LINK_DATA1_OUT_TDATA),
        .LINK_DATA1_OUT_tvalid(intf_net_v_hdmi_tx_ss_LINK_DATA1_OUT_TVALID),
        .LINK_DATA2_OUT_tdata(intf_net_v_hdmi_tx_ss_LINK_DATA2_OUT_TDATA),
        .LINK_DATA2_OUT_tvalid(intf_net_v_hdmi_tx_ss_LINK_DATA2_OUT_TVALID),
        .SB_STATUS_IN_tdata(intf_net_vid_phy_controller_vid_phy_status_sb_tx_TDATA),
        .SB_STATUS_IN_tvalid(intf_net_vid_phy_controller_vid_phy_status_sb_tx_TVALID),
        .S_AXI_CPU_IN_araddr(intf_net_mb_ss_0_M02_AXI_ARADDR[16:0]),
        .S_AXI_CPU_IN_arprot(intf_net_mb_ss_0_M02_AXI_ARPROT),
        .S_AXI_CPU_IN_arready(intf_net_mb_ss_0_M02_AXI_ARREADY),
        .S_AXI_CPU_IN_arvalid(intf_net_mb_ss_0_M02_AXI_ARVALID),
        .S_AXI_CPU_IN_awaddr(intf_net_mb_ss_0_M02_AXI_AWADDR[16:0]),
        .S_AXI_CPU_IN_awprot(intf_net_mb_ss_0_M02_AXI_AWPROT),
        .S_AXI_CPU_IN_awready(intf_net_mb_ss_0_M02_AXI_AWREADY),
        .S_AXI_CPU_IN_awvalid(intf_net_mb_ss_0_M02_AXI_AWVALID),
        .S_AXI_CPU_IN_bready(intf_net_mb_ss_0_M02_AXI_BREADY),
        .S_AXI_CPU_IN_bresp(intf_net_mb_ss_0_M02_AXI_BRESP),
        .S_AXI_CPU_IN_bvalid(intf_net_mb_ss_0_M02_AXI_BVALID),
        .S_AXI_CPU_IN_rdata(intf_net_mb_ss_0_M02_AXI_RDATA),
        .S_AXI_CPU_IN_rready(intf_net_mb_ss_0_M02_AXI_RREADY),
        .S_AXI_CPU_IN_rresp(intf_net_mb_ss_0_M02_AXI_RRESP),
        .S_AXI_CPU_IN_rvalid(intf_net_mb_ss_0_M02_AXI_RVALID),
        .S_AXI_CPU_IN_wdata(intf_net_mb_ss_0_M02_AXI_WDATA),
        .S_AXI_CPU_IN_wready(intf_net_mb_ss_0_M02_AXI_WREADY),
        .S_AXI_CPU_IN_wstrb(intf_net_mb_ss_0_M02_AXI_WSTRB),
        .S_AXI_CPU_IN_wvalid(intf_net_mb_ss_0_M02_AXI_WVALID),
        .VIDEO_IN_tdata(intf_net_tx_video_axis_reg_slice_M_AXIS_TDATA),
        .VIDEO_IN_tlast(intf_net_tx_video_axis_reg_slice_M_AXIS_TLAST),
        .VIDEO_IN_tready(intf_net_tx_video_axis_reg_slice_M_AXIS_TREADY),
        .VIDEO_IN_tuser(intf_net_tx_video_axis_reg_slice_M_AXIS_TUSER),
        .VIDEO_IN_tvalid(intf_net_tx_video_axis_reg_slice_M_AXIS_TVALID),
        .acr_cts(net_audio_ss_0_aud_acr_cts_out),
        .acr_n(net_audio_ss_0_aud_acr_n_out),
        .acr_valid(net_audio_ss_0_aud_acr_valid_out),
        .fid(net_v_hdmi_rx_ss_fid),
        .hpd(net_bdry_in_TX_HPD_IN),
        .irq(net_v_hdmi_tx_ss_irq),
        .link_clk(net_vid_phy_controller_txoutclk),
        .locked(net_v_hdmi_tx_ss_locked),
        .s_axi_cpu_aclk(net_mb_ss_0_s_axi_aclk),
        .s_axi_cpu_aresetn(net_mb_ss_0_peripheral_aresetn),
        .s_axis_audio_aclk(net_audio_ss_0_audio_clk),
        .s_axis_audio_aresetn(net_audio_ss_0_aud_rstn),
        .s_axis_video_aclk(net_mb_ss_0_clk_out2),
        .s_axis_video_aresetn(net_mb_ss_0_dcm_locked),
        .video_clk(net_vid_phy_controller_tx_video_clk));
  v_tpg_ss_0_imp_5QXXBT v_tpg_ss_0
       (.S_AXI_GPIO_araddr(intf_net_mb_ss_0_M08_AXI_ARADDR),
        .S_AXI_GPIO_arready(intf_net_mb_ss_0_M08_AXI_ARREADY),
        .S_AXI_GPIO_arvalid(intf_net_mb_ss_0_M08_AXI_ARVALID),
        .S_AXI_GPIO_awaddr(intf_net_mb_ss_0_M08_AXI_AWADDR),
        .S_AXI_GPIO_awready(intf_net_mb_ss_0_M08_AXI_AWREADY),
        .S_AXI_GPIO_awvalid(intf_net_mb_ss_0_M08_AXI_AWVALID),
        .S_AXI_GPIO_bready(intf_net_mb_ss_0_M08_AXI_BREADY),
        .S_AXI_GPIO_bresp(intf_net_mb_ss_0_M08_AXI_BRESP),
        .S_AXI_GPIO_bvalid(intf_net_mb_ss_0_M08_AXI_BVALID),
        .S_AXI_GPIO_rdata(intf_net_mb_ss_0_M08_AXI_RDATA),
        .S_AXI_GPIO_rready(intf_net_mb_ss_0_M08_AXI_RREADY),
        .S_AXI_GPIO_rresp(intf_net_mb_ss_0_M08_AXI_RRESP),
        .S_AXI_GPIO_rvalid(intf_net_mb_ss_0_M08_AXI_RVALID),
        .S_AXI_GPIO_wdata(intf_net_mb_ss_0_M08_AXI_WDATA),
        .S_AXI_GPIO_wready(intf_net_mb_ss_0_M08_AXI_WREADY),
        .S_AXI_GPIO_wstrb(intf_net_mb_ss_0_M08_AXI_WSTRB),
        .S_AXI_GPIO_wvalid(intf_net_mb_ss_0_M08_AXI_WVALID),
        .S_AXI_TPG_araddr(intf_net_mb_ss_0_M05_AXI_ARADDR),
        .S_AXI_TPG_arready(intf_net_mb_ss_0_M05_AXI_ARREADY),
        .S_AXI_TPG_arvalid(intf_net_mb_ss_0_M05_AXI_ARVALID),
        .S_AXI_TPG_awaddr(intf_net_mb_ss_0_M05_AXI_AWADDR),
        .S_AXI_TPG_awready(intf_net_mb_ss_0_M05_AXI_AWREADY),
        .S_AXI_TPG_awvalid(intf_net_mb_ss_0_M05_AXI_AWVALID),
        .S_AXI_TPG_bready(intf_net_mb_ss_0_M05_AXI_BREADY),
        .S_AXI_TPG_bresp(intf_net_mb_ss_0_M05_AXI_BRESP),
        .S_AXI_TPG_bvalid(intf_net_mb_ss_0_M05_AXI_BVALID),
        .S_AXI_TPG_rdata(intf_net_mb_ss_0_M05_AXI_RDATA),
        .S_AXI_TPG_rready(intf_net_mb_ss_0_M05_AXI_RREADY),
        .S_AXI_TPG_rresp(intf_net_mb_ss_0_M05_AXI_RRESP),
        .S_AXI_TPG_rvalid(intf_net_mb_ss_0_M05_AXI_RVALID),
        .S_AXI_TPG_wdata(intf_net_mb_ss_0_M05_AXI_WDATA),
        .S_AXI_TPG_wready(intf_net_mb_ss_0_M05_AXI_WREADY),
        .S_AXI_TPG_wstrb(intf_net_mb_ss_0_M05_AXI_WSTRB),
        .S_AXI_TPG_wvalid(intf_net_mb_ss_0_M05_AXI_WVALID),
        .ap_clk(net_mb_ss_0_clk_out2),
        .m_axi_aresetn(net_mb_ss_0_dcm_locked),
        .m_axis_video_tdata(intf_net_v_tpg_ss_0_m_axis_video_TDATA),
        .m_axis_video_tdest(intf_net_v_tpg_ss_0_m_axis_video_TDEST),
        .m_axis_video_tid(intf_net_v_tpg_ss_0_m_axis_video_TID),
        .m_axis_video_tkeep(intf_net_v_tpg_ss_0_m_axis_video_TKEEP),
        .m_axis_video_tlast(intf_net_v_tpg_ss_0_m_axis_video_TLAST),
        .m_axis_video_tready(intf_net_v_tpg_ss_0_m_axis_video_TREADY),
        .m_axis_video_tstrb(intf_net_v_tpg_ss_0_m_axis_video_TSTRB),
        .m_axis_video_tuser(intf_net_v_tpg_ss_0_m_axis_video_TUSER),
        .m_axis_video_tvalid(intf_net_v_tpg_ss_0_m_axis_video_TVALID),
        .s_axis_video_tdata(intf_net_rx_video_axis_reg_slice_M_AXIS_TDATA),
        .s_axis_video_tlast(intf_net_rx_video_axis_reg_slice_M_AXIS_TLAST),
        .s_axis_video_tready(intf_net_rx_video_axis_reg_slice_M_AXIS_TREADY),
        .s_axis_video_tuser(intf_net_rx_video_axis_reg_slice_M_AXIS_TUSER),
        .s_axis_video_tvalid(intf_net_rx_video_axis_reg_slice_M_AXIS_TVALID));
  exdes_vcc_const_0 vcc_const
       (.dout(net_vcc_const_dout));
  exdes_vid_phy_controller_0 vid_phy_controller
       (.gtnorthrefclk0_in(net_gt_refclk_buf_IBUF_OUT),
        .irq(net_vid_phy_controller_irq),
        .mgtrefclk0_pad_n_in(net_bdry_in_HDMI_RX_CLK_N_IN),
        .mgtrefclk0_pad_p_in(net_bdry_in_HDMI_RX_CLK_P_IN),
        .mgtrefclk1_pad_n_in(net_bdry_in_TX_REFCLK_N_IN),
        .mgtrefclk1_pad_p_in(net_bdry_in_TX_REFCLK_P_IN),
        .phy_rxn_in(net_bdry_in_HDMI_RX_DAT_N_IN),
        .phy_rxp_in(net_bdry_in_HDMI_RX_DAT_P_IN),
        .phy_txn_out(net_vid_phy_controller_phy_txn_out),
        .phy_txp_out(net_vid_phy_controller_phy_txp_out),
        .rx_tmds_clk_n(net_vid_phy_controller_rx_tmds_clk_n),
        .rx_tmds_clk_p(net_vid_phy_controller_rx_tmds_clk_p),
        .rx_video_clk(net_vid_phy_controller_rx_video_clk),
        .rxoutclk(net_vid_phy_controller_rxoutclk),
        .tx_refclk_rdy(net_bdry_in_SI5324_LOL_IN),
        .tx_tmds_clk(net_vid_phy_controller_tx_tmds_clk),
        .tx_tmds_clk_n(net_vid_phy_controller_tx_tmds_clk_n),
        .tx_tmds_clk_p(net_vid_phy_controller_tx_tmds_clk_p),
        .tx_video_clk(net_vid_phy_controller_tx_video_clk),
        .txoutclk(net_vid_phy_controller_txoutclk),
        .vid_phy_axi4lite_aclk(net_mb_ss_0_s_axi_aclk),
        .vid_phy_axi4lite_araddr(intf_net_mb_ss_0_M00_AXI_ARADDR[9:0]),
        .vid_phy_axi4lite_aresetn(net_mb_ss_0_peripheral_aresetn),
        .vid_phy_axi4lite_arprot(intf_net_mb_ss_0_M00_AXI_ARPROT),
        .vid_phy_axi4lite_arready(intf_net_mb_ss_0_M00_AXI_ARREADY),
        .vid_phy_axi4lite_arvalid(intf_net_mb_ss_0_M00_AXI_ARVALID),
        .vid_phy_axi4lite_awaddr(intf_net_mb_ss_0_M00_AXI_AWADDR[9:0]),
        .vid_phy_axi4lite_awprot(intf_net_mb_ss_0_M00_AXI_AWPROT),
        .vid_phy_axi4lite_awready(intf_net_mb_ss_0_M00_AXI_AWREADY),
        .vid_phy_axi4lite_awvalid(intf_net_mb_ss_0_M00_AXI_AWVALID),
        .vid_phy_axi4lite_bready(intf_net_mb_ss_0_M00_AXI_BREADY),
        .vid_phy_axi4lite_bresp(intf_net_mb_ss_0_M00_AXI_BRESP),
        .vid_phy_axi4lite_bvalid(intf_net_mb_ss_0_M00_AXI_BVALID),
        .vid_phy_axi4lite_rdata(intf_net_mb_ss_0_M00_AXI_RDATA),
        .vid_phy_axi4lite_rready(intf_net_mb_ss_0_M00_AXI_RREADY),
        .vid_phy_axi4lite_rresp(intf_net_mb_ss_0_M00_AXI_RRESP),
        .vid_phy_axi4lite_rvalid(intf_net_mb_ss_0_M00_AXI_RVALID),
        .vid_phy_axi4lite_wdata(intf_net_mb_ss_0_M00_AXI_WDATA),
        .vid_phy_axi4lite_wready(intf_net_mb_ss_0_M00_AXI_WREADY),
        .vid_phy_axi4lite_wstrb(intf_net_mb_ss_0_M00_AXI_WSTRB),
        .vid_phy_axi4lite_wvalid(intf_net_mb_ss_0_M00_AXI_WVALID),
        .vid_phy_rx_axi4s_aclk(net_vid_phy_controller_rxoutclk),
        .vid_phy_rx_axi4s_aresetn(net_vcc_const_dout),
        .vid_phy_rx_axi4s_ch0_tdata(intf_net_vid_phy_controller_vid_phy_rx_axi4s_ch0_TDATA),
        .vid_phy_rx_axi4s_ch0_tready(1'b1),
        .vid_phy_rx_axi4s_ch0_tvalid(intf_net_vid_phy_controller_vid_phy_rx_axi4s_ch0_TVALID),
        .vid_phy_rx_axi4s_ch1_tdata(intf_net_vid_phy_controller_vid_phy_rx_axi4s_ch1_TDATA),
        .vid_phy_rx_axi4s_ch1_tready(1'b1),
        .vid_phy_rx_axi4s_ch1_tvalid(intf_net_vid_phy_controller_vid_phy_rx_axi4s_ch1_TVALID),
        .vid_phy_rx_axi4s_ch2_tdata(intf_net_vid_phy_controller_vid_phy_rx_axi4s_ch2_TDATA),
        .vid_phy_rx_axi4s_ch2_tready(1'b1),
        .vid_phy_rx_axi4s_ch2_tvalid(intf_net_vid_phy_controller_vid_phy_rx_axi4s_ch2_TVALID),
        .vid_phy_sb_aclk(net_mb_ss_0_s_axi_aclk),
        .vid_phy_sb_aresetn(net_mb_ss_0_peripheral_aresetn),
        .vid_phy_status_sb_rx_tdata(intf_net_vid_phy_controller_vid_phy_status_sb_rx_TDATA),
        .vid_phy_status_sb_rx_tready(1'b1),
        .vid_phy_status_sb_rx_tvalid(intf_net_vid_phy_controller_vid_phy_status_sb_rx_TVALID),
        .vid_phy_status_sb_tx_tdata(intf_net_vid_phy_controller_vid_phy_status_sb_tx_TDATA),
        .vid_phy_status_sb_tx_tready(1'b1),
        .vid_phy_status_sb_tx_tvalid(intf_net_vid_phy_controller_vid_phy_status_sb_tx_TVALID),
        .vid_phy_tx_axi4s_aclk(net_vid_phy_controller_txoutclk),
        .vid_phy_tx_axi4s_aresetn(net_vcc_const_dout),
        .vid_phy_tx_axi4s_ch0_tdata(intf_net_v_hdmi_tx_ss_LINK_DATA0_OUT_TDATA),
        .vid_phy_tx_axi4s_ch0_tuser(1'b0),
        .vid_phy_tx_axi4s_ch0_tvalid(intf_net_v_hdmi_tx_ss_LINK_DATA0_OUT_TVALID),
        .vid_phy_tx_axi4s_ch1_tdata(intf_net_v_hdmi_tx_ss_LINK_DATA1_OUT_TDATA),
        .vid_phy_tx_axi4s_ch1_tuser(1'b0),
        .vid_phy_tx_axi4s_ch1_tvalid(intf_net_v_hdmi_tx_ss_LINK_DATA1_OUT_TVALID),
        .vid_phy_tx_axi4s_ch2_tdata(intf_net_v_hdmi_tx_ss_LINK_DATA2_OUT_TDATA),
        .vid_phy_tx_axi4s_ch2_tuser(1'b0),
        .vid_phy_tx_axi4s_ch2_tvalid(intf_net_v_hdmi_tx_ss_LINK_DATA2_OUT_TVALID));
endmodule

module exdes_axi_interconnect_0
   (ACLK,
    ARESETN,
    M00_ACLK,
    M00_ARESETN,
    M00_AXI_araddr,
    M00_AXI_arprot,
    M00_AXI_arready,
    M00_AXI_arvalid,
    M00_AXI_awaddr,
    M00_AXI_awprot,
    M00_AXI_awready,
    M00_AXI_awvalid,
    M00_AXI_bready,
    M00_AXI_bresp,
    M00_AXI_bvalid,
    M00_AXI_rdata,
    M00_AXI_rready,
    M00_AXI_rresp,
    M00_AXI_rvalid,
    M00_AXI_wdata,
    M00_AXI_wready,
    M00_AXI_wstrb,
    M00_AXI_wvalid,
    M01_ACLK,
    M01_ARESETN,
    M01_AXI_araddr,
    M01_AXI_arready,
    M01_AXI_arvalid,
    M01_AXI_awaddr,
    M01_AXI_awready,
    M01_AXI_awvalid,
    M01_AXI_bready,
    M01_AXI_bresp,
    M01_AXI_bvalid,
    M01_AXI_rdata,
    M01_AXI_rready,
    M01_AXI_rresp,
    M01_AXI_rvalid,
    M01_AXI_wdata,
    M01_AXI_wready,
    M01_AXI_wstrb,
    M01_AXI_wvalid,
    M02_ACLK,
    M02_ARESETN,
    M02_AXI_araddr,
    M02_AXI_arready,
    M02_AXI_arvalid,
    M02_AXI_awaddr,
    M02_AXI_awready,
    M02_AXI_awvalid,
    M02_AXI_bready,
    M02_AXI_bresp,
    M02_AXI_bvalid,
    M02_AXI_rdata,
    M02_AXI_rready,
    M02_AXI_rresp,
    M02_AXI_rvalid,
    M02_AXI_wdata,
    M02_AXI_wready,
    M02_AXI_wstrb,
    M02_AXI_wvalid,
    S00_ACLK,
    S00_ARESETN,
    S00_AXI_araddr,
    S00_AXI_arprot,
    S00_AXI_arready,
    S00_AXI_arvalid,
    S00_AXI_awaddr,
    S00_AXI_awprot,
    S00_AXI_awready,
    S00_AXI_awvalid,
    S00_AXI_bready,
    S00_AXI_bresp,
    S00_AXI_bvalid,
    S00_AXI_rdata,
    S00_AXI_rready,
    S00_AXI_rresp,
    S00_AXI_rvalid,
    S00_AXI_wdata,
    S00_AXI_wready,
    S00_AXI_wstrb,
    S00_AXI_wvalid);
  input ACLK;
  input ARESETN;
  input M00_ACLK;
  input M00_ARESETN;
  output [31:0]M00_AXI_araddr;
  output [2:0]M00_AXI_arprot;
  input M00_AXI_arready;
  output M00_AXI_arvalid;
  output [31:0]M00_AXI_awaddr;
  output [2:0]M00_AXI_awprot;
  input M00_AXI_awready;
  output M00_AXI_awvalid;
  output M00_AXI_bready;
  input [1:0]M00_AXI_bresp;
  input M00_AXI_bvalid;
  input [31:0]M00_AXI_rdata;
  output M00_AXI_rready;
  input [1:0]M00_AXI_rresp;
  input M00_AXI_rvalid;
  output [31:0]M00_AXI_wdata;
  input M00_AXI_wready;
  output [3:0]M00_AXI_wstrb;
  output M00_AXI_wvalid;
  input M01_ACLK;
  input M01_ARESETN;
  output [31:0]M01_AXI_araddr;
  input M01_AXI_arready;
  output M01_AXI_arvalid;
  output [31:0]M01_AXI_awaddr;
  input M01_AXI_awready;
  output M01_AXI_awvalid;
  output M01_AXI_bready;
  input [1:0]M01_AXI_bresp;
  input M01_AXI_bvalid;
  input [31:0]M01_AXI_rdata;
  output M01_AXI_rready;
  input [1:0]M01_AXI_rresp;
  input M01_AXI_rvalid;
  output [31:0]M01_AXI_wdata;
  input M01_AXI_wready;
  output [3:0]M01_AXI_wstrb;
  output M01_AXI_wvalid;
  input M02_ACLK;
  input M02_ARESETN;
  output [31:0]M02_AXI_araddr;
  input M02_AXI_arready;
  output M02_AXI_arvalid;
  output [31:0]M02_AXI_awaddr;
  input M02_AXI_awready;
  output M02_AXI_awvalid;
  output M02_AXI_bready;
  input [1:0]M02_AXI_bresp;
  input M02_AXI_bvalid;
  input [31:0]M02_AXI_rdata;
  output M02_AXI_rready;
  input [1:0]M02_AXI_rresp;
  input M02_AXI_rvalid;
  output [31:0]M02_AXI_wdata;
  input M02_AXI_wready;
  output [3:0]M02_AXI_wstrb;
  output M02_AXI_wvalid;
  input S00_ACLK;
  input S00_ARESETN;
  input [31:0]S00_AXI_araddr;
  input [2:0]S00_AXI_arprot;
  output [0:0]S00_AXI_arready;
  input [0:0]S00_AXI_arvalid;
  input [31:0]S00_AXI_awaddr;
  input [2:0]S00_AXI_awprot;
  output [0:0]S00_AXI_awready;
  input [0:0]S00_AXI_awvalid;
  input [0:0]S00_AXI_bready;
  output [1:0]S00_AXI_bresp;
  output [0:0]S00_AXI_bvalid;
  output [31:0]S00_AXI_rdata;
  input [0:0]S00_AXI_rready;
  output [1:0]S00_AXI_rresp;
  output [0:0]S00_AXI_rvalid;
  input [31:0]S00_AXI_wdata;
  output [0:0]S00_AXI_wready;
  input [3:0]S00_AXI_wstrb;
  input [0:0]S00_AXI_wvalid;

  wire axi_interconnect_ACLK_net;
  wire axi_interconnect_ARESETN_net;
  wire [31:0]axi_interconnect_to_s00_couplers_ARADDR;
  wire [2:0]axi_interconnect_to_s00_couplers_ARPROT;
  wire [0:0]axi_interconnect_to_s00_couplers_ARREADY;
  wire [0:0]axi_interconnect_to_s00_couplers_ARVALID;
  wire [31:0]axi_interconnect_to_s00_couplers_AWADDR;
  wire [2:0]axi_interconnect_to_s00_couplers_AWPROT;
  wire [0:0]axi_interconnect_to_s00_couplers_AWREADY;
  wire [0:0]axi_interconnect_to_s00_couplers_AWVALID;
  wire [0:0]axi_interconnect_to_s00_couplers_BREADY;
  wire [1:0]axi_interconnect_to_s00_couplers_BRESP;
  wire [0:0]axi_interconnect_to_s00_couplers_BVALID;
  wire [31:0]axi_interconnect_to_s00_couplers_RDATA;
  wire [0:0]axi_interconnect_to_s00_couplers_RREADY;
  wire [1:0]axi_interconnect_to_s00_couplers_RRESP;
  wire [0:0]axi_interconnect_to_s00_couplers_RVALID;
  wire [31:0]axi_interconnect_to_s00_couplers_WDATA;
  wire [0:0]axi_interconnect_to_s00_couplers_WREADY;
  wire [3:0]axi_interconnect_to_s00_couplers_WSTRB;
  wire [0:0]axi_interconnect_to_s00_couplers_WVALID;
  wire [31:0]m00_couplers_to_axi_interconnect_ARADDR;
  wire [2:0]m00_couplers_to_axi_interconnect_ARPROT;
  wire m00_couplers_to_axi_interconnect_ARREADY;
  wire m00_couplers_to_axi_interconnect_ARVALID;
  wire [31:0]m00_couplers_to_axi_interconnect_AWADDR;
  wire [2:0]m00_couplers_to_axi_interconnect_AWPROT;
  wire m00_couplers_to_axi_interconnect_AWREADY;
  wire m00_couplers_to_axi_interconnect_AWVALID;
  wire m00_couplers_to_axi_interconnect_BREADY;
  wire [1:0]m00_couplers_to_axi_interconnect_BRESP;
  wire m00_couplers_to_axi_interconnect_BVALID;
  wire [31:0]m00_couplers_to_axi_interconnect_RDATA;
  wire m00_couplers_to_axi_interconnect_RREADY;
  wire [1:0]m00_couplers_to_axi_interconnect_RRESP;
  wire m00_couplers_to_axi_interconnect_RVALID;
  wire [31:0]m00_couplers_to_axi_interconnect_WDATA;
  wire m00_couplers_to_axi_interconnect_WREADY;
  wire [3:0]m00_couplers_to_axi_interconnect_WSTRB;
  wire m00_couplers_to_axi_interconnect_WVALID;
  wire [31:0]m01_couplers_to_axi_interconnect_ARADDR;
  wire m01_couplers_to_axi_interconnect_ARREADY;
  wire m01_couplers_to_axi_interconnect_ARVALID;
  wire [31:0]m01_couplers_to_axi_interconnect_AWADDR;
  wire m01_couplers_to_axi_interconnect_AWREADY;
  wire m01_couplers_to_axi_interconnect_AWVALID;
  wire m01_couplers_to_axi_interconnect_BREADY;
  wire [1:0]m01_couplers_to_axi_interconnect_BRESP;
  wire m01_couplers_to_axi_interconnect_BVALID;
  wire [31:0]m01_couplers_to_axi_interconnect_RDATA;
  wire m01_couplers_to_axi_interconnect_RREADY;
  wire [1:0]m01_couplers_to_axi_interconnect_RRESP;
  wire m01_couplers_to_axi_interconnect_RVALID;
  wire [31:0]m01_couplers_to_axi_interconnect_WDATA;
  wire m01_couplers_to_axi_interconnect_WREADY;
  wire [3:0]m01_couplers_to_axi_interconnect_WSTRB;
  wire m01_couplers_to_axi_interconnect_WVALID;
  wire [31:0]m02_couplers_to_axi_interconnect_ARADDR;
  wire m02_couplers_to_axi_interconnect_ARREADY;
  wire m02_couplers_to_axi_interconnect_ARVALID;
  wire [31:0]m02_couplers_to_axi_interconnect_AWADDR;
  wire m02_couplers_to_axi_interconnect_AWREADY;
  wire m02_couplers_to_axi_interconnect_AWVALID;
  wire m02_couplers_to_axi_interconnect_BREADY;
  wire [1:0]m02_couplers_to_axi_interconnect_BRESP;
  wire m02_couplers_to_axi_interconnect_BVALID;
  wire [31:0]m02_couplers_to_axi_interconnect_RDATA;
  wire m02_couplers_to_axi_interconnect_RREADY;
  wire [1:0]m02_couplers_to_axi_interconnect_RRESP;
  wire m02_couplers_to_axi_interconnect_RVALID;
  wire [31:0]m02_couplers_to_axi_interconnect_WDATA;
  wire m02_couplers_to_axi_interconnect_WREADY;
  wire [3:0]m02_couplers_to_axi_interconnect_WSTRB;
  wire m02_couplers_to_axi_interconnect_WVALID;
  wire [31:0]s00_couplers_to_xbar_ARADDR;
  wire [2:0]s00_couplers_to_xbar_ARPROT;
  wire [0:0]s00_couplers_to_xbar_ARREADY;
  wire [0:0]s00_couplers_to_xbar_ARVALID;
  wire [31:0]s00_couplers_to_xbar_AWADDR;
  wire [2:0]s00_couplers_to_xbar_AWPROT;
  wire [0:0]s00_couplers_to_xbar_AWREADY;
  wire [0:0]s00_couplers_to_xbar_AWVALID;
  wire [0:0]s00_couplers_to_xbar_BREADY;
  wire [1:0]s00_couplers_to_xbar_BRESP;
  wire [0:0]s00_couplers_to_xbar_BVALID;
  wire [31:0]s00_couplers_to_xbar_RDATA;
  wire [0:0]s00_couplers_to_xbar_RREADY;
  wire [1:0]s00_couplers_to_xbar_RRESP;
  wire [0:0]s00_couplers_to_xbar_RVALID;
  wire [31:0]s00_couplers_to_xbar_WDATA;
  wire [0:0]s00_couplers_to_xbar_WREADY;
  wire [3:0]s00_couplers_to_xbar_WSTRB;
  wire [0:0]s00_couplers_to_xbar_WVALID;
  wire [31:0]xbar_to_m00_couplers_ARADDR;
  wire [2:0]xbar_to_m00_couplers_ARPROT;
  wire xbar_to_m00_couplers_ARREADY;
  wire [0:0]xbar_to_m00_couplers_ARVALID;
  wire [31:0]xbar_to_m00_couplers_AWADDR;
  wire [2:0]xbar_to_m00_couplers_AWPROT;
  wire xbar_to_m00_couplers_AWREADY;
  wire [0:0]xbar_to_m00_couplers_AWVALID;
  wire [0:0]xbar_to_m00_couplers_BREADY;
  wire [1:0]xbar_to_m00_couplers_BRESP;
  wire xbar_to_m00_couplers_BVALID;
  wire [31:0]xbar_to_m00_couplers_RDATA;
  wire [0:0]xbar_to_m00_couplers_RREADY;
  wire [1:0]xbar_to_m00_couplers_RRESP;
  wire xbar_to_m00_couplers_RVALID;
  wire [31:0]xbar_to_m00_couplers_WDATA;
  wire xbar_to_m00_couplers_WREADY;
  wire [3:0]xbar_to_m00_couplers_WSTRB;
  wire [0:0]xbar_to_m00_couplers_WVALID;
  wire [63:32]xbar_to_m01_couplers_ARADDR;
  wire xbar_to_m01_couplers_ARREADY;
  wire [1:1]xbar_to_m01_couplers_ARVALID;
  wire [63:32]xbar_to_m01_couplers_AWADDR;
  wire xbar_to_m01_couplers_AWREADY;
  wire [1:1]xbar_to_m01_couplers_AWVALID;
  wire [1:1]xbar_to_m01_couplers_BREADY;
  wire [1:0]xbar_to_m01_couplers_BRESP;
  wire xbar_to_m01_couplers_BVALID;
  wire [31:0]xbar_to_m01_couplers_RDATA;
  wire [1:1]xbar_to_m01_couplers_RREADY;
  wire [1:0]xbar_to_m01_couplers_RRESP;
  wire xbar_to_m01_couplers_RVALID;
  wire [63:32]xbar_to_m01_couplers_WDATA;
  wire xbar_to_m01_couplers_WREADY;
  wire [7:4]xbar_to_m01_couplers_WSTRB;
  wire [1:1]xbar_to_m01_couplers_WVALID;
  wire [95:64]xbar_to_m02_couplers_ARADDR;
  wire xbar_to_m02_couplers_ARREADY;
  wire [2:2]xbar_to_m02_couplers_ARVALID;
  wire [95:64]xbar_to_m02_couplers_AWADDR;
  wire xbar_to_m02_couplers_AWREADY;
  wire [2:2]xbar_to_m02_couplers_AWVALID;
  wire [2:2]xbar_to_m02_couplers_BREADY;
  wire [1:0]xbar_to_m02_couplers_BRESP;
  wire xbar_to_m02_couplers_BVALID;
  wire [31:0]xbar_to_m02_couplers_RDATA;
  wire [2:2]xbar_to_m02_couplers_RREADY;
  wire [1:0]xbar_to_m02_couplers_RRESP;
  wire xbar_to_m02_couplers_RVALID;
  wire [95:64]xbar_to_m02_couplers_WDATA;
  wire xbar_to_m02_couplers_WREADY;
  wire [11:8]xbar_to_m02_couplers_WSTRB;
  wire [2:2]xbar_to_m02_couplers_WVALID;

  assign M00_AXI_araddr[31:0] = m00_couplers_to_axi_interconnect_ARADDR;
  assign M00_AXI_arprot[2:0] = m00_couplers_to_axi_interconnect_ARPROT;
  assign M00_AXI_arvalid = m00_couplers_to_axi_interconnect_ARVALID;
  assign M00_AXI_awaddr[31:0] = m00_couplers_to_axi_interconnect_AWADDR;
  assign M00_AXI_awprot[2:0] = m00_couplers_to_axi_interconnect_AWPROT;
  assign M00_AXI_awvalid = m00_couplers_to_axi_interconnect_AWVALID;
  assign M00_AXI_bready = m00_couplers_to_axi_interconnect_BREADY;
  assign M00_AXI_rready = m00_couplers_to_axi_interconnect_RREADY;
  assign M00_AXI_wdata[31:0] = m00_couplers_to_axi_interconnect_WDATA;
  assign M00_AXI_wstrb[3:0] = m00_couplers_to_axi_interconnect_WSTRB;
  assign M00_AXI_wvalid = m00_couplers_to_axi_interconnect_WVALID;
  assign M01_AXI_araddr[31:0] = m01_couplers_to_axi_interconnect_ARADDR;
  assign M01_AXI_arvalid = m01_couplers_to_axi_interconnect_ARVALID;
  assign M01_AXI_awaddr[31:0] = m01_couplers_to_axi_interconnect_AWADDR;
  assign M01_AXI_awvalid = m01_couplers_to_axi_interconnect_AWVALID;
  assign M01_AXI_bready = m01_couplers_to_axi_interconnect_BREADY;
  assign M01_AXI_rready = m01_couplers_to_axi_interconnect_RREADY;
  assign M01_AXI_wdata[31:0] = m01_couplers_to_axi_interconnect_WDATA;
  assign M01_AXI_wstrb[3:0] = m01_couplers_to_axi_interconnect_WSTRB;
  assign M01_AXI_wvalid = m01_couplers_to_axi_interconnect_WVALID;
  assign M02_AXI_araddr[31:0] = m02_couplers_to_axi_interconnect_ARADDR;
  assign M02_AXI_arvalid = m02_couplers_to_axi_interconnect_ARVALID;
  assign M02_AXI_awaddr[31:0] = m02_couplers_to_axi_interconnect_AWADDR;
  assign M02_AXI_awvalid = m02_couplers_to_axi_interconnect_AWVALID;
  assign M02_AXI_bready = m02_couplers_to_axi_interconnect_BREADY;
  assign M02_AXI_rready = m02_couplers_to_axi_interconnect_RREADY;
  assign M02_AXI_wdata[31:0] = m02_couplers_to_axi_interconnect_WDATA;
  assign M02_AXI_wstrb[3:0] = m02_couplers_to_axi_interconnect_WSTRB;
  assign M02_AXI_wvalid = m02_couplers_to_axi_interconnect_WVALID;
  assign S00_AXI_arready[0] = axi_interconnect_to_s00_couplers_ARREADY;
  assign S00_AXI_awready[0] = axi_interconnect_to_s00_couplers_AWREADY;
  assign S00_AXI_bresp[1:0] = axi_interconnect_to_s00_couplers_BRESP;
  assign S00_AXI_bvalid[0] = axi_interconnect_to_s00_couplers_BVALID;
  assign S00_AXI_rdata[31:0] = axi_interconnect_to_s00_couplers_RDATA;
  assign S00_AXI_rresp[1:0] = axi_interconnect_to_s00_couplers_RRESP;
  assign S00_AXI_rvalid[0] = axi_interconnect_to_s00_couplers_RVALID;
  assign S00_AXI_wready[0] = axi_interconnect_to_s00_couplers_WREADY;
  assign axi_interconnect_ACLK_net = ACLK;
  assign axi_interconnect_ARESETN_net = ARESETN;
  assign axi_interconnect_to_s00_couplers_ARADDR = S00_AXI_araddr[31:0];
  assign axi_interconnect_to_s00_couplers_ARPROT = S00_AXI_arprot[2:0];
  assign axi_interconnect_to_s00_couplers_ARVALID = S00_AXI_arvalid[0];
  assign axi_interconnect_to_s00_couplers_AWADDR = S00_AXI_awaddr[31:0];
  assign axi_interconnect_to_s00_couplers_AWPROT = S00_AXI_awprot[2:0];
  assign axi_interconnect_to_s00_couplers_AWVALID = S00_AXI_awvalid[0];
  assign axi_interconnect_to_s00_couplers_BREADY = S00_AXI_bready[0];
  assign axi_interconnect_to_s00_couplers_RREADY = S00_AXI_rready[0];
  assign axi_interconnect_to_s00_couplers_WDATA = S00_AXI_wdata[31:0];
  assign axi_interconnect_to_s00_couplers_WSTRB = S00_AXI_wstrb[3:0];
  assign axi_interconnect_to_s00_couplers_WVALID = S00_AXI_wvalid[0];
  assign m00_couplers_to_axi_interconnect_ARREADY = M00_AXI_arready;
  assign m00_couplers_to_axi_interconnect_AWREADY = M00_AXI_awready;
  assign m00_couplers_to_axi_interconnect_BRESP = M00_AXI_bresp[1:0];
  assign m00_couplers_to_axi_interconnect_BVALID = M00_AXI_bvalid;
  assign m00_couplers_to_axi_interconnect_RDATA = M00_AXI_rdata[31:0];
  assign m00_couplers_to_axi_interconnect_RRESP = M00_AXI_rresp[1:0];
  assign m00_couplers_to_axi_interconnect_RVALID = M00_AXI_rvalid;
  assign m00_couplers_to_axi_interconnect_WREADY = M00_AXI_wready;
  assign m01_couplers_to_axi_interconnect_ARREADY = M01_AXI_arready;
  assign m01_couplers_to_axi_interconnect_AWREADY = M01_AXI_awready;
  assign m01_couplers_to_axi_interconnect_BRESP = M01_AXI_bresp[1:0];
  assign m01_couplers_to_axi_interconnect_BVALID = M01_AXI_bvalid;
  assign m01_couplers_to_axi_interconnect_RDATA = M01_AXI_rdata[31:0];
  assign m01_couplers_to_axi_interconnect_RRESP = M01_AXI_rresp[1:0];
  assign m01_couplers_to_axi_interconnect_RVALID = M01_AXI_rvalid;
  assign m01_couplers_to_axi_interconnect_WREADY = M01_AXI_wready;
  assign m02_couplers_to_axi_interconnect_ARREADY = M02_AXI_arready;
  assign m02_couplers_to_axi_interconnect_AWREADY = M02_AXI_awready;
  assign m02_couplers_to_axi_interconnect_BRESP = M02_AXI_bresp[1:0];
  assign m02_couplers_to_axi_interconnect_BVALID = M02_AXI_bvalid;
  assign m02_couplers_to_axi_interconnect_RDATA = M02_AXI_rdata[31:0];
  assign m02_couplers_to_axi_interconnect_RRESP = M02_AXI_rresp[1:0];
  assign m02_couplers_to_axi_interconnect_RVALID = M02_AXI_rvalid;
  assign m02_couplers_to_axi_interconnect_WREADY = M02_AXI_wready;
  m00_couplers_imp_5QVHE m00_couplers
       (.M_ACLK(axi_interconnect_ACLK_net),
        .M_ARESETN(axi_interconnect_ARESETN_net),
        .M_AXI_araddr(m00_couplers_to_axi_interconnect_ARADDR),
        .M_AXI_arprot(m00_couplers_to_axi_interconnect_ARPROT),
        .M_AXI_arready(m00_couplers_to_axi_interconnect_ARREADY),
        .M_AXI_arvalid(m00_couplers_to_axi_interconnect_ARVALID),
        .M_AXI_awaddr(m00_couplers_to_axi_interconnect_AWADDR),
        .M_AXI_awprot(m00_couplers_to_axi_interconnect_AWPROT),
        .M_AXI_awready(m00_couplers_to_axi_interconnect_AWREADY),
        .M_AXI_awvalid(m00_couplers_to_axi_interconnect_AWVALID),
        .M_AXI_bready(m00_couplers_to_axi_interconnect_BREADY),
        .M_AXI_bresp(m00_couplers_to_axi_interconnect_BRESP),
        .M_AXI_bvalid(m00_couplers_to_axi_interconnect_BVALID),
        .M_AXI_rdata(m00_couplers_to_axi_interconnect_RDATA),
        .M_AXI_rready(m00_couplers_to_axi_interconnect_RREADY),
        .M_AXI_rresp(m00_couplers_to_axi_interconnect_RRESP),
        .M_AXI_rvalid(m00_couplers_to_axi_interconnect_RVALID),
        .M_AXI_wdata(m00_couplers_to_axi_interconnect_WDATA),
        .M_AXI_wready(m00_couplers_to_axi_interconnect_WREADY),
        .M_AXI_wstrb(m00_couplers_to_axi_interconnect_WSTRB),
        .M_AXI_wvalid(m00_couplers_to_axi_interconnect_WVALID),
        .S_ACLK(axi_interconnect_ACLK_net),
        .S_ARESETN(axi_interconnect_ARESETN_net),
        .S_AXI_araddr(xbar_to_m00_couplers_ARADDR),
        .S_AXI_arprot(xbar_to_m00_couplers_ARPROT),
        .S_AXI_arready(xbar_to_m00_couplers_ARREADY),
        .S_AXI_arvalid(xbar_to_m00_couplers_ARVALID),
        .S_AXI_awaddr(xbar_to_m00_couplers_AWADDR),
        .S_AXI_awprot(xbar_to_m00_couplers_AWPROT),
        .S_AXI_awready(xbar_to_m00_couplers_AWREADY),
        .S_AXI_awvalid(xbar_to_m00_couplers_AWVALID),
        .S_AXI_bready(xbar_to_m00_couplers_BREADY),
        .S_AXI_bresp(xbar_to_m00_couplers_BRESP),
        .S_AXI_bvalid(xbar_to_m00_couplers_BVALID),
        .S_AXI_rdata(xbar_to_m00_couplers_RDATA),
        .S_AXI_rready(xbar_to_m00_couplers_RREADY),
        .S_AXI_rresp(xbar_to_m00_couplers_RRESP),
        .S_AXI_rvalid(xbar_to_m00_couplers_RVALID),
        .S_AXI_wdata(xbar_to_m00_couplers_WDATA),
        .S_AXI_wready(xbar_to_m00_couplers_WREADY),
        .S_AXI_wstrb(xbar_to_m00_couplers_WSTRB),
        .S_AXI_wvalid(xbar_to_m00_couplers_WVALID));
  m01_couplers_imp_1FFZTVU m01_couplers
       (.M_ACLK(axi_interconnect_ACLK_net),
        .M_ARESETN(axi_interconnect_ARESETN_net),
        .M_AXI_araddr(m01_couplers_to_axi_interconnect_ARADDR),
        .M_AXI_arready(m01_couplers_to_axi_interconnect_ARREADY),
        .M_AXI_arvalid(m01_couplers_to_axi_interconnect_ARVALID),
        .M_AXI_awaddr(m01_couplers_to_axi_interconnect_AWADDR),
        .M_AXI_awready(m01_couplers_to_axi_interconnect_AWREADY),
        .M_AXI_awvalid(m01_couplers_to_axi_interconnect_AWVALID),
        .M_AXI_bready(m01_couplers_to_axi_interconnect_BREADY),
        .M_AXI_bresp(m01_couplers_to_axi_interconnect_BRESP),
        .M_AXI_bvalid(m01_couplers_to_axi_interconnect_BVALID),
        .M_AXI_rdata(m01_couplers_to_axi_interconnect_RDATA),
        .M_AXI_rready(m01_couplers_to_axi_interconnect_RREADY),
        .M_AXI_rresp(m01_couplers_to_axi_interconnect_RRESP),
        .M_AXI_rvalid(m01_couplers_to_axi_interconnect_RVALID),
        .M_AXI_wdata(m01_couplers_to_axi_interconnect_WDATA),
        .M_AXI_wready(m01_couplers_to_axi_interconnect_WREADY),
        .M_AXI_wstrb(m01_couplers_to_axi_interconnect_WSTRB),
        .M_AXI_wvalid(m01_couplers_to_axi_interconnect_WVALID),
        .S_ACLK(axi_interconnect_ACLK_net),
        .S_ARESETN(axi_interconnect_ARESETN_net),
        .S_AXI_araddr(xbar_to_m01_couplers_ARADDR),
        .S_AXI_arready(xbar_to_m01_couplers_ARREADY),
        .S_AXI_arvalid(xbar_to_m01_couplers_ARVALID),
        .S_AXI_awaddr(xbar_to_m01_couplers_AWADDR),
        .S_AXI_awready(xbar_to_m01_couplers_AWREADY),
        .S_AXI_awvalid(xbar_to_m01_couplers_AWVALID),
        .S_AXI_bready(xbar_to_m01_couplers_BREADY),
        .S_AXI_bresp(xbar_to_m01_couplers_BRESP),
        .S_AXI_bvalid(xbar_to_m01_couplers_BVALID),
        .S_AXI_rdata(xbar_to_m01_couplers_RDATA),
        .S_AXI_rready(xbar_to_m01_couplers_RREADY),
        .S_AXI_rresp(xbar_to_m01_couplers_RRESP),
        .S_AXI_rvalid(xbar_to_m01_couplers_RVALID),
        .S_AXI_wdata(xbar_to_m01_couplers_WDATA),
        .S_AXI_wready(xbar_to_m01_couplers_WREADY),
        .S_AXI_wstrb(xbar_to_m01_couplers_WSTRB),
        .S_AXI_wvalid(xbar_to_m01_couplers_WVALID));
  m02_couplers_imp_1AMYN3N m02_couplers
       (.M_ACLK(axi_interconnect_ACLK_net),
        .M_ARESETN(axi_interconnect_ARESETN_net),
        .M_AXI_araddr(m02_couplers_to_axi_interconnect_ARADDR),
        .M_AXI_arready(m02_couplers_to_axi_interconnect_ARREADY),
        .M_AXI_arvalid(m02_couplers_to_axi_interconnect_ARVALID),
        .M_AXI_awaddr(m02_couplers_to_axi_interconnect_AWADDR),
        .M_AXI_awready(m02_couplers_to_axi_interconnect_AWREADY),
        .M_AXI_awvalid(m02_couplers_to_axi_interconnect_AWVALID),
        .M_AXI_bready(m02_couplers_to_axi_interconnect_BREADY),
        .M_AXI_bresp(m02_couplers_to_axi_interconnect_BRESP),
        .M_AXI_bvalid(m02_couplers_to_axi_interconnect_BVALID),
        .M_AXI_rdata(m02_couplers_to_axi_interconnect_RDATA),
        .M_AXI_rready(m02_couplers_to_axi_interconnect_RREADY),
        .M_AXI_rresp(m02_couplers_to_axi_interconnect_RRESP),
        .M_AXI_rvalid(m02_couplers_to_axi_interconnect_RVALID),
        .M_AXI_wdata(m02_couplers_to_axi_interconnect_WDATA),
        .M_AXI_wready(m02_couplers_to_axi_interconnect_WREADY),
        .M_AXI_wstrb(m02_couplers_to_axi_interconnect_WSTRB),
        .M_AXI_wvalid(m02_couplers_to_axi_interconnect_WVALID),
        .S_ACLK(axi_interconnect_ACLK_net),
        .S_ARESETN(axi_interconnect_ARESETN_net),
        .S_AXI_araddr(xbar_to_m02_couplers_ARADDR),
        .S_AXI_arready(xbar_to_m02_couplers_ARREADY),
        .S_AXI_arvalid(xbar_to_m02_couplers_ARVALID),
        .S_AXI_awaddr(xbar_to_m02_couplers_AWADDR),
        .S_AXI_awready(xbar_to_m02_couplers_AWREADY),
        .S_AXI_awvalid(xbar_to_m02_couplers_AWVALID),
        .S_AXI_bready(xbar_to_m02_couplers_BREADY),
        .S_AXI_bresp(xbar_to_m02_couplers_BRESP),
        .S_AXI_bvalid(xbar_to_m02_couplers_BVALID),
        .S_AXI_rdata(xbar_to_m02_couplers_RDATA),
        .S_AXI_rready(xbar_to_m02_couplers_RREADY),
        .S_AXI_rresp(xbar_to_m02_couplers_RRESP),
        .S_AXI_rvalid(xbar_to_m02_couplers_RVALID),
        .S_AXI_wdata(xbar_to_m02_couplers_WDATA),
        .S_AXI_wready(xbar_to_m02_couplers_WREADY),
        .S_AXI_wstrb(xbar_to_m02_couplers_WSTRB),
        .S_AXI_wvalid(xbar_to_m02_couplers_WVALID));
  s00_couplers_imp_O40D8P s00_couplers
       (.M_ACLK(axi_interconnect_ACLK_net),
        .M_ARESETN(axi_interconnect_ARESETN_net),
        .M_AXI_araddr(s00_couplers_to_xbar_ARADDR),
        .M_AXI_arprot(s00_couplers_to_xbar_ARPROT),
        .M_AXI_arready(s00_couplers_to_xbar_ARREADY),
        .M_AXI_arvalid(s00_couplers_to_xbar_ARVALID),
        .M_AXI_awaddr(s00_couplers_to_xbar_AWADDR),
        .M_AXI_awprot(s00_couplers_to_xbar_AWPROT),
        .M_AXI_awready(s00_couplers_to_xbar_AWREADY),
        .M_AXI_awvalid(s00_couplers_to_xbar_AWVALID),
        .M_AXI_bready(s00_couplers_to_xbar_BREADY),
        .M_AXI_bresp(s00_couplers_to_xbar_BRESP),
        .M_AXI_bvalid(s00_couplers_to_xbar_BVALID),
        .M_AXI_rdata(s00_couplers_to_xbar_RDATA),
        .M_AXI_rready(s00_couplers_to_xbar_RREADY),
        .M_AXI_rresp(s00_couplers_to_xbar_RRESP),
        .M_AXI_rvalid(s00_couplers_to_xbar_RVALID),
        .M_AXI_wdata(s00_couplers_to_xbar_WDATA),
        .M_AXI_wready(s00_couplers_to_xbar_WREADY),
        .M_AXI_wstrb(s00_couplers_to_xbar_WSTRB),
        .M_AXI_wvalid(s00_couplers_to_xbar_WVALID),
        .S_ACLK(axi_interconnect_ACLK_net),
        .S_ARESETN(axi_interconnect_ARESETN_net),
        .S_AXI_araddr(axi_interconnect_to_s00_couplers_ARADDR),
        .S_AXI_arprot(axi_interconnect_to_s00_couplers_ARPROT),
        .S_AXI_arready(axi_interconnect_to_s00_couplers_ARREADY),
        .S_AXI_arvalid(axi_interconnect_to_s00_couplers_ARVALID),
        .S_AXI_awaddr(axi_interconnect_to_s00_couplers_AWADDR),
        .S_AXI_awprot(axi_interconnect_to_s00_couplers_AWPROT),
        .S_AXI_awready(axi_interconnect_to_s00_couplers_AWREADY),
        .S_AXI_awvalid(axi_interconnect_to_s00_couplers_AWVALID),
        .S_AXI_bready(axi_interconnect_to_s00_couplers_BREADY),
        .S_AXI_bresp(axi_interconnect_to_s00_couplers_BRESP),
        .S_AXI_bvalid(axi_interconnect_to_s00_couplers_BVALID),
        .S_AXI_rdata(axi_interconnect_to_s00_couplers_RDATA),
        .S_AXI_rready(axi_interconnect_to_s00_couplers_RREADY),
        .S_AXI_rresp(axi_interconnect_to_s00_couplers_RRESP),
        .S_AXI_rvalid(axi_interconnect_to_s00_couplers_RVALID),
        .S_AXI_wdata(axi_interconnect_to_s00_couplers_WDATA),
        .S_AXI_wready(axi_interconnect_to_s00_couplers_WREADY),
        .S_AXI_wstrb(axi_interconnect_to_s00_couplers_WSTRB),
        .S_AXI_wvalid(axi_interconnect_to_s00_couplers_WVALID));
  exdes_xbar_0 xbar
       (.aclk(axi_interconnect_ACLK_net),
        .aresetn(axi_interconnect_ARESETN_net),
        .m_axi_araddr({xbar_to_m02_couplers_ARADDR,xbar_to_m01_couplers_ARADDR,xbar_to_m00_couplers_ARADDR}),
        .m_axi_arprot(xbar_to_m00_couplers_ARPROT),
        .m_axi_arready({xbar_to_m02_couplers_ARREADY,xbar_to_m01_couplers_ARREADY,xbar_to_m00_couplers_ARREADY}),
        .m_axi_arvalid({xbar_to_m02_couplers_ARVALID,xbar_to_m01_couplers_ARVALID,xbar_to_m00_couplers_ARVALID}),
        .m_axi_awaddr({xbar_to_m02_couplers_AWADDR,xbar_to_m01_couplers_AWADDR,xbar_to_m00_couplers_AWADDR}),
        .m_axi_awprot(xbar_to_m00_couplers_AWPROT),
        .m_axi_awready({xbar_to_m02_couplers_AWREADY,xbar_to_m01_couplers_AWREADY,xbar_to_m00_couplers_AWREADY}),
        .m_axi_awvalid({xbar_to_m02_couplers_AWVALID,xbar_to_m01_couplers_AWVALID,xbar_to_m00_couplers_AWVALID}),
        .m_axi_bready({xbar_to_m02_couplers_BREADY,xbar_to_m01_couplers_BREADY,xbar_to_m00_couplers_BREADY}),
        .m_axi_bresp({xbar_to_m02_couplers_BRESP,xbar_to_m01_couplers_BRESP,xbar_to_m00_couplers_BRESP}),
        .m_axi_bvalid({xbar_to_m02_couplers_BVALID,xbar_to_m01_couplers_BVALID,xbar_to_m00_couplers_BVALID}),
        .m_axi_rdata({xbar_to_m02_couplers_RDATA,xbar_to_m01_couplers_RDATA,xbar_to_m00_couplers_RDATA}),
        .m_axi_rready({xbar_to_m02_couplers_RREADY,xbar_to_m01_couplers_RREADY,xbar_to_m00_couplers_RREADY}),
        .m_axi_rresp({xbar_to_m02_couplers_RRESP,xbar_to_m01_couplers_RRESP,xbar_to_m00_couplers_RRESP}),
        .m_axi_rvalid({xbar_to_m02_couplers_RVALID,xbar_to_m01_couplers_RVALID,xbar_to_m00_couplers_RVALID}),
        .m_axi_wdata({xbar_to_m02_couplers_WDATA,xbar_to_m01_couplers_WDATA,xbar_to_m00_couplers_WDATA}),
        .m_axi_wready({xbar_to_m02_couplers_WREADY,xbar_to_m01_couplers_WREADY,xbar_to_m00_couplers_WREADY}),
        .m_axi_wstrb({xbar_to_m02_couplers_WSTRB,xbar_to_m01_couplers_WSTRB,xbar_to_m00_couplers_WSTRB}),
        .m_axi_wvalid({xbar_to_m02_couplers_WVALID,xbar_to_m01_couplers_WVALID,xbar_to_m00_couplers_WVALID}),
        .s_axi_araddr(s00_couplers_to_xbar_ARADDR),
        .s_axi_arprot(s00_couplers_to_xbar_ARPROT),
        .s_axi_arready(s00_couplers_to_xbar_ARREADY),
        .s_axi_arvalid(s00_couplers_to_xbar_ARVALID),
        .s_axi_awaddr(s00_couplers_to_xbar_AWADDR),
        .s_axi_awprot(s00_couplers_to_xbar_AWPROT),
        .s_axi_awready(s00_couplers_to_xbar_AWREADY),
        .s_axi_awvalid(s00_couplers_to_xbar_AWVALID),
        .s_axi_bready(s00_couplers_to_xbar_BREADY),
        .s_axi_bresp(s00_couplers_to_xbar_BRESP),
        .s_axi_bvalid(s00_couplers_to_xbar_BVALID),
        .s_axi_rdata(s00_couplers_to_xbar_RDATA),
        .s_axi_rready(s00_couplers_to_xbar_RREADY),
        .s_axi_rresp(s00_couplers_to_xbar_RRESP),
        .s_axi_rvalid(s00_couplers_to_xbar_RVALID),
        .s_axi_wdata(s00_couplers_to_xbar_WDATA),
        .s_axi_wready(s00_couplers_to_xbar_WREADY),
        .s_axi_wstrb(s00_couplers_to_xbar_WSTRB),
        .s_axi_wvalid(s00_couplers_to_xbar_WVALID));
endmodule

module exdes_axi_interconnect_1
   (ACLK,
    ARESETN,
    M00_ACLK,
    M00_ARESETN,
    M00_AXI_araddr,
    M00_AXI_arprot,
    M00_AXI_arready,
    M00_AXI_arvalid,
    M00_AXI_awaddr,
    M00_AXI_awprot,
    M00_AXI_awready,
    M00_AXI_awvalid,
    M00_AXI_bready,
    M00_AXI_bresp,
    M00_AXI_bvalid,
    M00_AXI_rdata,
    M00_AXI_rready,
    M00_AXI_rresp,
    M00_AXI_rvalid,
    M00_AXI_wdata,
    M00_AXI_wready,
    M00_AXI_wstrb,
    M00_AXI_wvalid,
    M01_ACLK,
    M01_ARESETN,
    M01_AXI_araddr,
    M01_AXI_arprot,
    M01_AXI_arready,
    M01_AXI_arvalid,
    M01_AXI_awaddr,
    M01_AXI_awprot,
    M01_AXI_awready,
    M01_AXI_awvalid,
    M01_AXI_bready,
    M01_AXI_bresp,
    M01_AXI_bvalid,
    M01_AXI_rdata,
    M01_AXI_rready,
    M01_AXI_rresp,
    M01_AXI_rvalid,
    M01_AXI_wdata,
    M01_AXI_wready,
    M01_AXI_wstrb,
    M01_AXI_wvalid,
    M02_ACLK,
    M02_ARESETN,
    M02_AXI_araddr,
    M02_AXI_arprot,
    M02_AXI_arready,
    M02_AXI_arvalid,
    M02_AXI_awaddr,
    M02_AXI_awprot,
    M02_AXI_awready,
    M02_AXI_awvalid,
    M02_AXI_bready,
    M02_AXI_bresp,
    M02_AXI_bvalid,
    M02_AXI_rdata,
    M02_AXI_rready,
    M02_AXI_rresp,
    M02_AXI_rvalid,
    M02_AXI_wdata,
    M02_AXI_wready,
    M02_AXI_wstrb,
    M02_AXI_wvalid,
    M03_ACLK,
    M03_ARESETN,
    M03_AXI_araddr,
    M03_AXI_arready,
    M03_AXI_arvalid,
    M03_AXI_awaddr,
    M03_AXI_awready,
    M03_AXI_awvalid,
    M03_AXI_bready,
    M03_AXI_bresp,
    M03_AXI_bvalid,
    M03_AXI_rdata,
    M03_AXI_rready,
    M03_AXI_rresp,
    M03_AXI_rvalid,
    M03_AXI_wdata,
    M03_AXI_wready,
    M03_AXI_wstrb,
    M03_AXI_wvalid,
    M04_ACLK,
    M04_ARESETN,
    M04_AXI_araddr,
    M04_AXI_arready,
    M04_AXI_arvalid,
    M04_AXI_awaddr,
    M04_AXI_awready,
    M04_AXI_awvalid,
    M04_AXI_bready,
    M04_AXI_bresp,
    M04_AXI_bvalid,
    M04_AXI_rdata,
    M04_AXI_rready,
    M04_AXI_rresp,
    M04_AXI_rvalid,
    M04_AXI_wdata,
    M04_AXI_wready,
    M04_AXI_wstrb,
    M04_AXI_wvalid,
    M05_ACLK,
    M05_ARESETN,
    M05_AXI_araddr,
    M05_AXI_arready,
    M05_AXI_arvalid,
    M05_AXI_awaddr,
    M05_AXI_awready,
    M05_AXI_awvalid,
    M05_AXI_bready,
    M05_AXI_bresp,
    M05_AXI_bvalid,
    M05_AXI_rdata,
    M05_AXI_rready,
    M05_AXI_rresp,
    M05_AXI_rvalid,
    M05_AXI_wdata,
    M05_AXI_wready,
    M05_AXI_wstrb,
    M05_AXI_wvalid,
    M06_ACLK,
    M06_ARESETN,
    M06_AXI_araddr,
    M06_AXI_arprot,
    M06_AXI_arready,
    M06_AXI_arvalid,
    M06_AXI_awaddr,
    M06_AXI_awprot,
    M06_AXI_awready,
    M06_AXI_awvalid,
    M06_AXI_bready,
    M06_AXI_bresp,
    M06_AXI_bvalid,
    M06_AXI_rdata,
    M06_AXI_rready,
    M06_AXI_rresp,
    M06_AXI_rvalid,
    M06_AXI_wdata,
    M06_AXI_wready,
    M06_AXI_wstrb,
    M06_AXI_wvalid,
    M07_ACLK,
    M07_ARESETN,
    M07_AXI_araddr,
    M07_AXI_arready,
    M07_AXI_arvalid,
    M07_AXI_awaddr,
    M07_AXI_awready,
    M07_AXI_awvalid,
    M07_AXI_bready,
    M07_AXI_bresp,
    M07_AXI_bvalid,
    M07_AXI_rdata,
    M07_AXI_rready,
    M07_AXI_rresp,
    M07_AXI_rvalid,
    M07_AXI_wdata,
    M07_AXI_wready,
    M07_AXI_wstrb,
    M07_AXI_wvalid,
    M08_ACLK,
    M08_ARESETN,
    M08_AXI_araddr,
    M08_AXI_arready,
    M08_AXI_arvalid,
    M08_AXI_awaddr,
    M08_AXI_awready,
    M08_AXI_awvalid,
    M08_AXI_bready,
    M08_AXI_bresp,
    M08_AXI_bvalid,
    M08_AXI_rdata,
    M08_AXI_rready,
    M08_AXI_rresp,
    M08_AXI_rvalid,
    M08_AXI_wdata,
    M08_AXI_wready,
    M08_AXI_wstrb,
    M08_AXI_wvalid,
    S00_ACLK,
    S00_ARESETN,
    S00_AXI_araddr,
    S00_AXI_arprot,
    S00_AXI_arready,
    S00_AXI_arvalid,
    S00_AXI_awaddr,
    S00_AXI_awprot,
    S00_AXI_awready,
    S00_AXI_awvalid,
    S00_AXI_bready,
    S00_AXI_bresp,
    S00_AXI_bvalid,
    S00_AXI_rdata,
    S00_AXI_rready,
    S00_AXI_rresp,
    S00_AXI_rvalid,
    S00_AXI_wdata,
    S00_AXI_wready,
    S00_AXI_wstrb,
    S00_AXI_wvalid);
  input ACLK;
  input ARESETN;
  input M00_ACLK;
  input M00_ARESETN;
  output [31:0]M00_AXI_araddr;
  output [2:0]M00_AXI_arprot;
  input [0:0]M00_AXI_arready;
  output [0:0]M00_AXI_arvalid;
  output [31:0]M00_AXI_awaddr;
  output [2:0]M00_AXI_awprot;
  input [0:0]M00_AXI_awready;
  output [0:0]M00_AXI_awvalid;
  output [0:0]M00_AXI_bready;
  input [1:0]M00_AXI_bresp;
  input [0:0]M00_AXI_bvalid;
  input [31:0]M00_AXI_rdata;
  output [0:0]M00_AXI_rready;
  input [1:0]M00_AXI_rresp;
  input [0:0]M00_AXI_rvalid;
  output [31:0]M00_AXI_wdata;
  input [0:0]M00_AXI_wready;
  output [3:0]M00_AXI_wstrb;
  output [0:0]M00_AXI_wvalid;
  input M01_ACLK;
  input M01_ARESETN;
  output [31:0]M01_AXI_araddr;
  output [2:0]M01_AXI_arprot;
  input [0:0]M01_AXI_arready;
  output [0:0]M01_AXI_arvalid;
  output [31:0]M01_AXI_awaddr;
  output [2:0]M01_AXI_awprot;
  input [0:0]M01_AXI_awready;
  output [0:0]M01_AXI_awvalid;
  output [0:0]M01_AXI_bready;
  input [1:0]M01_AXI_bresp;
  input [0:0]M01_AXI_bvalid;
  input [31:0]M01_AXI_rdata;
  output [0:0]M01_AXI_rready;
  input [1:0]M01_AXI_rresp;
  input [0:0]M01_AXI_rvalid;
  output [31:0]M01_AXI_wdata;
  input [0:0]M01_AXI_wready;
  output [3:0]M01_AXI_wstrb;
  output [0:0]M01_AXI_wvalid;
  input M02_ACLK;
  input M02_ARESETN;
  output [31:0]M02_AXI_araddr;
  output [2:0]M02_AXI_arprot;
  input [0:0]M02_AXI_arready;
  output [0:0]M02_AXI_arvalid;
  output [31:0]M02_AXI_awaddr;
  output [2:0]M02_AXI_awprot;
  input [0:0]M02_AXI_awready;
  output [0:0]M02_AXI_awvalid;
  output [0:0]M02_AXI_bready;
  input [1:0]M02_AXI_bresp;
  input [0:0]M02_AXI_bvalid;
  input [31:0]M02_AXI_rdata;
  output [0:0]M02_AXI_rready;
  input [1:0]M02_AXI_rresp;
  input [0:0]M02_AXI_rvalid;
  output [31:0]M02_AXI_wdata;
  input [0:0]M02_AXI_wready;
  output [3:0]M02_AXI_wstrb;
  output [0:0]M02_AXI_wvalid;
  input M03_ACLK;
  input M03_ARESETN;
  output [31:0]M03_AXI_araddr;
  input M03_AXI_arready;
  output M03_AXI_arvalid;
  output [31:0]M03_AXI_awaddr;
  input M03_AXI_awready;
  output M03_AXI_awvalid;
  output M03_AXI_bready;
  input [1:0]M03_AXI_bresp;
  input M03_AXI_bvalid;
  input [31:0]M03_AXI_rdata;
  output M03_AXI_rready;
  input [1:0]M03_AXI_rresp;
  input M03_AXI_rvalid;
  output [31:0]M03_AXI_wdata;
  input M03_AXI_wready;
  output [3:0]M03_AXI_wstrb;
  output M03_AXI_wvalid;
  input M04_ACLK;
  input M04_ARESETN;
  output [31:0]M04_AXI_araddr;
  input M04_AXI_arready;
  output M04_AXI_arvalid;
  output [31:0]M04_AXI_awaddr;
  input M04_AXI_awready;
  output M04_AXI_awvalid;
  output M04_AXI_bready;
  input [1:0]M04_AXI_bresp;
  input M04_AXI_bvalid;
  input [31:0]M04_AXI_rdata;
  output M04_AXI_rready;
  input [1:0]M04_AXI_rresp;
  input M04_AXI_rvalid;
  output [31:0]M04_AXI_wdata;
  input M04_AXI_wready;
  output [3:0]M04_AXI_wstrb;
  output M04_AXI_wvalid;
  input M05_ACLK;
  input M05_ARESETN;
  output [7:0]M05_AXI_araddr;
  input M05_AXI_arready;
  output M05_AXI_arvalid;
  output [7:0]M05_AXI_awaddr;
  input M05_AXI_awready;
  output M05_AXI_awvalid;
  output M05_AXI_bready;
  input [1:0]M05_AXI_bresp;
  input M05_AXI_bvalid;
  input [31:0]M05_AXI_rdata;
  output M05_AXI_rready;
  input [1:0]M05_AXI_rresp;
  input M05_AXI_rvalid;
  output [31:0]M05_AXI_wdata;
  input M05_AXI_wready;
  output [3:0]M05_AXI_wstrb;
  output M05_AXI_wvalid;
  input M06_ACLK;
  input M06_ARESETN;
  output [31:0]M06_AXI_araddr;
  output [2:0]M06_AXI_arprot;
  input [0:0]M06_AXI_arready;
  output [0:0]M06_AXI_arvalid;
  output [31:0]M06_AXI_awaddr;
  output [2:0]M06_AXI_awprot;
  input [0:0]M06_AXI_awready;
  output [0:0]M06_AXI_awvalid;
  output [0:0]M06_AXI_bready;
  input [1:0]M06_AXI_bresp;
  input [0:0]M06_AXI_bvalid;
  input [31:0]M06_AXI_rdata;
  output [0:0]M06_AXI_rready;
  input [1:0]M06_AXI_rresp;
  input [0:0]M06_AXI_rvalid;
  output [31:0]M06_AXI_wdata;
  input [0:0]M06_AXI_wready;
  output [3:0]M06_AXI_wstrb;
  output [0:0]M06_AXI_wvalid;
  input M07_ACLK;
  input M07_ARESETN;
  output [31:0]M07_AXI_araddr;
  input M07_AXI_arready;
  output M07_AXI_arvalid;
  output [31:0]M07_AXI_awaddr;
  input M07_AXI_awready;
  output M07_AXI_awvalid;
  output M07_AXI_bready;
  input [1:0]M07_AXI_bresp;
  input M07_AXI_bvalid;
  input [31:0]M07_AXI_rdata;
  output M07_AXI_rready;
  input [1:0]M07_AXI_rresp;
  input M07_AXI_rvalid;
  output [31:0]M07_AXI_wdata;
  input M07_AXI_wready;
  output [3:0]M07_AXI_wstrb;
  output M07_AXI_wvalid;
  input M08_ACLK;
  input M08_ARESETN;
  output [8:0]M08_AXI_araddr;
  input M08_AXI_arready;
  output M08_AXI_arvalid;
  output [8:0]M08_AXI_awaddr;
  input M08_AXI_awready;
  output M08_AXI_awvalid;
  output M08_AXI_bready;
  input [1:0]M08_AXI_bresp;
  input M08_AXI_bvalid;
  input [31:0]M08_AXI_rdata;
  output M08_AXI_rready;
  input [1:0]M08_AXI_rresp;
  input M08_AXI_rvalid;
  output [31:0]M08_AXI_wdata;
  input M08_AXI_wready;
  output [3:0]M08_AXI_wstrb;
  output M08_AXI_wvalid;
  input S00_ACLK;
  input S00_ARESETN;
  input [31:0]S00_AXI_araddr;
  input [2:0]S00_AXI_arprot;
  output S00_AXI_arready;
  input S00_AXI_arvalid;
  input [31:0]S00_AXI_awaddr;
  input [2:0]S00_AXI_awprot;
  output S00_AXI_awready;
  input S00_AXI_awvalid;
  input S00_AXI_bready;
  output [1:0]S00_AXI_bresp;
  output S00_AXI_bvalid;
  output [31:0]S00_AXI_rdata;
  input S00_AXI_rready;
  output [1:0]S00_AXI_rresp;
  output S00_AXI_rvalid;
  input [31:0]S00_AXI_wdata;
  output S00_AXI_wready;
  input [3:0]S00_AXI_wstrb;
  input S00_AXI_wvalid;

  wire M00_ACLK_1;
  wire M00_ARESETN_1;
  wire M01_ACLK_1;
  wire M01_ARESETN_1;
  wire M02_ACLK_1;
  wire M02_ARESETN_1;
  wire M03_ACLK_1;
  wire M03_ARESETN_1;
  wire M04_ACLK_1;
  wire M04_ARESETN_1;
  wire M05_ACLK_1;
  wire M05_ARESETN_1;
  wire M06_ACLK_1;
  wire M06_ARESETN_1;
  wire M07_ACLK_1;
  wire M07_ARESETN_1;
  wire M08_ACLK_1;
  wire M08_ARESETN_1;
  wire S00_ACLK_1;
  wire S00_ARESETN_1;
  wire axi_interconnect_ACLK_net;
  wire axi_interconnect_ARESETN_net;
  wire [31:0]axi_interconnect_to_s00_couplers_ARADDR;
  wire [2:0]axi_interconnect_to_s00_couplers_ARPROT;
  wire axi_interconnect_to_s00_couplers_ARREADY;
  wire axi_interconnect_to_s00_couplers_ARVALID;
  wire [31:0]axi_interconnect_to_s00_couplers_AWADDR;
  wire [2:0]axi_interconnect_to_s00_couplers_AWPROT;
  wire axi_interconnect_to_s00_couplers_AWREADY;
  wire axi_interconnect_to_s00_couplers_AWVALID;
  wire axi_interconnect_to_s00_couplers_BREADY;
  wire [1:0]axi_interconnect_to_s00_couplers_BRESP;
  wire axi_interconnect_to_s00_couplers_BVALID;
  wire [31:0]axi_interconnect_to_s00_couplers_RDATA;
  wire axi_interconnect_to_s00_couplers_RREADY;
  wire [1:0]axi_interconnect_to_s00_couplers_RRESP;
  wire axi_interconnect_to_s00_couplers_RVALID;
  wire [31:0]axi_interconnect_to_s00_couplers_WDATA;
  wire axi_interconnect_to_s00_couplers_WREADY;
  wire [3:0]axi_interconnect_to_s00_couplers_WSTRB;
  wire axi_interconnect_to_s00_couplers_WVALID;
  wire [31:0]m00_couplers_to_axi_interconnect_ARADDR;
  wire [2:0]m00_couplers_to_axi_interconnect_ARPROT;
  wire [0:0]m00_couplers_to_axi_interconnect_ARREADY;
  wire [0:0]m00_couplers_to_axi_interconnect_ARVALID;
  wire [31:0]m00_couplers_to_axi_interconnect_AWADDR;
  wire [2:0]m00_couplers_to_axi_interconnect_AWPROT;
  wire [0:0]m00_couplers_to_axi_interconnect_AWREADY;
  wire [0:0]m00_couplers_to_axi_interconnect_AWVALID;
  wire [0:0]m00_couplers_to_axi_interconnect_BREADY;
  wire [1:0]m00_couplers_to_axi_interconnect_BRESP;
  wire [0:0]m00_couplers_to_axi_interconnect_BVALID;
  wire [31:0]m00_couplers_to_axi_interconnect_RDATA;
  wire [0:0]m00_couplers_to_axi_interconnect_RREADY;
  wire [1:0]m00_couplers_to_axi_interconnect_RRESP;
  wire [0:0]m00_couplers_to_axi_interconnect_RVALID;
  wire [31:0]m00_couplers_to_axi_interconnect_WDATA;
  wire [0:0]m00_couplers_to_axi_interconnect_WREADY;
  wire [3:0]m00_couplers_to_axi_interconnect_WSTRB;
  wire [0:0]m00_couplers_to_axi_interconnect_WVALID;
  wire [31:0]m01_couplers_to_axi_interconnect_ARADDR;
  wire [2:0]m01_couplers_to_axi_interconnect_ARPROT;
  wire [0:0]m01_couplers_to_axi_interconnect_ARREADY;
  wire [0:0]m01_couplers_to_axi_interconnect_ARVALID;
  wire [31:0]m01_couplers_to_axi_interconnect_AWADDR;
  wire [2:0]m01_couplers_to_axi_interconnect_AWPROT;
  wire [0:0]m01_couplers_to_axi_interconnect_AWREADY;
  wire [0:0]m01_couplers_to_axi_interconnect_AWVALID;
  wire [0:0]m01_couplers_to_axi_interconnect_BREADY;
  wire [1:0]m01_couplers_to_axi_interconnect_BRESP;
  wire [0:0]m01_couplers_to_axi_interconnect_BVALID;
  wire [31:0]m01_couplers_to_axi_interconnect_RDATA;
  wire [0:0]m01_couplers_to_axi_interconnect_RREADY;
  wire [1:0]m01_couplers_to_axi_interconnect_RRESP;
  wire [0:0]m01_couplers_to_axi_interconnect_RVALID;
  wire [31:0]m01_couplers_to_axi_interconnect_WDATA;
  wire [0:0]m01_couplers_to_axi_interconnect_WREADY;
  wire [3:0]m01_couplers_to_axi_interconnect_WSTRB;
  wire [0:0]m01_couplers_to_axi_interconnect_WVALID;
  wire [31:0]m02_couplers_to_axi_interconnect_ARADDR;
  wire [2:0]m02_couplers_to_axi_interconnect_ARPROT;
  wire [0:0]m02_couplers_to_axi_interconnect_ARREADY;
  wire [0:0]m02_couplers_to_axi_interconnect_ARVALID;
  wire [31:0]m02_couplers_to_axi_interconnect_AWADDR;
  wire [2:0]m02_couplers_to_axi_interconnect_AWPROT;
  wire [0:0]m02_couplers_to_axi_interconnect_AWREADY;
  wire [0:0]m02_couplers_to_axi_interconnect_AWVALID;
  wire [0:0]m02_couplers_to_axi_interconnect_BREADY;
  wire [1:0]m02_couplers_to_axi_interconnect_BRESP;
  wire [0:0]m02_couplers_to_axi_interconnect_BVALID;
  wire [31:0]m02_couplers_to_axi_interconnect_RDATA;
  wire [0:0]m02_couplers_to_axi_interconnect_RREADY;
  wire [1:0]m02_couplers_to_axi_interconnect_RRESP;
  wire [0:0]m02_couplers_to_axi_interconnect_RVALID;
  wire [31:0]m02_couplers_to_axi_interconnect_WDATA;
  wire [0:0]m02_couplers_to_axi_interconnect_WREADY;
  wire [3:0]m02_couplers_to_axi_interconnect_WSTRB;
  wire [0:0]m02_couplers_to_axi_interconnect_WVALID;
  wire [31:0]m03_couplers_to_axi_interconnect_ARADDR;
  wire m03_couplers_to_axi_interconnect_ARREADY;
  wire m03_couplers_to_axi_interconnect_ARVALID;
  wire [31:0]m03_couplers_to_axi_interconnect_AWADDR;
  wire m03_couplers_to_axi_interconnect_AWREADY;
  wire m03_couplers_to_axi_interconnect_AWVALID;
  wire m03_couplers_to_axi_interconnect_BREADY;
  wire [1:0]m03_couplers_to_axi_interconnect_BRESP;
  wire m03_couplers_to_axi_interconnect_BVALID;
  wire [31:0]m03_couplers_to_axi_interconnect_RDATA;
  wire m03_couplers_to_axi_interconnect_RREADY;
  wire [1:0]m03_couplers_to_axi_interconnect_RRESP;
  wire m03_couplers_to_axi_interconnect_RVALID;
  wire [31:0]m03_couplers_to_axi_interconnect_WDATA;
  wire m03_couplers_to_axi_interconnect_WREADY;
  wire [3:0]m03_couplers_to_axi_interconnect_WSTRB;
  wire m03_couplers_to_axi_interconnect_WVALID;
  wire [31:0]m04_couplers_to_axi_interconnect_ARADDR;
  wire m04_couplers_to_axi_interconnect_ARREADY;
  wire m04_couplers_to_axi_interconnect_ARVALID;
  wire [31:0]m04_couplers_to_axi_interconnect_AWADDR;
  wire m04_couplers_to_axi_interconnect_AWREADY;
  wire m04_couplers_to_axi_interconnect_AWVALID;
  wire m04_couplers_to_axi_interconnect_BREADY;
  wire [1:0]m04_couplers_to_axi_interconnect_BRESP;
  wire m04_couplers_to_axi_interconnect_BVALID;
  wire [31:0]m04_couplers_to_axi_interconnect_RDATA;
  wire m04_couplers_to_axi_interconnect_RREADY;
  wire [1:0]m04_couplers_to_axi_interconnect_RRESP;
  wire m04_couplers_to_axi_interconnect_RVALID;
  wire [31:0]m04_couplers_to_axi_interconnect_WDATA;
  wire m04_couplers_to_axi_interconnect_WREADY;
  wire [3:0]m04_couplers_to_axi_interconnect_WSTRB;
  wire m04_couplers_to_axi_interconnect_WVALID;
  wire [7:0]m05_couplers_to_axi_interconnect_ARADDR;
  wire m05_couplers_to_axi_interconnect_ARREADY;
  wire m05_couplers_to_axi_interconnect_ARVALID;
  wire [7:0]m05_couplers_to_axi_interconnect_AWADDR;
  wire m05_couplers_to_axi_interconnect_AWREADY;
  wire m05_couplers_to_axi_interconnect_AWVALID;
  wire m05_couplers_to_axi_interconnect_BREADY;
  wire [1:0]m05_couplers_to_axi_interconnect_BRESP;
  wire m05_couplers_to_axi_interconnect_BVALID;
  wire [31:0]m05_couplers_to_axi_interconnect_RDATA;
  wire m05_couplers_to_axi_interconnect_RREADY;
  wire [1:0]m05_couplers_to_axi_interconnect_RRESP;
  wire m05_couplers_to_axi_interconnect_RVALID;
  wire [31:0]m05_couplers_to_axi_interconnect_WDATA;
  wire m05_couplers_to_axi_interconnect_WREADY;
  wire [3:0]m05_couplers_to_axi_interconnect_WSTRB;
  wire m05_couplers_to_axi_interconnect_WVALID;
  wire [31:0]m06_couplers_to_axi_interconnect_ARADDR;
  wire [2:0]m06_couplers_to_axi_interconnect_ARPROT;
  wire [0:0]m06_couplers_to_axi_interconnect_ARREADY;
  wire [0:0]m06_couplers_to_axi_interconnect_ARVALID;
  wire [31:0]m06_couplers_to_axi_interconnect_AWADDR;
  wire [2:0]m06_couplers_to_axi_interconnect_AWPROT;
  wire [0:0]m06_couplers_to_axi_interconnect_AWREADY;
  wire [0:0]m06_couplers_to_axi_interconnect_AWVALID;
  wire [0:0]m06_couplers_to_axi_interconnect_BREADY;
  wire [1:0]m06_couplers_to_axi_interconnect_BRESP;
  wire [0:0]m06_couplers_to_axi_interconnect_BVALID;
  wire [31:0]m06_couplers_to_axi_interconnect_RDATA;
  wire [0:0]m06_couplers_to_axi_interconnect_RREADY;
  wire [1:0]m06_couplers_to_axi_interconnect_RRESP;
  wire [0:0]m06_couplers_to_axi_interconnect_RVALID;
  wire [31:0]m06_couplers_to_axi_interconnect_WDATA;
  wire [0:0]m06_couplers_to_axi_interconnect_WREADY;
  wire [3:0]m06_couplers_to_axi_interconnect_WSTRB;
  wire [0:0]m06_couplers_to_axi_interconnect_WVALID;
  wire [31:0]m07_couplers_to_axi_interconnect_ARADDR;
  wire m07_couplers_to_axi_interconnect_ARREADY;
  wire m07_couplers_to_axi_interconnect_ARVALID;
  wire [31:0]m07_couplers_to_axi_interconnect_AWADDR;
  wire m07_couplers_to_axi_interconnect_AWREADY;
  wire m07_couplers_to_axi_interconnect_AWVALID;
  wire m07_couplers_to_axi_interconnect_BREADY;
  wire [1:0]m07_couplers_to_axi_interconnect_BRESP;
  wire m07_couplers_to_axi_interconnect_BVALID;
  wire [31:0]m07_couplers_to_axi_interconnect_RDATA;
  wire m07_couplers_to_axi_interconnect_RREADY;
  wire [1:0]m07_couplers_to_axi_interconnect_RRESP;
  wire m07_couplers_to_axi_interconnect_RVALID;
  wire [31:0]m07_couplers_to_axi_interconnect_WDATA;
  wire m07_couplers_to_axi_interconnect_WREADY;
  wire [3:0]m07_couplers_to_axi_interconnect_WSTRB;
  wire m07_couplers_to_axi_interconnect_WVALID;
  wire [8:0]m08_couplers_to_axi_interconnect_ARADDR;
  wire m08_couplers_to_axi_interconnect_ARREADY;
  wire m08_couplers_to_axi_interconnect_ARVALID;
  wire [8:0]m08_couplers_to_axi_interconnect_AWADDR;
  wire m08_couplers_to_axi_interconnect_AWREADY;
  wire m08_couplers_to_axi_interconnect_AWVALID;
  wire m08_couplers_to_axi_interconnect_BREADY;
  wire [1:0]m08_couplers_to_axi_interconnect_BRESP;
  wire m08_couplers_to_axi_interconnect_BVALID;
  wire [31:0]m08_couplers_to_axi_interconnect_RDATA;
  wire m08_couplers_to_axi_interconnect_RREADY;
  wire [1:0]m08_couplers_to_axi_interconnect_RRESP;
  wire m08_couplers_to_axi_interconnect_RVALID;
  wire [31:0]m08_couplers_to_axi_interconnect_WDATA;
  wire m08_couplers_to_axi_interconnect_WREADY;
  wire [3:0]m08_couplers_to_axi_interconnect_WSTRB;
  wire m08_couplers_to_axi_interconnect_WVALID;
  wire [31:0]s00_couplers_to_xbar_ARADDR;
  wire [2:0]s00_couplers_to_xbar_ARPROT;
  wire [0:0]s00_couplers_to_xbar_ARREADY;
  wire s00_couplers_to_xbar_ARVALID;
  wire [31:0]s00_couplers_to_xbar_AWADDR;
  wire [2:0]s00_couplers_to_xbar_AWPROT;
  wire [0:0]s00_couplers_to_xbar_AWREADY;
  wire s00_couplers_to_xbar_AWVALID;
  wire s00_couplers_to_xbar_BREADY;
  wire [1:0]s00_couplers_to_xbar_BRESP;
  wire [0:0]s00_couplers_to_xbar_BVALID;
  wire [31:0]s00_couplers_to_xbar_RDATA;
  wire s00_couplers_to_xbar_RREADY;
  wire [1:0]s00_couplers_to_xbar_RRESP;
  wire [0:0]s00_couplers_to_xbar_RVALID;
  wire [31:0]s00_couplers_to_xbar_WDATA;
  wire [0:0]s00_couplers_to_xbar_WREADY;
  wire [3:0]s00_couplers_to_xbar_WSTRB;
  wire s00_couplers_to_xbar_WVALID;
  wire [31:0]xbar_to_m00_couplers_ARADDR;
  wire [2:0]xbar_to_m00_couplers_ARPROT;
  wire [0:0]xbar_to_m00_couplers_ARREADY;
  wire [0:0]xbar_to_m00_couplers_ARVALID;
  wire [31:0]xbar_to_m00_couplers_AWADDR;
  wire [2:0]xbar_to_m00_couplers_AWPROT;
  wire [0:0]xbar_to_m00_couplers_AWREADY;
  wire [0:0]xbar_to_m00_couplers_AWVALID;
  wire [0:0]xbar_to_m00_couplers_BREADY;
  wire [1:0]xbar_to_m00_couplers_BRESP;
  wire [0:0]xbar_to_m00_couplers_BVALID;
  wire [31:0]xbar_to_m00_couplers_RDATA;
  wire [0:0]xbar_to_m00_couplers_RREADY;
  wire [1:0]xbar_to_m00_couplers_RRESP;
  wire [0:0]xbar_to_m00_couplers_RVALID;
  wire [31:0]xbar_to_m00_couplers_WDATA;
  wire [0:0]xbar_to_m00_couplers_WREADY;
  wire [3:0]xbar_to_m00_couplers_WSTRB;
  wire [0:0]xbar_to_m00_couplers_WVALID;
  wire [63:32]xbar_to_m01_couplers_ARADDR;
  wire [5:3]xbar_to_m01_couplers_ARPROT;
  wire [0:0]xbar_to_m01_couplers_ARREADY;
  wire [1:1]xbar_to_m01_couplers_ARVALID;
  wire [63:32]xbar_to_m01_couplers_AWADDR;
  wire [5:3]xbar_to_m01_couplers_AWPROT;
  wire [0:0]xbar_to_m01_couplers_AWREADY;
  wire [1:1]xbar_to_m01_couplers_AWVALID;
  wire [1:1]xbar_to_m01_couplers_BREADY;
  wire [1:0]xbar_to_m01_couplers_BRESP;
  wire [0:0]xbar_to_m01_couplers_BVALID;
  wire [31:0]xbar_to_m01_couplers_RDATA;
  wire [1:1]xbar_to_m01_couplers_RREADY;
  wire [1:0]xbar_to_m01_couplers_RRESP;
  wire [0:0]xbar_to_m01_couplers_RVALID;
  wire [63:32]xbar_to_m01_couplers_WDATA;
  wire [0:0]xbar_to_m01_couplers_WREADY;
  wire [7:4]xbar_to_m01_couplers_WSTRB;
  wire [1:1]xbar_to_m01_couplers_WVALID;
  wire [95:64]xbar_to_m02_couplers_ARADDR;
  wire [8:6]xbar_to_m02_couplers_ARPROT;
  wire [0:0]xbar_to_m02_couplers_ARREADY;
  wire [2:2]xbar_to_m02_couplers_ARVALID;
  wire [95:64]xbar_to_m02_couplers_AWADDR;
  wire [8:6]xbar_to_m02_couplers_AWPROT;
  wire [0:0]xbar_to_m02_couplers_AWREADY;
  wire [2:2]xbar_to_m02_couplers_AWVALID;
  wire [2:2]xbar_to_m02_couplers_BREADY;
  wire [1:0]xbar_to_m02_couplers_BRESP;
  wire [0:0]xbar_to_m02_couplers_BVALID;
  wire [31:0]xbar_to_m02_couplers_RDATA;
  wire [2:2]xbar_to_m02_couplers_RREADY;
  wire [1:0]xbar_to_m02_couplers_RRESP;
  wire [0:0]xbar_to_m02_couplers_RVALID;
  wire [95:64]xbar_to_m02_couplers_WDATA;
  wire [0:0]xbar_to_m02_couplers_WREADY;
  wire [11:8]xbar_to_m02_couplers_WSTRB;
  wire [2:2]xbar_to_m02_couplers_WVALID;
  wire [127:96]xbar_to_m03_couplers_ARADDR;
  wire xbar_to_m03_couplers_ARREADY;
  wire [3:3]xbar_to_m03_couplers_ARVALID;
  wire [127:96]xbar_to_m03_couplers_AWADDR;
  wire xbar_to_m03_couplers_AWREADY;
  wire [3:3]xbar_to_m03_couplers_AWVALID;
  wire [3:3]xbar_to_m03_couplers_BREADY;
  wire [1:0]xbar_to_m03_couplers_BRESP;
  wire xbar_to_m03_couplers_BVALID;
  wire [31:0]xbar_to_m03_couplers_RDATA;
  wire [3:3]xbar_to_m03_couplers_RREADY;
  wire [1:0]xbar_to_m03_couplers_RRESP;
  wire xbar_to_m03_couplers_RVALID;
  wire [127:96]xbar_to_m03_couplers_WDATA;
  wire xbar_to_m03_couplers_WREADY;
  wire [15:12]xbar_to_m03_couplers_WSTRB;
  wire [3:3]xbar_to_m03_couplers_WVALID;
  wire [159:128]xbar_to_m04_couplers_ARADDR;
  wire xbar_to_m04_couplers_ARREADY;
  wire [4:4]xbar_to_m04_couplers_ARVALID;
  wire [159:128]xbar_to_m04_couplers_AWADDR;
  wire xbar_to_m04_couplers_AWREADY;
  wire [4:4]xbar_to_m04_couplers_AWVALID;
  wire [4:4]xbar_to_m04_couplers_BREADY;
  wire [1:0]xbar_to_m04_couplers_BRESP;
  wire xbar_to_m04_couplers_BVALID;
  wire [31:0]xbar_to_m04_couplers_RDATA;
  wire [4:4]xbar_to_m04_couplers_RREADY;
  wire [1:0]xbar_to_m04_couplers_RRESP;
  wire xbar_to_m04_couplers_RVALID;
  wire [159:128]xbar_to_m04_couplers_WDATA;
  wire xbar_to_m04_couplers_WREADY;
  wire [19:16]xbar_to_m04_couplers_WSTRB;
  wire [4:4]xbar_to_m04_couplers_WVALID;
  wire [191:160]xbar_to_m05_couplers_ARADDR;
  wire [17:15]xbar_to_m05_couplers_ARPROT;
  wire xbar_to_m05_couplers_ARREADY;
  wire [5:5]xbar_to_m05_couplers_ARVALID;
  wire [191:160]xbar_to_m05_couplers_AWADDR;
  wire [17:15]xbar_to_m05_couplers_AWPROT;
  wire xbar_to_m05_couplers_AWREADY;
  wire [5:5]xbar_to_m05_couplers_AWVALID;
  wire [5:5]xbar_to_m05_couplers_BREADY;
  wire [1:0]xbar_to_m05_couplers_BRESP;
  wire xbar_to_m05_couplers_BVALID;
  wire [31:0]xbar_to_m05_couplers_RDATA;
  wire [5:5]xbar_to_m05_couplers_RREADY;
  wire [1:0]xbar_to_m05_couplers_RRESP;
  wire xbar_to_m05_couplers_RVALID;
  wire [191:160]xbar_to_m05_couplers_WDATA;
  wire xbar_to_m05_couplers_WREADY;
  wire [23:20]xbar_to_m05_couplers_WSTRB;
  wire [5:5]xbar_to_m05_couplers_WVALID;
  wire [223:192]xbar_to_m06_couplers_ARADDR;
  wire [20:18]xbar_to_m06_couplers_ARPROT;
  wire [0:0]xbar_to_m06_couplers_ARREADY;
  wire [6:6]xbar_to_m06_couplers_ARVALID;
  wire [223:192]xbar_to_m06_couplers_AWADDR;
  wire [20:18]xbar_to_m06_couplers_AWPROT;
  wire [0:0]xbar_to_m06_couplers_AWREADY;
  wire [6:6]xbar_to_m06_couplers_AWVALID;
  wire [6:6]xbar_to_m06_couplers_BREADY;
  wire [1:0]xbar_to_m06_couplers_BRESP;
  wire [0:0]xbar_to_m06_couplers_BVALID;
  wire [31:0]xbar_to_m06_couplers_RDATA;
  wire [6:6]xbar_to_m06_couplers_RREADY;
  wire [1:0]xbar_to_m06_couplers_RRESP;
  wire [0:0]xbar_to_m06_couplers_RVALID;
  wire [223:192]xbar_to_m06_couplers_WDATA;
  wire [0:0]xbar_to_m06_couplers_WREADY;
  wire [27:24]xbar_to_m06_couplers_WSTRB;
  wire [6:6]xbar_to_m06_couplers_WVALID;
  wire [255:224]xbar_to_m07_couplers_ARADDR;
  wire xbar_to_m07_couplers_ARREADY;
  wire [7:7]xbar_to_m07_couplers_ARVALID;
  wire [255:224]xbar_to_m07_couplers_AWADDR;
  wire xbar_to_m07_couplers_AWREADY;
  wire [7:7]xbar_to_m07_couplers_AWVALID;
  wire [7:7]xbar_to_m07_couplers_BREADY;
  wire [1:0]xbar_to_m07_couplers_BRESP;
  wire xbar_to_m07_couplers_BVALID;
  wire [31:0]xbar_to_m07_couplers_RDATA;
  wire [7:7]xbar_to_m07_couplers_RREADY;
  wire [1:0]xbar_to_m07_couplers_RRESP;
  wire xbar_to_m07_couplers_RVALID;
  wire [255:224]xbar_to_m07_couplers_WDATA;
  wire xbar_to_m07_couplers_WREADY;
  wire [31:28]xbar_to_m07_couplers_WSTRB;
  wire [7:7]xbar_to_m07_couplers_WVALID;
  wire [287:256]xbar_to_m08_couplers_ARADDR;
  wire [26:24]xbar_to_m08_couplers_ARPROT;
  wire xbar_to_m08_couplers_ARREADY;
  wire [8:8]xbar_to_m08_couplers_ARVALID;
  wire [287:256]xbar_to_m08_couplers_AWADDR;
  wire [26:24]xbar_to_m08_couplers_AWPROT;
  wire xbar_to_m08_couplers_AWREADY;
  wire [8:8]xbar_to_m08_couplers_AWVALID;
  wire [8:8]xbar_to_m08_couplers_BREADY;
  wire [1:0]xbar_to_m08_couplers_BRESP;
  wire xbar_to_m08_couplers_BVALID;
  wire [31:0]xbar_to_m08_couplers_RDATA;
  wire [8:8]xbar_to_m08_couplers_RREADY;
  wire [1:0]xbar_to_m08_couplers_RRESP;
  wire xbar_to_m08_couplers_RVALID;
  wire [287:256]xbar_to_m08_couplers_WDATA;
  wire xbar_to_m08_couplers_WREADY;
  wire [35:32]xbar_to_m08_couplers_WSTRB;
  wire [8:8]xbar_to_m08_couplers_WVALID;
  wire [26:0]NLW_xbar_m_axi_arprot_UNCONNECTED;
  wire [26:0]NLW_xbar_m_axi_awprot_UNCONNECTED;

  assign M00_ACLK_1 = M00_ACLK;
  assign M00_ARESETN_1 = M00_ARESETN;
  assign M00_AXI_araddr[31:0] = m00_couplers_to_axi_interconnect_ARADDR;
  assign M00_AXI_arprot[2:0] = m00_couplers_to_axi_interconnect_ARPROT;
  assign M00_AXI_arvalid[0] = m00_couplers_to_axi_interconnect_ARVALID;
  assign M00_AXI_awaddr[31:0] = m00_couplers_to_axi_interconnect_AWADDR;
  assign M00_AXI_awprot[2:0] = m00_couplers_to_axi_interconnect_AWPROT;
  assign M00_AXI_awvalid[0] = m00_couplers_to_axi_interconnect_AWVALID;
  assign M00_AXI_bready[0] = m00_couplers_to_axi_interconnect_BREADY;
  assign M00_AXI_rready[0] = m00_couplers_to_axi_interconnect_RREADY;
  assign M00_AXI_wdata[31:0] = m00_couplers_to_axi_interconnect_WDATA;
  assign M00_AXI_wstrb[3:0] = m00_couplers_to_axi_interconnect_WSTRB;
  assign M00_AXI_wvalid[0] = m00_couplers_to_axi_interconnect_WVALID;
  assign M01_ACLK_1 = M01_ACLK;
  assign M01_ARESETN_1 = M01_ARESETN;
  assign M01_AXI_araddr[31:0] = m01_couplers_to_axi_interconnect_ARADDR;
  assign M01_AXI_arprot[2:0] = m01_couplers_to_axi_interconnect_ARPROT;
  assign M01_AXI_arvalid[0] = m01_couplers_to_axi_interconnect_ARVALID;
  assign M01_AXI_awaddr[31:0] = m01_couplers_to_axi_interconnect_AWADDR;
  assign M01_AXI_awprot[2:0] = m01_couplers_to_axi_interconnect_AWPROT;
  assign M01_AXI_awvalid[0] = m01_couplers_to_axi_interconnect_AWVALID;
  assign M01_AXI_bready[0] = m01_couplers_to_axi_interconnect_BREADY;
  assign M01_AXI_rready[0] = m01_couplers_to_axi_interconnect_RREADY;
  assign M01_AXI_wdata[31:0] = m01_couplers_to_axi_interconnect_WDATA;
  assign M01_AXI_wstrb[3:0] = m01_couplers_to_axi_interconnect_WSTRB;
  assign M01_AXI_wvalid[0] = m01_couplers_to_axi_interconnect_WVALID;
  assign M02_ACLK_1 = M02_ACLK;
  assign M02_ARESETN_1 = M02_ARESETN;
  assign M02_AXI_araddr[31:0] = m02_couplers_to_axi_interconnect_ARADDR;
  assign M02_AXI_arprot[2:0] = m02_couplers_to_axi_interconnect_ARPROT;
  assign M02_AXI_arvalid[0] = m02_couplers_to_axi_interconnect_ARVALID;
  assign M02_AXI_awaddr[31:0] = m02_couplers_to_axi_interconnect_AWADDR;
  assign M02_AXI_awprot[2:0] = m02_couplers_to_axi_interconnect_AWPROT;
  assign M02_AXI_awvalid[0] = m02_couplers_to_axi_interconnect_AWVALID;
  assign M02_AXI_bready[0] = m02_couplers_to_axi_interconnect_BREADY;
  assign M02_AXI_rready[0] = m02_couplers_to_axi_interconnect_RREADY;
  assign M02_AXI_wdata[31:0] = m02_couplers_to_axi_interconnect_WDATA;
  assign M02_AXI_wstrb[3:0] = m02_couplers_to_axi_interconnect_WSTRB;
  assign M02_AXI_wvalid[0] = m02_couplers_to_axi_interconnect_WVALID;
  assign M03_ACLK_1 = M03_ACLK;
  assign M03_ARESETN_1 = M03_ARESETN;
  assign M03_AXI_araddr[31:0] = m03_couplers_to_axi_interconnect_ARADDR;
  assign M03_AXI_arvalid = m03_couplers_to_axi_interconnect_ARVALID;
  assign M03_AXI_awaddr[31:0] = m03_couplers_to_axi_interconnect_AWADDR;
  assign M03_AXI_awvalid = m03_couplers_to_axi_interconnect_AWVALID;
  assign M03_AXI_bready = m03_couplers_to_axi_interconnect_BREADY;
  assign M03_AXI_rready = m03_couplers_to_axi_interconnect_RREADY;
  assign M03_AXI_wdata[31:0] = m03_couplers_to_axi_interconnect_WDATA;
  assign M03_AXI_wstrb[3:0] = m03_couplers_to_axi_interconnect_WSTRB;
  assign M03_AXI_wvalid = m03_couplers_to_axi_interconnect_WVALID;
  assign M04_ACLK_1 = M04_ACLK;
  assign M04_ARESETN_1 = M04_ARESETN;
  assign M04_AXI_araddr[31:0] = m04_couplers_to_axi_interconnect_ARADDR;
  assign M04_AXI_arvalid = m04_couplers_to_axi_interconnect_ARVALID;
  assign M04_AXI_awaddr[31:0] = m04_couplers_to_axi_interconnect_AWADDR;
  assign M04_AXI_awvalid = m04_couplers_to_axi_interconnect_AWVALID;
  assign M04_AXI_bready = m04_couplers_to_axi_interconnect_BREADY;
  assign M04_AXI_rready = m04_couplers_to_axi_interconnect_RREADY;
  assign M04_AXI_wdata[31:0] = m04_couplers_to_axi_interconnect_WDATA;
  assign M04_AXI_wstrb[3:0] = m04_couplers_to_axi_interconnect_WSTRB;
  assign M04_AXI_wvalid = m04_couplers_to_axi_interconnect_WVALID;
  assign M05_ACLK_1 = M05_ACLK;
  assign M05_ARESETN_1 = M05_ARESETN;
  assign M05_AXI_araddr[7:0] = m05_couplers_to_axi_interconnect_ARADDR;
  assign M05_AXI_arvalid = m05_couplers_to_axi_interconnect_ARVALID;
  assign M05_AXI_awaddr[7:0] = m05_couplers_to_axi_interconnect_AWADDR;
  assign M05_AXI_awvalid = m05_couplers_to_axi_interconnect_AWVALID;
  assign M05_AXI_bready = m05_couplers_to_axi_interconnect_BREADY;
  assign M05_AXI_rready = m05_couplers_to_axi_interconnect_RREADY;
  assign M05_AXI_wdata[31:0] = m05_couplers_to_axi_interconnect_WDATA;
  assign M05_AXI_wstrb[3:0] = m05_couplers_to_axi_interconnect_WSTRB;
  assign M05_AXI_wvalid = m05_couplers_to_axi_interconnect_WVALID;
  assign M06_ACLK_1 = M06_ACLK;
  assign M06_ARESETN_1 = M06_ARESETN;
  assign M06_AXI_araddr[31:0] = m06_couplers_to_axi_interconnect_ARADDR;
  assign M06_AXI_arprot[2:0] = m06_couplers_to_axi_interconnect_ARPROT;
  assign M06_AXI_arvalid[0] = m06_couplers_to_axi_interconnect_ARVALID;
  assign M06_AXI_awaddr[31:0] = m06_couplers_to_axi_interconnect_AWADDR;
  assign M06_AXI_awprot[2:0] = m06_couplers_to_axi_interconnect_AWPROT;
  assign M06_AXI_awvalid[0] = m06_couplers_to_axi_interconnect_AWVALID;
  assign M06_AXI_bready[0] = m06_couplers_to_axi_interconnect_BREADY;
  assign M06_AXI_rready[0] = m06_couplers_to_axi_interconnect_RREADY;
  assign M06_AXI_wdata[31:0] = m06_couplers_to_axi_interconnect_WDATA;
  assign M06_AXI_wstrb[3:0] = m06_couplers_to_axi_interconnect_WSTRB;
  assign M06_AXI_wvalid[0] = m06_couplers_to_axi_interconnect_WVALID;
  assign M07_ACLK_1 = M07_ACLK;
  assign M07_ARESETN_1 = M07_ARESETN;
  assign M07_AXI_araddr[31:0] = m07_couplers_to_axi_interconnect_ARADDR;
  assign M07_AXI_arvalid = m07_couplers_to_axi_interconnect_ARVALID;
  assign M07_AXI_awaddr[31:0] = m07_couplers_to_axi_interconnect_AWADDR;
  assign M07_AXI_awvalid = m07_couplers_to_axi_interconnect_AWVALID;
  assign M07_AXI_bready = m07_couplers_to_axi_interconnect_BREADY;
  assign M07_AXI_rready = m07_couplers_to_axi_interconnect_RREADY;
  assign M07_AXI_wdata[31:0] = m07_couplers_to_axi_interconnect_WDATA;
  assign M07_AXI_wstrb[3:0] = m07_couplers_to_axi_interconnect_WSTRB;
  assign M07_AXI_wvalid = m07_couplers_to_axi_interconnect_WVALID;
  assign M08_ACLK_1 = M08_ACLK;
  assign M08_ARESETN_1 = M08_ARESETN;
  assign M08_AXI_araddr[8:0] = m08_couplers_to_axi_interconnect_ARADDR;
  assign M08_AXI_arvalid = m08_couplers_to_axi_interconnect_ARVALID;
  assign M08_AXI_awaddr[8:0] = m08_couplers_to_axi_interconnect_AWADDR;
  assign M08_AXI_awvalid = m08_couplers_to_axi_interconnect_AWVALID;
  assign M08_AXI_bready = m08_couplers_to_axi_interconnect_BREADY;
  assign M08_AXI_rready = m08_couplers_to_axi_interconnect_RREADY;
  assign M08_AXI_wdata[31:0] = m08_couplers_to_axi_interconnect_WDATA;
  assign M08_AXI_wstrb[3:0] = m08_couplers_to_axi_interconnect_WSTRB;
  assign M08_AXI_wvalid = m08_couplers_to_axi_interconnect_WVALID;
  assign S00_ACLK_1 = S00_ACLK;
  assign S00_ARESETN_1 = S00_ARESETN;
  assign S00_AXI_arready = axi_interconnect_to_s00_couplers_ARREADY;
  assign S00_AXI_awready = axi_interconnect_to_s00_couplers_AWREADY;
  assign S00_AXI_bresp[1:0] = axi_interconnect_to_s00_couplers_BRESP;
  assign S00_AXI_bvalid = axi_interconnect_to_s00_couplers_BVALID;
  assign S00_AXI_rdata[31:0] = axi_interconnect_to_s00_couplers_RDATA;
  assign S00_AXI_rresp[1:0] = axi_interconnect_to_s00_couplers_RRESP;
  assign S00_AXI_rvalid = axi_interconnect_to_s00_couplers_RVALID;
  assign S00_AXI_wready = axi_interconnect_to_s00_couplers_WREADY;
  assign axi_interconnect_ACLK_net = ACLK;
  assign axi_interconnect_ARESETN_net = ARESETN;
  assign axi_interconnect_to_s00_couplers_ARADDR = S00_AXI_araddr[31:0];
  assign axi_interconnect_to_s00_couplers_ARPROT = S00_AXI_arprot[2:0];
  assign axi_interconnect_to_s00_couplers_ARVALID = S00_AXI_arvalid;
  assign axi_interconnect_to_s00_couplers_AWADDR = S00_AXI_awaddr[31:0];
  assign axi_interconnect_to_s00_couplers_AWPROT = S00_AXI_awprot[2:0];
  assign axi_interconnect_to_s00_couplers_AWVALID = S00_AXI_awvalid;
  assign axi_interconnect_to_s00_couplers_BREADY = S00_AXI_bready;
  assign axi_interconnect_to_s00_couplers_RREADY = S00_AXI_rready;
  assign axi_interconnect_to_s00_couplers_WDATA = S00_AXI_wdata[31:0];
  assign axi_interconnect_to_s00_couplers_WSTRB = S00_AXI_wstrb[3:0];
  assign axi_interconnect_to_s00_couplers_WVALID = S00_AXI_wvalid;
  assign m00_couplers_to_axi_interconnect_ARREADY = M00_AXI_arready[0];
  assign m00_couplers_to_axi_interconnect_AWREADY = M00_AXI_awready[0];
  assign m00_couplers_to_axi_interconnect_BRESP = M00_AXI_bresp[1:0];
  assign m00_couplers_to_axi_interconnect_BVALID = M00_AXI_bvalid[0];
  assign m00_couplers_to_axi_interconnect_RDATA = M00_AXI_rdata[31:0];
  assign m00_couplers_to_axi_interconnect_RRESP = M00_AXI_rresp[1:0];
  assign m00_couplers_to_axi_interconnect_RVALID = M00_AXI_rvalid[0];
  assign m00_couplers_to_axi_interconnect_WREADY = M00_AXI_wready[0];
  assign m01_couplers_to_axi_interconnect_ARREADY = M01_AXI_arready[0];
  assign m01_couplers_to_axi_interconnect_AWREADY = M01_AXI_awready[0];
  assign m01_couplers_to_axi_interconnect_BRESP = M01_AXI_bresp[1:0];
  assign m01_couplers_to_axi_interconnect_BVALID = M01_AXI_bvalid[0];
  assign m01_couplers_to_axi_interconnect_RDATA = M01_AXI_rdata[31:0];
  assign m01_couplers_to_axi_interconnect_RRESP = M01_AXI_rresp[1:0];
  assign m01_couplers_to_axi_interconnect_RVALID = M01_AXI_rvalid[0];
  assign m01_couplers_to_axi_interconnect_WREADY = M01_AXI_wready[0];
  assign m02_couplers_to_axi_interconnect_ARREADY = M02_AXI_arready[0];
  assign m02_couplers_to_axi_interconnect_AWREADY = M02_AXI_awready[0];
  assign m02_couplers_to_axi_interconnect_BRESP = M02_AXI_bresp[1:0];
  assign m02_couplers_to_axi_interconnect_BVALID = M02_AXI_bvalid[0];
  assign m02_couplers_to_axi_interconnect_RDATA = M02_AXI_rdata[31:0];
  assign m02_couplers_to_axi_interconnect_RRESP = M02_AXI_rresp[1:0];
  assign m02_couplers_to_axi_interconnect_RVALID = M02_AXI_rvalid[0];
  assign m02_couplers_to_axi_interconnect_WREADY = M02_AXI_wready[0];
  assign m03_couplers_to_axi_interconnect_ARREADY = M03_AXI_arready;
  assign m03_couplers_to_axi_interconnect_AWREADY = M03_AXI_awready;
  assign m03_couplers_to_axi_interconnect_BRESP = M03_AXI_bresp[1:0];
  assign m03_couplers_to_axi_interconnect_BVALID = M03_AXI_bvalid;
  assign m03_couplers_to_axi_interconnect_RDATA = M03_AXI_rdata[31:0];
  assign m03_couplers_to_axi_interconnect_RRESP = M03_AXI_rresp[1:0];
  assign m03_couplers_to_axi_interconnect_RVALID = M03_AXI_rvalid;
  assign m03_couplers_to_axi_interconnect_WREADY = M03_AXI_wready;
  assign m04_couplers_to_axi_interconnect_ARREADY = M04_AXI_arready;
  assign m04_couplers_to_axi_interconnect_AWREADY = M04_AXI_awready;
  assign m04_couplers_to_axi_interconnect_BRESP = M04_AXI_bresp[1:0];
  assign m04_couplers_to_axi_interconnect_BVALID = M04_AXI_bvalid;
  assign m04_couplers_to_axi_interconnect_RDATA = M04_AXI_rdata[31:0];
  assign m04_couplers_to_axi_interconnect_RRESP = M04_AXI_rresp[1:0];
  assign m04_couplers_to_axi_interconnect_RVALID = M04_AXI_rvalid;
  assign m04_couplers_to_axi_interconnect_WREADY = M04_AXI_wready;
  assign m05_couplers_to_axi_interconnect_ARREADY = M05_AXI_arready;
  assign m05_couplers_to_axi_interconnect_AWREADY = M05_AXI_awready;
  assign m05_couplers_to_axi_interconnect_BRESP = M05_AXI_bresp[1:0];
  assign m05_couplers_to_axi_interconnect_BVALID = M05_AXI_bvalid;
  assign m05_couplers_to_axi_interconnect_RDATA = M05_AXI_rdata[31:0];
  assign m05_couplers_to_axi_interconnect_RRESP = M05_AXI_rresp[1:0];
  assign m05_couplers_to_axi_interconnect_RVALID = M05_AXI_rvalid;
  assign m05_couplers_to_axi_interconnect_WREADY = M05_AXI_wready;
  assign m06_couplers_to_axi_interconnect_ARREADY = M06_AXI_arready[0];
  assign m06_couplers_to_axi_interconnect_AWREADY = M06_AXI_awready[0];
  assign m06_couplers_to_axi_interconnect_BRESP = M06_AXI_bresp[1:0];
  assign m06_couplers_to_axi_interconnect_BVALID = M06_AXI_bvalid[0];
  assign m06_couplers_to_axi_interconnect_RDATA = M06_AXI_rdata[31:0];
  assign m06_couplers_to_axi_interconnect_RRESP = M06_AXI_rresp[1:0];
  assign m06_couplers_to_axi_interconnect_RVALID = M06_AXI_rvalid[0];
  assign m06_couplers_to_axi_interconnect_WREADY = M06_AXI_wready[0];
  assign m07_couplers_to_axi_interconnect_ARREADY = M07_AXI_arready;
  assign m07_couplers_to_axi_interconnect_AWREADY = M07_AXI_awready;
  assign m07_couplers_to_axi_interconnect_BRESP = M07_AXI_bresp[1:0];
  assign m07_couplers_to_axi_interconnect_BVALID = M07_AXI_bvalid;
  assign m07_couplers_to_axi_interconnect_RDATA = M07_AXI_rdata[31:0];
  assign m07_couplers_to_axi_interconnect_RRESP = M07_AXI_rresp[1:0];
  assign m07_couplers_to_axi_interconnect_RVALID = M07_AXI_rvalid;
  assign m07_couplers_to_axi_interconnect_WREADY = M07_AXI_wready;
  assign m08_couplers_to_axi_interconnect_ARREADY = M08_AXI_arready;
  assign m08_couplers_to_axi_interconnect_AWREADY = M08_AXI_awready;
  assign m08_couplers_to_axi_interconnect_BRESP = M08_AXI_bresp[1:0];
  assign m08_couplers_to_axi_interconnect_BVALID = M08_AXI_bvalid;
  assign m08_couplers_to_axi_interconnect_RDATA = M08_AXI_rdata[31:0];
  assign m08_couplers_to_axi_interconnect_RRESP = M08_AXI_rresp[1:0];
  assign m08_couplers_to_axi_interconnect_RVALID = M08_AXI_rvalid;
  assign m08_couplers_to_axi_interconnect_WREADY = M08_AXI_wready;
  m00_couplers_imp_FLAFIE m00_couplers
       (.M_ACLK(M00_ACLK_1),
        .M_ARESETN(M00_ARESETN_1),
        .M_AXI_araddr(m00_couplers_to_axi_interconnect_ARADDR),
        .M_AXI_arprot(m00_couplers_to_axi_interconnect_ARPROT),
        .M_AXI_arready(m00_couplers_to_axi_interconnect_ARREADY),
        .M_AXI_arvalid(m00_couplers_to_axi_interconnect_ARVALID),
        .M_AXI_awaddr(m00_couplers_to_axi_interconnect_AWADDR),
        .M_AXI_awprot(m00_couplers_to_axi_interconnect_AWPROT),
        .M_AXI_awready(m00_couplers_to_axi_interconnect_AWREADY),
        .M_AXI_awvalid(m00_couplers_to_axi_interconnect_AWVALID),
        .M_AXI_bready(m00_couplers_to_axi_interconnect_BREADY),
        .M_AXI_bresp(m00_couplers_to_axi_interconnect_BRESP),
        .M_AXI_bvalid(m00_couplers_to_axi_interconnect_BVALID),
        .M_AXI_rdata(m00_couplers_to_axi_interconnect_RDATA),
        .M_AXI_rready(m00_couplers_to_axi_interconnect_RREADY),
        .M_AXI_rresp(m00_couplers_to_axi_interconnect_RRESP),
        .M_AXI_rvalid(m00_couplers_to_axi_interconnect_RVALID),
        .M_AXI_wdata(m00_couplers_to_axi_interconnect_WDATA),
        .M_AXI_wready(m00_couplers_to_axi_interconnect_WREADY),
        .M_AXI_wstrb(m00_couplers_to_axi_interconnect_WSTRB),
        .M_AXI_wvalid(m00_couplers_to_axi_interconnect_WVALID),
        .S_ACLK(axi_interconnect_ACLK_net),
        .S_ARESETN(axi_interconnect_ARESETN_net),
        .S_AXI_araddr(xbar_to_m00_couplers_ARADDR),
        .S_AXI_arprot(xbar_to_m00_couplers_ARPROT),
        .S_AXI_arready(xbar_to_m00_couplers_ARREADY),
        .S_AXI_arvalid(xbar_to_m00_couplers_ARVALID),
        .S_AXI_awaddr(xbar_to_m00_couplers_AWADDR),
        .S_AXI_awprot(xbar_to_m00_couplers_AWPROT),
        .S_AXI_awready(xbar_to_m00_couplers_AWREADY),
        .S_AXI_awvalid(xbar_to_m00_couplers_AWVALID),
        .S_AXI_bready(xbar_to_m00_couplers_BREADY),
        .S_AXI_bresp(xbar_to_m00_couplers_BRESP),
        .S_AXI_bvalid(xbar_to_m00_couplers_BVALID),
        .S_AXI_rdata(xbar_to_m00_couplers_RDATA),
        .S_AXI_rready(xbar_to_m00_couplers_RREADY),
        .S_AXI_rresp(xbar_to_m00_couplers_RRESP),
        .S_AXI_rvalid(xbar_to_m00_couplers_RVALID),
        .S_AXI_wdata(xbar_to_m00_couplers_WDATA),
        .S_AXI_wready(xbar_to_m00_couplers_WREADY),
        .S_AXI_wstrb(xbar_to_m00_couplers_WSTRB),
        .S_AXI_wvalid(xbar_to_m00_couplers_WVALID));
  m01_couplers_imp_100GMI6 m01_couplers
       (.M_ACLK(M01_ACLK_1),
        .M_ARESETN(M01_ARESETN_1),
        .M_AXI_araddr(m01_couplers_to_axi_interconnect_ARADDR),
        .M_AXI_arprot(m01_couplers_to_axi_interconnect_ARPROT),
        .M_AXI_arready(m01_couplers_to_axi_interconnect_ARREADY),
        .M_AXI_arvalid(m01_couplers_to_axi_interconnect_ARVALID),
        .M_AXI_awaddr(m01_couplers_to_axi_interconnect_AWADDR),
        .M_AXI_awprot(m01_couplers_to_axi_interconnect_AWPROT),
        .M_AXI_awready(m01_couplers_to_axi_interconnect_AWREADY),
        .M_AXI_awvalid(m01_couplers_to_axi_interconnect_AWVALID),
        .M_AXI_bready(m01_couplers_to_axi_interconnect_BREADY),
        .M_AXI_bresp(m01_couplers_to_axi_interconnect_BRESP),
        .M_AXI_bvalid(m01_couplers_to_axi_interconnect_BVALID),
        .M_AXI_rdata(m01_couplers_to_axi_interconnect_RDATA),
        .M_AXI_rready(m01_couplers_to_axi_interconnect_RREADY),
        .M_AXI_rresp(m01_couplers_to_axi_interconnect_RRESP),
        .M_AXI_rvalid(m01_couplers_to_axi_interconnect_RVALID),
        .M_AXI_wdata(m01_couplers_to_axi_interconnect_WDATA),
        .M_AXI_wready(m01_couplers_to_axi_interconnect_WREADY),
        .M_AXI_wstrb(m01_couplers_to_axi_interconnect_WSTRB),
        .M_AXI_wvalid(m01_couplers_to_axi_interconnect_WVALID),
        .S_ACLK(axi_interconnect_ACLK_net),
        .S_ARESETN(axi_interconnect_ARESETN_net),
        .S_AXI_araddr(xbar_to_m01_couplers_ARADDR),
        .S_AXI_arprot(xbar_to_m01_couplers_ARPROT),
        .S_AXI_arready(xbar_to_m01_couplers_ARREADY),
        .S_AXI_arvalid(xbar_to_m01_couplers_ARVALID),
        .S_AXI_awaddr(xbar_to_m01_couplers_AWADDR),
        .S_AXI_awprot(xbar_to_m01_couplers_AWPROT),
        .S_AXI_awready(xbar_to_m01_couplers_AWREADY),
        .S_AXI_awvalid(xbar_to_m01_couplers_AWVALID),
        .S_AXI_bready(xbar_to_m01_couplers_BREADY),
        .S_AXI_bresp(xbar_to_m01_couplers_BRESP),
        .S_AXI_bvalid(xbar_to_m01_couplers_BVALID),
        .S_AXI_rdata(xbar_to_m01_couplers_RDATA),
        .S_AXI_rready(xbar_to_m01_couplers_RREADY),
        .S_AXI_rresp(xbar_to_m01_couplers_RRESP),
        .S_AXI_rvalid(xbar_to_m01_couplers_RVALID),
        .S_AXI_wdata(xbar_to_m01_couplers_WDATA),
        .S_AXI_wready(xbar_to_m01_couplers_WREADY),
        .S_AXI_wstrb(xbar_to_m01_couplers_WSTRB),
        .S_AXI_wvalid(xbar_to_m01_couplers_WVALID));
  m02_couplers_imp_145JDEF m02_couplers
       (.M_ACLK(M02_ACLK_1),
        .M_ARESETN(M02_ARESETN_1),
        .M_AXI_araddr(m02_couplers_to_axi_interconnect_ARADDR),
        .M_AXI_arprot(m02_couplers_to_axi_interconnect_ARPROT),
        .M_AXI_arready(m02_couplers_to_axi_interconnect_ARREADY),
        .M_AXI_arvalid(m02_couplers_to_axi_interconnect_ARVALID),
        .M_AXI_awaddr(m02_couplers_to_axi_interconnect_AWADDR),
        .M_AXI_awprot(m02_couplers_to_axi_interconnect_AWPROT),
        .M_AXI_awready(m02_couplers_to_axi_interconnect_AWREADY),
        .M_AXI_awvalid(m02_couplers_to_axi_interconnect_AWVALID),
        .M_AXI_bready(m02_couplers_to_axi_interconnect_BREADY),
        .M_AXI_bresp(m02_couplers_to_axi_interconnect_BRESP),
        .M_AXI_bvalid(m02_couplers_to_axi_interconnect_BVALID),
        .M_AXI_rdata(m02_couplers_to_axi_interconnect_RDATA),
        .M_AXI_rready(m02_couplers_to_axi_interconnect_RREADY),
        .M_AXI_rresp(m02_couplers_to_axi_interconnect_RRESP),
        .M_AXI_rvalid(m02_couplers_to_axi_interconnect_RVALID),
        .M_AXI_wdata(m02_couplers_to_axi_interconnect_WDATA),
        .M_AXI_wready(m02_couplers_to_axi_interconnect_WREADY),
        .M_AXI_wstrb(m02_couplers_to_axi_interconnect_WSTRB),
        .M_AXI_wvalid(m02_couplers_to_axi_interconnect_WVALID),
        .S_ACLK(axi_interconnect_ACLK_net),
        .S_ARESETN(axi_interconnect_ARESETN_net),
        .S_AXI_araddr(xbar_to_m02_couplers_ARADDR),
        .S_AXI_arprot(xbar_to_m02_couplers_ARPROT),
        .S_AXI_arready(xbar_to_m02_couplers_ARREADY),
        .S_AXI_arvalid(xbar_to_m02_couplers_ARVALID),
        .S_AXI_awaddr(xbar_to_m02_couplers_AWADDR),
        .S_AXI_awprot(xbar_to_m02_couplers_AWPROT),
        .S_AXI_awready(xbar_to_m02_couplers_AWREADY),
        .S_AXI_awvalid(xbar_to_m02_couplers_AWVALID),
        .S_AXI_bready(xbar_to_m02_couplers_BREADY),
        .S_AXI_bresp(xbar_to_m02_couplers_BRESP),
        .S_AXI_bvalid(xbar_to_m02_couplers_BVALID),
        .S_AXI_rdata(xbar_to_m02_couplers_RDATA),
        .S_AXI_rready(xbar_to_m02_couplers_RREADY),
        .S_AXI_rresp(xbar_to_m02_couplers_RRESP),
        .S_AXI_rvalid(xbar_to_m02_couplers_RVALID),
        .S_AXI_wdata(xbar_to_m02_couplers_WDATA),
        .S_AXI_wready(xbar_to_m02_couplers_WREADY),
        .S_AXI_wstrb(xbar_to_m02_couplers_WSTRB),
        .S_AXI_wvalid(xbar_to_m02_couplers_WVALID));
  m03_couplers_imp_BGIKJJ m03_couplers
       (.M_ACLK(M03_ACLK_1),
        .M_ARESETN(M03_ARESETN_1),
        .M_AXI_araddr(m03_couplers_to_axi_interconnect_ARADDR),
        .M_AXI_arready(m03_couplers_to_axi_interconnect_ARREADY),
        .M_AXI_arvalid(m03_couplers_to_axi_interconnect_ARVALID),
        .M_AXI_awaddr(m03_couplers_to_axi_interconnect_AWADDR),
        .M_AXI_awready(m03_couplers_to_axi_interconnect_AWREADY),
        .M_AXI_awvalid(m03_couplers_to_axi_interconnect_AWVALID),
        .M_AXI_bready(m03_couplers_to_axi_interconnect_BREADY),
        .M_AXI_bresp(m03_couplers_to_axi_interconnect_BRESP),
        .M_AXI_bvalid(m03_couplers_to_axi_interconnect_BVALID),
        .M_AXI_rdata(m03_couplers_to_axi_interconnect_RDATA),
        .M_AXI_rready(m03_couplers_to_axi_interconnect_RREADY),
        .M_AXI_rresp(m03_couplers_to_axi_interconnect_RRESP),
        .M_AXI_rvalid(m03_couplers_to_axi_interconnect_RVALID),
        .M_AXI_wdata(m03_couplers_to_axi_interconnect_WDATA),
        .M_AXI_wready(m03_couplers_to_axi_interconnect_WREADY),
        .M_AXI_wstrb(m03_couplers_to_axi_interconnect_WSTRB),
        .M_AXI_wvalid(m03_couplers_to_axi_interconnect_WVALID),
        .S_ACLK(axi_interconnect_ACLK_net),
        .S_ARESETN(axi_interconnect_ARESETN_net),
        .S_AXI_araddr(xbar_to_m03_couplers_ARADDR),
        .S_AXI_arready(xbar_to_m03_couplers_ARREADY),
        .S_AXI_arvalid(xbar_to_m03_couplers_ARVALID),
        .S_AXI_awaddr(xbar_to_m03_couplers_AWADDR),
        .S_AXI_awready(xbar_to_m03_couplers_AWREADY),
        .S_AXI_awvalid(xbar_to_m03_couplers_AWVALID),
        .S_AXI_bready(xbar_to_m03_couplers_BREADY),
        .S_AXI_bresp(xbar_to_m03_couplers_BRESP),
        .S_AXI_bvalid(xbar_to_m03_couplers_BVALID),
        .S_AXI_rdata(xbar_to_m03_couplers_RDATA),
        .S_AXI_rready(xbar_to_m03_couplers_RREADY),
        .S_AXI_rresp(xbar_to_m03_couplers_RRESP),
        .S_AXI_rvalid(xbar_to_m03_couplers_RVALID),
        .S_AXI_wdata(xbar_to_m03_couplers_WDATA),
        .S_AXI_wready(xbar_to_m03_couplers_WREADY),
        .S_AXI_wstrb(xbar_to_m03_couplers_WSTRB),
        .S_AXI_wvalid(xbar_to_m03_couplers_WVALID));
  m04_couplers_imp_1DH0DWL m04_couplers
       (.M_ACLK(M04_ACLK_1),
        .M_ARESETN(M04_ARESETN_1),
        .M_AXI_araddr(m04_couplers_to_axi_interconnect_ARADDR),
        .M_AXI_arready(m04_couplers_to_axi_interconnect_ARREADY),
        .M_AXI_arvalid(m04_couplers_to_axi_interconnect_ARVALID),
        .M_AXI_awaddr(m04_couplers_to_axi_interconnect_AWADDR),
        .M_AXI_awready(m04_couplers_to_axi_interconnect_AWREADY),
        .M_AXI_awvalid(m04_couplers_to_axi_interconnect_AWVALID),
        .M_AXI_bready(m04_couplers_to_axi_interconnect_BREADY),
        .M_AXI_bresp(m04_couplers_to_axi_interconnect_BRESP),
        .M_AXI_bvalid(m04_couplers_to_axi_interconnect_BVALID),
        .M_AXI_rdata(m04_couplers_to_axi_interconnect_RDATA),
        .M_AXI_rready(m04_couplers_to_axi_interconnect_RREADY),
        .M_AXI_rresp(m04_couplers_to_axi_interconnect_RRESP),
        .M_AXI_rvalid(m04_couplers_to_axi_interconnect_RVALID),
        .M_AXI_wdata(m04_couplers_to_axi_interconnect_WDATA),
        .M_AXI_wready(m04_couplers_to_axi_interconnect_WREADY),
        .M_AXI_wstrb(m04_couplers_to_axi_interconnect_WSTRB),
        .M_AXI_wvalid(m04_couplers_to_axi_interconnect_WVALID),
        .S_ACLK(axi_interconnect_ACLK_net),
        .S_ARESETN(axi_interconnect_ARESETN_net),
        .S_AXI_araddr(xbar_to_m04_couplers_ARADDR),
        .S_AXI_arready(xbar_to_m04_couplers_ARREADY),
        .S_AXI_arvalid(xbar_to_m04_couplers_ARVALID),
        .S_AXI_awaddr(xbar_to_m04_couplers_AWADDR),
        .S_AXI_awready(xbar_to_m04_couplers_AWREADY),
        .S_AXI_awvalid(xbar_to_m04_couplers_AWVALID),
        .S_AXI_bready(xbar_to_m04_couplers_BREADY),
        .S_AXI_bresp(xbar_to_m04_couplers_BRESP),
        .S_AXI_bvalid(xbar_to_m04_couplers_BVALID),
        .S_AXI_rdata(xbar_to_m04_couplers_RDATA),
        .S_AXI_rready(xbar_to_m04_couplers_RREADY),
        .S_AXI_rresp(xbar_to_m04_couplers_RRESP),
        .S_AXI_rvalid(xbar_to_m04_couplers_RVALID),
        .S_AXI_wdata(xbar_to_m04_couplers_WDATA),
        .S_AXI_wready(xbar_to_m04_couplers_WREADY),
        .S_AXI_wstrb(xbar_to_m04_couplers_WSTRB),
        .S_AXI_wvalid(xbar_to_m04_couplers_WVALID));
  m05_couplers_imp_38ZVYL m05_couplers
       (.M_ACLK(M05_ACLK_1),
        .M_ARESETN(M05_ARESETN_1),
        .M_AXI_araddr(m05_couplers_to_axi_interconnect_ARADDR),
        .M_AXI_arready(m05_couplers_to_axi_interconnect_ARREADY),
        .M_AXI_arvalid(m05_couplers_to_axi_interconnect_ARVALID),
        .M_AXI_awaddr(m05_couplers_to_axi_interconnect_AWADDR),
        .M_AXI_awready(m05_couplers_to_axi_interconnect_AWREADY),
        .M_AXI_awvalid(m05_couplers_to_axi_interconnect_AWVALID),
        .M_AXI_bready(m05_couplers_to_axi_interconnect_BREADY),
        .M_AXI_bresp(m05_couplers_to_axi_interconnect_BRESP),
        .M_AXI_bvalid(m05_couplers_to_axi_interconnect_BVALID),
        .M_AXI_rdata(m05_couplers_to_axi_interconnect_RDATA),
        .M_AXI_rready(m05_couplers_to_axi_interconnect_RREADY),
        .M_AXI_rresp(m05_couplers_to_axi_interconnect_RRESP),
        .M_AXI_rvalid(m05_couplers_to_axi_interconnect_RVALID),
        .M_AXI_wdata(m05_couplers_to_axi_interconnect_WDATA),
        .M_AXI_wready(m05_couplers_to_axi_interconnect_WREADY),
        .M_AXI_wstrb(m05_couplers_to_axi_interconnect_WSTRB),
        .M_AXI_wvalid(m05_couplers_to_axi_interconnect_WVALID),
        .S_ACLK(axi_interconnect_ACLK_net),
        .S_ARESETN(axi_interconnect_ARESETN_net),
        .S_AXI_araddr(xbar_to_m05_couplers_ARADDR),
        .S_AXI_arprot(xbar_to_m05_couplers_ARPROT),
        .S_AXI_arready(xbar_to_m05_couplers_ARREADY),
        .S_AXI_arvalid(xbar_to_m05_couplers_ARVALID),
        .S_AXI_awaddr(xbar_to_m05_couplers_AWADDR),
        .S_AXI_awprot(xbar_to_m05_couplers_AWPROT),
        .S_AXI_awready(xbar_to_m05_couplers_AWREADY),
        .S_AXI_awvalid(xbar_to_m05_couplers_AWVALID),
        .S_AXI_bready(xbar_to_m05_couplers_BREADY),
        .S_AXI_bresp(xbar_to_m05_couplers_BRESP),
        .S_AXI_bvalid(xbar_to_m05_couplers_BVALID),
        .S_AXI_rdata(xbar_to_m05_couplers_RDATA),
        .S_AXI_rready(xbar_to_m05_couplers_RREADY),
        .S_AXI_rresp(xbar_to_m05_couplers_RRESP),
        .S_AXI_rvalid(xbar_to_m05_couplers_RVALID),
        .S_AXI_wdata(xbar_to_m05_couplers_WDATA),
        .S_AXI_wready(xbar_to_m05_couplers_WREADY),
        .S_AXI_wstrb(xbar_to_m05_couplers_WSTRB),
        .S_AXI_wvalid(xbar_to_m05_couplers_WVALID));
  m06_couplers_imp_7FNVN8 m06_couplers
       (.M_ACLK(M06_ACLK_1),
        .M_ARESETN(M06_ARESETN_1),
        .M_AXI_araddr(m06_couplers_to_axi_interconnect_ARADDR),
        .M_AXI_arprot(m06_couplers_to_axi_interconnect_ARPROT),
        .M_AXI_arready(m06_couplers_to_axi_interconnect_ARREADY),
        .M_AXI_arvalid(m06_couplers_to_axi_interconnect_ARVALID),
        .M_AXI_awaddr(m06_couplers_to_axi_interconnect_AWADDR),
        .M_AXI_awprot(m06_couplers_to_axi_interconnect_AWPROT),
        .M_AXI_awready(m06_couplers_to_axi_interconnect_AWREADY),
        .M_AXI_awvalid(m06_couplers_to_axi_interconnect_AWVALID),
        .M_AXI_bready(m06_couplers_to_axi_interconnect_BREADY),
        .M_AXI_bresp(m06_couplers_to_axi_interconnect_BRESP),
        .M_AXI_bvalid(m06_couplers_to_axi_interconnect_BVALID),
        .M_AXI_rdata(m06_couplers_to_axi_interconnect_RDATA),
        .M_AXI_rready(m06_couplers_to_axi_interconnect_RREADY),
        .M_AXI_rresp(m06_couplers_to_axi_interconnect_RRESP),
        .M_AXI_rvalid(m06_couplers_to_axi_interconnect_RVALID),
        .M_AXI_wdata(m06_couplers_to_axi_interconnect_WDATA),
        .M_AXI_wready(m06_couplers_to_axi_interconnect_WREADY),
        .M_AXI_wstrb(m06_couplers_to_axi_interconnect_WSTRB),
        .M_AXI_wvalid(m06_couplers_to_axi_interconnect_WVALID),
        .S_ACLK(axi_interconnect_ACLK_net),
        .S_ARESETN(axi_interconnect_ARESETN_net),
        .S_AXI_araddr(xbar_to_m06_couplers_ARADDR),
        .S_AXI_arprot(xbar_to_m06_couplers_ARPROT),
        .S_AXI_arready(xbar_to_m06_couplers_ARREADY),
        .S_AXI_arvalid(xbar_to_m06_couplers_ARVALID),
        .S_AXI_awaddr(xbar_to_m06_couplers_AWADDR),
        .S_AXI_awprot(xbar_to_m06_couplers_AWPROT),
        .S_AXI_awready(xbar_to_m06_couplers_AWREADY),
        .S_AXI_awvalid(xbar_to_m06_couplers_AWVALID),
        .S_AXI_bready(xbar_to_m06_couplers_BREADY),
        .S_AXI_bresp(xbar_to_m06_couplers_BRESP),
        .S_AXI_bvalid(xbar_to_m06_couplers_BVALID),
        .S_AXI_rdata(xbar_to_m06_couplers_RDATA),
        .S_AXI_rready(xbar_to_m06_couplers_RREADY),
        .S_AXI_rresp(xbar_to_m06_couplers_RRESP),
        .S_AXI_rvalid(xbar_to_m06_couplers_RVALID),
        .S_AXI_wdata(xbar_to_m06_couplers_WDATA),
        .S_AXI_wready(xbar_to_m06_couplers_WREADY),
        .S_AXI_wstrb(xbar_to_m06_couplers_WSTRB),
        .S_AXI_wvalid(xbar_to_m06_couplers_WVALID));
  m07_couplers_imp_19A1ICC m07_couplers
       (.M_ACLK(M07_ACLK_1),
        .M_ARESETN(M07_ARESETN_1),
        .M_AXI_araddr(m07_couplers_to_axi_interconnect_ARADDR),
        .M_AXI_arready(m07_couplers_to_axi_interconnect_ARREADY),
        .M_AXI_arvalid(m07_couplers_to_axi_interconnect_ARVALID),
        .M_AXI_awaddr(m07_couplers_to_axi_interconnect_AWADDR),
        .M_AXI_awready(m07_couplers_to_axi_interconnect_AWREADY),
        .M_AXI_awvalid(m07_couplers_to_axi_interconnect_AWVALID),
        .M_AXI_bready(m07_couplers_to_axi_interconnect_BREADY),
        .M_AXI_bresp(m07_couplers_to_axi_interconnect_BRESP),
        .M_AXI_bvalid(m07_couplers_to_axi_interconnect_BVALID),
        .M_AXI_rdata(m07_couplers_to_axi_interconnect_RDATA),
        .M_AXI_rready(m07_couplers_to_axi_interconnect_RREADY),
        .M_AXI_rresp(m07_couplers_to_axi_interconnect_RRESP),
        .M_AXI_rvalid(m07_couplers_to_axi_interconnect_RVALID),
        .M_AXI_wdata(m07_couplers_to_axi_interconnect_WDATA),
        .M_AXI_wready(m07_couplers_to_axi_interconnect_WREADY),
        .M_AXI_wstrb(m07_couplers_to_axi_interconnect_WSTRB),
        .M_AXI_wvalid(m07_couplers_to_axi_interconnect_WVALID),
        .S_ACLK(axi_interconnect_ACLK_net),
        .S_ARESETN(axi_interconnect_ARESETN_net),
        .S_AXI_araddr(xbar_to_m07_couplers_ARADDR),
        .S_AXI_arready(xbar_to_m07_couplers_ARREADY),
        .S_AXI_arvalid(xbar_to_m07_couplers_ARVALID),
        .S_AXI_awaddr(xbar_to_m07_couplers_AWADDR),
        .S_AXI_awready(xbar_to_m07_couplers_AWREADY),
        .S_AXI_awvalid(xbar_to_m07_couplers_AWVALID),
        .S_AXI_bready(xbar_to_m07_couplers_BREADY),
        .S_AXI_bresp(xbar_to_m07_couplers_BRESP),
        .S_AXI_bvalid(xbar_to_m07_couplers_BVALID),
        .S_AXI_rdata(xbar_to_m07_couplers_RDATA),
        .S_AXI_rready(xbar_to_m07_couplers_RREADY),
        .S_AXI_rresp(xbar_to_m07_couplers_RRESP),
        .S_AXI_rvalid(xbar_to_m07_couplers_RVALID),
        .S_AXI_wdata(xbar_to_m07_couplers_WDATA),
        .S_AXI_wready(xbar_to_m07_couplers_WREADY),
        .S_AXI_wstrb(xbar_to_m07_couplers_WSTRB),
        .S_AXI_wvalid(xbar_to_m07_couplers_WVALID));
  m08_couplers_imp_1WQFHXD m08_couplers
       (.M_ACLK(M08_ACLK_1),
        .M_ARESETN(M08_ARESETN_1),
        .M_AXI_araddr(m08_couplers_to_axi_interconnect_ARADDR),
        .M_AXI_arready(m08_couplers_to_axi_interconnect_ARREADY),
        .M_AXI_arvalid(m08_couplers_to_axi_interconnect_ARVALID),
        .M_AXI_awaddr(m08_couplers_to_axi_interconnect_AWADDR),
        .M_AXI_awready(m08_couplers_to_axi_interconnect_AWREADY),
        .M_AXI_awvalid(m08_couplers_to_axi_interconnect_AWVALID),
        .M_AXI_bready(m08_couplers_to_axi_interconnect_BREADY),
        .M_AXI_bresp(m08_couplers_to_axi_interconnect_BRESP),
        .M_AXI_bvalid(m08_couplers_to_axi_interconnect_BVALID),
        .M_AXI_rdata(m08_couplers_to_axi_interconnect_RDATA),
        .M_AXI_rready(m08_couplers_to_axi_interconnect_RREADY),
        .M_AXI_rresp(m08_couplers_to_axi_interconnect_RRESP),
        .M_AXI_rvalid(m08_couplers_to_axi_interconnect_RVALID),
        .M_AXI_wdata(m08_couplers_to_axi_interconnect_WDATA),
        .M_AXI_wready(m08_couplers_to_axi_interconnect_WREADY),
        .M_AXI_wstrb(m08_couplers_to_axi_interconnect_WSTRB),
        .M_AXI_wvalid(m08_couplers_to_axi_interconnect_WVALID),
        .S_ACLK(axi_interconnect_ACLK_net),
        .S_ARESETN(axi_interconnect_ARESETN_net),
        .S_AXI_araddr(xbar_to_m08_couplers_ARADDR),
        .S_AXI_arprot(xbar_to_m08_couplers_ARPROT),
        .S_AXI_arready(xbar_to_m08_couplers_ARREADY),
        .S_AXI_arvalid(xbar_to_m08_couplers_ARVALID),
        .S_AXI_awaddr(xbar_to_m08_couplers_AWADDR),
        .S_AXI_awprot(xbar_to_m08_couplers_AWPROT),
        .S_AXI_awready(xbar_to_m08_couplers_AWREADY),
        .S_AXI_awvalid(xbar_to_m08_couplers_AWVALID),
        .S_AXI_bready(xbar_to_m08_couplers_BREADY),
        .S_AXI_bresp(xbar_to_m08_couplers_BRESP),
        .S_AXI_bvalid(xbar_to_m08_couplers_BVALID),
        .S_AXI_rdata(xbar_to_m08_couplers_RDATA),
        .S_AXI_rready(xbar_to_m08_couplers_RREADY),
        .S_AXI_rresp(xbar_to_m08_couplers_RRESP),
        .S_AXI_rvalid(xbar_to_m08_couplers_RVALID),
        .S_AXI_wdata(xbar_to_m08_couplers_WDATA),
        .S_AXI_wready(xbar_to_m08_couplers_WREADY),
        .S_AXI_wstrb(xbar_to_m08_couplers_WSTRB),
        .S_AXI_wvalid(xbar_to_m08_couplers_WVALID));
  s00_couplers_imp_ULFDNX s00_couplers
       (.M_ACLK(axi_interconnect_ACLK_net),
        .M_ARESETN(axi_interconnect_ARESETN_net),
        .M_AXI_araddr(s00_couplers_to_xbar_ARADDR),
        .M_AXI_arprot(s00_couplers_to_xbar_ARPROT),
        .M_AXI_arready(s00_couplers_to_xbar_ARREADY),
        .M_AXI_arvalid(s00_couplers_to_xbar_ARVALID),
        .M_AXI_awaddr(s00_couplers_to_xbar_AWADDR),
        .M_AXI_awprot(s00_couplers_to_xbar_AWPROT),
        .M_AXI_awready(s00_couplers_to_xbar_AWREADY),
        .M_AXI_awvalid(s00_couplers_to_xbar_AWVALID),
        .M_AXI_bready(s00_couplers_to_xbar_BREADY),
        .M_AXI_bresp(s00_couplers_to_xbar_BRESP),
        .M_AXI_bvalid(s00_couplers_to_xbar_BVALID),
        .M_AXI_rdata(s00_couplers_to_xbar_RDATA),
        .M_AXI_rready(s00_couplers_to_xbar_RREADY),
        .M_AXI_rresp(s00_couplers_to_xbar_RRESP),
        .M_AXI_rvalid(s00_couplers_to_xbar_RVALID),
        .M_AXI_wdata(s00_couplers_to_xbar_WDATA),
        .M_AXI_wready(s00_couplers_to_xbar_WREADY),
        .M_AXI_wstrb(s00_couplers_to_xbar_WSTRB),
        .M_AXI_wvalid(s00_couplers_to_xbar_WVALID),
        .S_ACLK(S00_ACLK_1),
        .S_ARESETN(S00_ARESETN_1),
        .S_AXI_araddr(axi_interconnect_to_s00_couplers_ARADDR),
        .S_AXI_arprot(axi_interconnect_to_s00_couplers_ARPROT),
        .S_AXI_arready(axi_interconnect_to_s00_couplers_ARREADY),
        .S_AXI_arvalid(axi_interconnect_to_s00_couplers_ARVALID),
        .S_AXI_awaddr(axi_interconnect_to_s00_couplers_AWADDR),
        .S_AXI_awprot(axi_interconnect_to_s00_couplers_AWPROT),
        .S_AXI_awready(axi_interconnect_to_s00_couplers_AWREADY),
        .S_AXI_awvalid(axi_interconnect_to_s00_couplers_AWVALID),
        .S_AXI_bready(axi_interconnect_to_s00_couplers_BREADY),
        .S_AXI_bresp(axi_interconnect_to_s00_couplers_BRESP),
        .S_AXI_bvalid(axi_interconnect_to_s00_couplers_BVALID),
        .S_AXI_rdata(axi_interconnect_to_s00_couplers_RDATA),
        .S_AXI_rready(axi_interconnect_to_s00_couplers_RREADY),
        .S_AXI_rresp(axi_interconnect_to_s00_couplers_RRESP),
        .S_AXI_rvalid(axi_interconnect_to_s00_couplers_RVALID),
        .S_AXI_wdata(axi_interconnect_to_s00_couplers_WDATA),
        .S_AXI_wready(axi_interconnect_to_s00_couplers_WREADY),
        .S_AXI_wstrb(axi_interconnect_to_s00_couplers_WSTRB),
        .S_AXI_wvalid(axi_interconnect_to_s00_couplers_WVALID));
  exdes_xbar_1 xbar
       (.aclk(axi_interconnect_ACLK_net),
        .aresetn(axi_interconnect_ARESETN_net),
        .m_axi_araddr({xbar_to_m08_couplers_ARADDR,xbar_to_m07_couplers_ARADDR,xbar_to_m06_couplers_ARADDR,xbar_to_m05_couplers_ARADDR,xbar_to_m04_couplers_ARADDR,xbar_to_m03_couplers_ARADDR,xbar_to_m02_couplers_ARADDR,xbar_to_m01_couplers_ARADDR,xbar_to_m00_couplers_ARADDR}),
        .m_axi_arprot({xbar_to_m08_couplers_ARPROT,NLW_xbar_m_axi_arprot_UNCONNECTED[23:21],xbar_to_m06_couplers_ARPROT,xbar_to_m05_couplers_ARPROT,NLW_xbar_m_axi_arprot_UNCONNECTED[14:9],xbar_to_m02_couplers_ARPROT,xbar_to_m01_couplers_ARPROT,xbar_to_m00_couplers_ARPROT}),
        .m_axi_arready({xbar_to_m08_couplers_ARREADY,xbar_to_m07_couplers_ARREADY,xbar_to_m06_couplers_ARREADY,xbar_to_m05_couplers_ARREADY,xbar_to_m04_couplers_ARREADY,xbar_to_m03_couplers_ARREADY,xbar_to_m02_couplers_ARREADY,xbar_to_m01_couplers_ARREADY,xbar_to_m00_couplers_ARREADY}),
        .m_axi_arvalid({xbar_to_m08_couplers_ARVALID,xbar_to_m07_couplers_ARVALID,xbar_to_m06_couplers_ARVALID,xbar_to_m05_couplers_ARVALID,xbar_to_m04_couplers_ARVALID,xbar_to_m03_couplers_ARVALID,xbar_to_m02_couplers_ARVALID,xbar_to_m01_couplers_ARVALID,xbar_to_m00_couplers_ARVALID}),
        .m_axi_awaddr({xbar_to_m08_couplers_AWADDR,xbar_to_m07_couplers_AWADDR,xbar_to_m06_couplers_AWADDR,xbar_to_m05_couplers_AWADDR,xbar_to_m04_couplers_AWADDR,xbar_to_m03_couplers_AWADDR,xbar_to_m02_couplers_AWADDR,xbar_to_m01_couplers_AWADDR,xbar_to_m00_couplers_AWADDR}),
        .m_axi_awprot({xbar_to_m08_couplers_AWPROT,NLW_xbar_m_axi_awprot_UNCONNECTED[23:21],xbar_to_m06_couplers_AWPROT,xbar_to_m05_couplers_AWPROT,NLW_xbar_m_axi_awprot_UNCONNECTED[14:9],xbar_to_m02_couplers_AWPROT,xbar_to_m01_couplers_AWPROT,xbar_to_m00_couplers_AWPROT}),
        .m_axi_awready({xbar_to_m08_couplers_AWREADY,xbar_to_m07_couplers_AWREADY,xbar_to_m06_couplers_AWREADY,xbar_to_m05_couplers_AWREADY,xbar_to_m04_couplers_AWREADY,xbar_to_m03_couplers_AWREADY,xbar_to_m02_couplers_AWREADY,xbar_to_m01_couplers_AWREADY,xbar_to_m00_couplers_AWREADY}),
        .m_axi_awvalid({xbar_to_m08_couplers_AWVALID,xbar_to_m07_couplers_AWVALID,xbar_to_m06_couplers_AWVALID,xbar_to_m05_couplers_AWVALID,xbar_to_m04_couplers_AWVALID,xbar_to_m03_couplers_AWVALID,xbar_to_m02_couplers_AWVALID,xbar_to_m01_couplers_AWVALID,xbar_to_m00_couplers_AWVALID}),
        .m_axi_bready({xbar_to_m08_couplers_BREADY,xbar_to_m07_couplers_BREADY,xbar_to_m06_couplers_BREADY,xbar_to_m05_couplers_BREADY,xbar_to_m04_couplers_BREADY,xbar_to_m03_couplers_BREADY,xbar_to_m02_couplers_BREADY,xbar_to_m01_couplers_BREADY,xbar_to_m00_couplers_BREADY}),
        .m_axi_bresp({xbar_to_m08_couplers_BRESP,xbar_to_m07_couplers_BRESP,xbar_to_m06_couplers_BRESP,xbar_to_m05_couplers_BRESP,xbar_to_m04_couplers_BRESP,xbar_to_m03_couplers_BRESP,xbar_to_m02_couplers_BRESP,xbar_to_m01_couplers_BRESP,xbar_to_m00_couplers_BRESP}),
        .m_axi_bvalid({xbar_to_m08_couplers_BVALID,xbar_to_m07_couplers_BVALID,xbar_to_m06_couplers_BVALID,xbar_to_m05_couplers_BVALID,xbar_to_m04_couplers_BVALID,xbar_to_m03_couplers_BVALID,xbar_to_m02_couplers_BVALID,xbar_to_m01_couplers_BVALID,xbar_to_m00_couplers_BVALID}),
        .m_axi_rdata({xbar_to_m08_couplers_RDATA,xbar_to_m07_couplers_RDATA,xbar_to_m06_couplers_RDATA,xbar_to_m05_couplers_RDATA,xbar_to_m04_couplers_RDATA,xbar_to_m03_couplers_RDATA,xbar_to_m02_couplers_RDATA,xbar_to_m01_couplers_RDATA,xbar_to_m00_couplers_RDATA}),
        .m_axi_rready({xbar_to_m08_couplers_RREADY,xbar_to_m07_couplers_RREADY,xbar_to_m06_couplers_RREADY,xbar_to_m05_couplers_RREADY,xbar_to_m04_couplers_RREADY,xbar_to_m03_couplers_RREADY,xbar_to_m02_couplers_RREADY,xbar_to_m01_couplers_RREADY,xbar_to_m00_couplers_RREADY}),
        .m_axi_rresp({xbar_to_m08_couplers_RRESP,xbar_to_m07_couplers_RRESP,xbar_to_m06_couplers_RRESP,xbar_to_m05_couplers_RRESP,xbar_to_m04_couplers_RRESP,xbar_to_m03_couplers_RRESP,xbar_to_m02_couplers_RRESP,xbar_to_m01_couplers_RRESP,xbar_to_m00_couplers_RRESP}),
        .m_axi_rvalid({xbar_to_m08_couplers_RVALID,xbar_to_m07_couplers_RVALID,xbar_to_m06_couplers_RVALID,xbar_to_m05_couplers_RVALID,xbar_to_m04_couplers_RVALID,xbar_to_m03_couplers_RVALID,xbar_to_m02_couplers_RVALID,xbar_to_m01_couplers_RVALID,xbar_to_m00_couplers_RVALID}),
        .m_axi_wdata({xbar_to_m08_couplers_WDATA,xbar_to_m07_couplers_WDATA,xbar_to_m06_couplers_WDATA,xbar_to_m05_couplers_WDATA,xbar_to_m04_couplers_WDATA,xbar_to_m03_couplers_WDATA,xbar_to_m02_couplers_WDATA,xbar_to_m01_couplers_WDATA,xbar_to_m00_couplers_WDATA}),
        .m_axi_wready({xbar_to_m08_couplers_WREADY,xbar_to_m07_couplers_WREADY,xbar_to_m06_couplers_WREADY,xbar_to_m05_couplers_WREADY,xbar_to_m04_couplers_WREADY,xbar_to_m03_couplers_WREADY,xbar_to_m02_couplers_WREADY,xbar_to_m01_couplers_WREADY,xbar_to_m00_couplers_WREADY}),
        .m_axi_wstrb({xbar_to_m08_couplers_WSTRB,xbar_to_m07_couplers_WSTRB,xbar_to_m06_couplers_WSTRB,xbar_to_m05_couplers_WSTRB,xbar_to_m04_couplers_WSTRB,xbar_to_m03_couplers_WSTRB,xbar_to_m02_couplers_WSTRB,xbar_to_m01_couplers_WSTRB,xbar_to_m00_couplers_WSTRB}),
        .m_axi_wvalid({xbar_to_m08_couplers_WVALID,xbar_to_m07_couplers_WVALID,xbar_to_m06_couplers_WVALID,xbar_to_m05_couplers_WVALID,xbar_to_m04_couplers_WVALID,xbar_to_m03_couplers_WVALID,xbar_to_m02_couplers_WVALID,xbar_to_m01_couplers_WVALID,xbar_to_m00_couplers_WVALID}),
        .s_axi_araddr(s00_couplers_to_xbar_ARADDR),
        .s_axi_arprot(s00_couplers_to_xbar_ARPROT),
        .s_axi_arready(s00_couplers_to_xbar_ARREADY),
        .s_axi_arvalid(s00_couplers_to_xbar_ARVALID),
        .s_axi_awaddr(s00_couplers_to_xbar_AWADDR),
        .s_axi_awprot(s00_couplers_to_xbar_AWPROT),
        .s_axi_awready(s00_couplers_to_xbar_AWREADY),
        .s_axi_awvalid(s00_couplers_to_xbar_AWVALID),
        .s_axi_bready(s00_couplers_to_xbar_BREADY),
        .s_axi_bresp(s00_couplers_to_xbar_BRESP),
        .s_axi_bvalid(s00_couplers_to_xbar_BVALID),
        .s_axi_rdata(s00_couplers_to_xbar_RDATA),
        .s_axi_rready(s00_couplers_to_xbar_RREADY),
        .s_axi_rresp(s00_couplers_to_xbar_RRESP),
        .s_axi_rvalid(s00_couplers_to_xbar_RVALID),
        .s_axi_wdata(s00_couplers_to_xbar_WDATA),
        .s_axi_wready(s00_couplers_to_xbar_WREADY),
        .s_axi_wstrb(s00_couplers_to_xbar_WSTRB),
        .s_axi_wvalid(s00_couplers_to_xbar_WVALID));
endmodule

module m00_couplers_imp_5QVHE
   (M_ACLK,
    M_ARESETN,
    M_AXI_araddr,
    M_AXI_arprot,
    M_AXI_arready,
    M_AXI_arvalid,
    M_AXI_awaddr,
    M_AXI_awprot,
    M_AXI_awready,
    M_AXI_awvalid,
    M_AXI_bready,
    M_AXI_bresp,
    M_AXI_bvalid,
    M_AXI_rdata,
    M_AXI_rready,
    M_AXI_rresp,
    M_AXI_rvalid,
    M_AXI_wdata,
    M_AXI_wready,
    M_AXI_wstrb,
    M_AXI_wvalid,
    S_ACLK,
    S_ARESETN,
    S_AXI_araddr,
    S_AXI_arprot,
    S_AXI_arready,
    S_AXI_arvalid,
    S_AXI_awaddr,
    S_AXI_awprot,
    S_AXI_awready,
    S_AXI_awvalid,
    S_AXI_bready,
    S_AXI_bresp,
    S_AXI_bvalid,
    S_AXI_rdata,
    S_AXI_rready,
    S_AXI_rresp,
    S_AXI_rvalid,
    S_AXI_wdata,
    S_AXI_wready,
    S_AXI_wstrb,
    S_AXI_wvalid);
  input M_ACLK;
  input M_ARESETN;
  output [31:0]M_AXI_araddr;
  output [2:0]M_AXI_arprot;
  input M_AXI_arready;
  output M_AXI_arvalid;
  output [31:0]M_AXI_awaddr;
  output [2:0]M_AXI_awprot;
  input M_AXI_awready;
  output M_AXI_awvalid;
  output M_AXI_bready;
  input [1:0]M_AXI_bresp;
  input M_AXI_bvalid;
  input [31:0]M_AXI_rdata;
  output M_AXI_rready;
  input [1:0]M_AXI_rresp;
  input M_AXI_rvalid;
  output [31:0]M_AXI_wdata;
  input M_AXI_wready;
  output [3:0]M_AXI_wstrb;
  output M_AXI_wvalid;
  input S_ACLK;
  input S_ARESETN;
  input [31:0]S_AXI_araddr;
  input [2:0]S_AXI_arprot;
  output S_AXI_arready;
  input S_AXI_arvalid;
  input [31:0]S_AXI_awaddr;
  input [2:0]S_AXI_awprot;
  output S_AXI_awready;
  input S_AXI_awvalid;
  input S_AXI_bready;
  output [1:0]S_AXI_bresp;
  output S_AXI_bvalid;
  output [31:0]S_AXI_rdata;
  input S_AXI_rready;
  output [1:0]S_AXI_rresp;
  output S_AXI_rvalid;
  input [31:0]S_AXI_wdata;
  output S_AXI_wready;
  input [3:0]S_AXI_wstrb;
  input S_AXI_wvalid;

  wire [31:0]m00_couplers_to_m00_couplers_ARADDR;
  wire [2:0]m00_couplers_to_m00_couplers_ARPROT;
  wire m00_couplers_to_m00_couplers_ARREADY;
  wire m00_couplers_to_m00_couplers_ARVALID;
  wire [31:0]m00_couplers_to_m00_couplers_AWADDR;
  wire [2:0]m00_couplers_to_m00_couplers_AWPROT;
  wire m00_couplers_to_m00_couplers_AWREADY;
  wire m00_couplers_to_m00_couplers_AWVALID;
  wire m00_couplers_to_m00_couplers_BREADY;
  wire [1:0]m00_couplers_to_m00_couplers_BRESP;
  wire m00_couplers_to_m00_couplers_BVALID;
  wire [31:0]m00_couplers_to_m00_couplers_RDATA;
  wire m00_couplers_to_m00_couplers_RREADY;
  wire [1:0]m00_couplers_to_m00_couplers_RRESP;
  wire m00_couplers_to_m00_couplers_RVALID;
  wire [31:0]m00_couplers_to_m00_couplers_WDATA;
  wire m00_couplers_to_m00_couplers_WREADY;
  wire [3:0]m00_couplers_to_m00_couplers_WSTRB;
  wire m00_couplers_to_m00_couplers_WVALID;

  assign M_AXI_araddr[31:0] = m00_couplers_to_m00_couplers_ARADDR;
  assign M_AXI_arprot[2:0] = m00_couplers_to_m00_couplers_ARPROT;
  assign M_AXI_arvalid = m00_couplers_to_m00_couplers_ARVALID;
  assign M_AXI_awaddr[31:0] = m00_couplers_to_m00_couplers_AWADDR;
  assign M_AXI_awprot[2:0] = m00_couplers_to_m00_couplers_AWPROT;
  assign M_AXI_awvalid = m00_couplers_to_m00_couplers_AWVALID;
  assign M_AXI_bready = m00_couplers_to_m00_couplers_BREADY;
  assign M_AXI_rready = m00_couplers_to_m00_couplers_RREADY;
  assign M_AXI_wdata[31:0] = m00_couplers_to_m00_couplers_WDATA;
  assign M_AXI_wstrb[3:0] = m00_couplers_to_m00_couplers_WSTRB;
  assign M_AXI_wvalid = m00_couplers_to_m00_couplers_WVALID;
  assign S_AXI_arready = m00_couplers_to_m00_couplers_ARREADY;
  assign S_AXI_awready = m00_couplers_to_m00_couplers_AWREADY;
  assign S_AXI_bresp[1:0] = m00_couplers_to_m00_couplers_BRESP;
  assign S_AXI_bvalid = m00_couplers_to_m00_couplers_BVALID;
  assign S_AXI_rdata[31:0] = m00_couplers_to_m00_couplers_RDATA;
  assign S_AXI_rresp[1:0] = m00_couplers_to_m00_couplers_RRESP;
  assign S_AXI_rvalid = m00_couplers_to_m00_couplers_RVALID;
  assign S_AXI_wready = m00_couplers_to_m00_couplers_WREADY;
  assign m00_couplers_to_m00_couplers_ARADDR = S_AXI_araddr[31:0];
  assign m00_couplers_to_m00_couplers_ARPROT = S_AXI_arprot[2:0];
  assign m00_couplers_to_m00_couplers_ARREADY = M_AXI_arready;
  assign m00_couplers_to_m00_couplers_ARVALID = S_AXI_arvalid;
  assign m00_couplers_to_m00_couplers_AWADDR = S_AXI_awaddr[31:0];
  assign m00_couplers_to_m00_couplers_AWPROT = S_AXI_awprot[2:0];
  assign m00_couplers_to_m00_couplers_AWREADY = M_AXI_awready;
  assign m00_couplers_to_m00_couplers_AWVALID = S_AXI_awvalid;
  assign m00_couplers_to_m00_couplers_BREADY = S_AXI_bready;
  assign m00_couplers_to_m00_couplers_BRESP = M_AXI_bresp[1:0];
  assign m00_couplers_to_m00_couplers_BVALID = M_AXI_bvalid;
  assign m00_couplers_to_m00_couplers_RDATA = M_AXI_rdata[31:0];
  assign m00_couplers_to_m00_couplers_RREADY = S_AXI_rready;
  assign m00_couplers_to_m00_couplers_RRESP = M_AXI_rresp[1:0];
  assign m00_couplers_to_m00_couplers_RVALID = M_AXI_rvalid;
  assign m00_couplers_to_m00_couplers_WDATA = S_AXI_wdata[31:0];
  assign m00_couplers_to_m00_couplers_WREADY = M_AXI_wready;
  assign m00_couplers_to_m00_couplers_WSTRB = S_AXI_wstrb[3:0];
  assign m00_couplers_to_m00_couplers_WVALID = S_AXI_wvalid;
endmodule

module m00_couplers_imp_FLAFIE
   (M_ACLK,
    M_ARESETN,
    M_AXI_araddr,
    M_AXI_arprot,
    M_AXI_arready,
    M_AXI_arvalid,
    M_AXI_awaddr,
    M_AXI_awprot,
    M_AXI_awready,
    M_AXI_awvalid,
    M_AXI_bready,
    M_AXI_bresp,
    M_AXI_bvalid,
    M_AXI_rdata,
    M_AXI_rready,
    M_AXI_rresp,
    M_AXI_rvalid,
    M_AXI_wdata,
    M_AXI_wready,
    M_AXI_wstrb,
    M_AXI_wvalid,
    S_ACLK,
    S_ARESETN,
    S_AXI_araddr,
    S_AXI_arprot,
    S_AXI_arready,
    S_AXI_arvalid,
    S_AXI_awaddr,
    S_AXI_awprot,
    S_AXI_awready,
    S_AXI_awvalid,
    S_AXI_bready,
    S_AXI_bresp,
    S_AXI_bvalid,
    S_AXI_rdata,
    S_AXI_rready,
    S_AXI_rresp,
    S_AXI_rvalid,
    S_AXI_wdata,
    S_AXI_wready,
    S_AXI_wstrb,
    S_AXI_wvalid);
  input M_ACLK;
  input M_ARESETN;
  output [31:0]M_AXI_araddr;
  output [2:0]M_AXI_arprot;
  input [0:0]M_AXI_arready;
  output [0:0]M_AXI_arvalid;
  output [31:0]M_AXI_awaddr;
  output [2:0]M_AXI_awprot;
  input [0:0]M_AXI_awready;
  output [0:0]M_AXI_awvalid;
  output [0:0]M_AXI_bready;
  input [1:0]M_AXI_bresp;
  input [0:0]M_AXI_bvalid;
  input [31:0]M_AXI_rdata;
  output [0:0]M_AXI_rready;
  input [1:0]M_AXI_rresp;
  input [0:0]M_AXI_rvalid;
  output [31:0]M_AXI_wdata;
  input [0:0]M_AXI_wready;
  output [3:0]M_AXI_wstrb;
  output [0:0]M_AXI_wvalid;
  input S_ACLK;
  input S_ARESETN;
  input [31:0]S_AXI_araddr;
  input [2:0]S_AXI_arprot;
  output [0:0]S_AXI_arready;
  input [0:0]S_AXI_arvalid;
  input [31:0]S_AXI_awaddr;
  input [2:0]S_AXI_awprot;
  output [0:0]S_AXI_awready;
  input [0:0]S_AXI_awvalid;
  input [0:0]S_AXI_bready;
  output [1:0]S_AXI_bresp;
  output [0:0]S_AXI_bvalid;
  output [31:0]S_AXI_rdata;
  input [0:0]S_AXI_rready;
  output [1:0]S_AXI_rresp;
  output [0:0]S_AXI_rvalid;
  input [31:0]S_AXI_wdata;
  output [0:0]S_AXI_wready;
  input [3:0]S_AXI_wstrb;
  input [0:0]S_AXI_wvalid;

  wire [31:0]m00_couplers_to_m00_couplers_ARADDR;
  wire [2:0]m00_couplers_to_m00_couplers_ARPROT;
  wire [0:0]m00_couplers_to_m00_couplers_ARREADY;
  wire [0:0]m00_couplers_to_m00_couplers_ARVALID;
  wire [31:0]m00_couplers_to_m00_couplers_AWADDR;
  wire [2:0]m00_couplers_to_m00_couplers_AWPROT;
  wire [0:0]m00_couplers_to_m00_couplers_AWREADY;
  wire [0:0]m00_couplers_to_m00_couplers_AWVALID;
  wire [0:0]m00_couplers_to_m00_couplers_BREADY;
  wire [1:0]m00_couplers_to_m00_couplers_BRESP;
  wire [0:0]m00_couplers_to_m00_couplers_BVALID;
  wire [31:0]m00_couplers_to_m00_couplers_RDATA;
  wire [0:0]m00_couplers_to_m00_couplers_RREADY;
  wire [1:0]m00_couplers_to_m00_couplers_RRESP;
  wire [0:0]m00_couplers_to_m00_couplers_RVALID;
  wire [31:0]m00_couplers_to_m00_couplers_WDATA;
  wire [0:0]m00_couplers_to_m00_couplers_WREADY;
  wire [3:0]m00_couplers_to_m00_couplers_WSTRB;
  wire [0:0]m00_couplers_to_m00_couplers_WVALID;

  assign M_AXI_araddr[31:0] = m00_couplers_to_m00_couplers_ARADDR;
  assign M_AXI_arprot[2:0] = m00_couplers_to_m00_couplers_ARPROT;
  assign M_AXI_arvalid[0] = m00_couplers_to_m00_couplers_ARVALID;
  assign M_AXI_awaddr[31:0] = m00_couplers_to_m00_couplers_AWADDR;
  assign M_AXI_awprot[2:0] = m00_couplers_to_m00_couplers_AWPROT;
  assign M_AXI_awvalid[0] = m00_couplers_to_m00_couplers_AWVALID;
  assign M_AXI_bready[0] = m00_couplers_to_m00_couplers_BREADY;
  assign M_AXI_rready[0] = m00_couplers_to_m00_couplers_RREADY;
  assign M_AXI_wdata[31:0] = m00_couplers_to_m00_couplers_WDATA;
  assign M_AXI_wstrb[3:0] = m00_couplers_to_m00_couplers_WSTRB;
  assign M_AXI_wvalid[0] = m00_couplers_to_m00_couplers_WVALID;
  assign S_AXI_arready[0] = m00_couplers_to_m00_couplers_ARREADY;
  assign S_AXI_awready[0] = m00_couplers_to_m00_couplers_AWREADY;
  assign S_AXI_bresp[1:0] = m00_couplers_to_m00_couplers_BRESP;
  assign S_AXI_bvalid[0] = m00_couplers_to_m00_couplers_BVALID;
  assign S_AXI_rdata[31:0] = m00_couplers_to_m00_couplers_RDATA;
  assign S_AXI_rresp[1:0] = m00_couplers_to_m00_couplers_RRESP;
  assign S_AXI_rvalid[0] = m00_couplers_to_m00_couplers_RVALID;
  assign S_AXI_wready[0] = m00_couplers_to_m00_couplers_WREADY;
  assign m00_couplers_to_m00_couplers_ARADDR = S_AXI_araddr[31:0];
  assign m00_couplers_to_m00_couplers_ARPROT = S_AXI_arprot[2:0];
  assign m00_couplers_to_m00_couplers_ARREADY = M_AXI_arready[0];
  assign m00_couplers_to_m00_couplers_ARVALID = S_AXI_arvalid[0];
  assign m00_couplers_to_m00_couplers_AWADDR = S_AXI_awaddr[31:0];
  assign m00_couplers_to_m00_couplers_AWPROT = S_AXI_awprot[2:0];
  assign m00_couplers_to_m00_couplers_AWREADY = M_AXI_awready[0];
  assign m00_couplers_to_m00_couplers_AWVALID = S_AXI_awvalid[0];
  assign m00_couplers_to_m00_couplers_BREADY = S_AXI_bready[0];
  assign m00_couplers_to_m00_couplers_BRESP = M_AXI_bresp[1:0];
  assign m00_couplers_to_m00_couplers_BVALID = M_AXI_bvalid[0];
  assign m00_couplers_to_m00_couplers_RDATA = M_AXI_rdata[31:0];
  assign m00_couplers_to_m00_couplers_RREADY = S_AXI_rready[0];
  assign m00_couplers_to_m00_couplers_RRESP = M_AXI_rresp[1:0];
  assign m00_couplers_to_m00_couplers_RVALID = M_AXI_rvalid[0];
  assign m00_couplers_to_m00_couplers_WDATA = S_AXI_wdata[31:0];
  assign m00_couplers_to_m00_couplers_WREADY = M_AXI_wready[0];
  assign m00_couplers_to_m00_couplers_WSTRB = S_AXI_wstrb[3:0];
  assign m00_couplers_to_m00_couplers_WVALID = S_AXI_wvalid[0];
endmodule

module m01_couplers_imp_100GMI6
   (M_ACLK,
    M_ARESETN,
    M_AXI_araddr,
    M_AXI_arprot,
    M_AXI_arready,
    M_AXI_arvalid,
    M_AXI_awaddr,
    M_AXI_awprot,
    M_AXI_awready,
    M_AXI_awvalid,
    M_AXI_bready,
    M_AXI_bresp,
    M_AXI_bvalid,
    M_AXI_rdata,
    M_AXI_rready,
    M_AXI_rresp,
    M_AXI_rvalid,
    M_AXI_wdata,
    M_AXI_wready,
    M_AXI_wstrb,
    M_AXI_wvalid,
    S_ACLK,
    S_ARESETN,
    S_AXI_araddr,
    S_AXI_arprot,
    S_AXI_arready,
    S_AXI_arvalid,
    S_AXI_awaddr,
    S_AXI_awprot,
    S_AXI_awready,
    S_AXI_awvalid,
    S_AXI_bready,
    S_AXI_bresp,
    S_AXI_bvalid,
    S_AXI_rdata,
    S_AXI_rready,
    S_AXI_rresp,
    S_AXI_rvalid,
    S_AXI_wdata,
    S_AXI_wready,
    S_AXI_wstrb,
    S_AXI_wvalid);
  input M_ACLK;
  input M_ARESETN;
  output [31:0]M_AXI_araddr;
  output [2:0]M_AXI_arprot;
  input [0:0]M_AXI_arready;
  output [0:0]M_AXI_arvalid;
  output [31:0]M_AXI_awaddr;
  output [2:0]M_AXI_awprot;
  input [0:0]M_AXI_awready;
  output [0:0]M_AXI_awvalid;
  output [0:0]M_AXI_bready;
  input [1:0]M_AXI_bresp;
  input [0:0]M_AXI_bvalid;
  input [31:0]M_AXI_rdata;
  output [0:0]M_AXI_rready;
  input [1:0]M_AXI_rresp;
  input [0:0]M_AXI_rvalid;
  output [31:0]M_AXI_wdata;
  input [0:0]M_AXI_wready;
  output [3:0]M_AXI_wstrb;
  output [0:0]M_AXI_wvalid;
  input S_ACLK;
  input S_ARESETN;
  input [31:0]S_AXI_araddr;
  input [2:0]S_AXI_arprot;
  output [0:0]S_AXI_arready;
  input [0:0]S_AXI_arvalid;
  input [31:0]S_AXI_awaddr;
  input [2:0]S_AXI_awprot;
  output [0:0]S_AXI_awready;
  input [0:0]S_AXI_awvalid;
  input [0:0]S_AXI_bready;
  output [1:0]S_AXI_bresp;
  output [0:0]S_AXI_bvalid;
  output [31:0]S_AXI_rdata;
  input [0:0]S_AXI_rready;
  output [1:0]S_AXI_rresp;
  output [0:0]S_AXI_rvalid;
  input [31:0]S_AXI_wdata;
  output [0:0]S_AXI_wready;
  input [3:0]S_AXI_wstrb;
  input [0:0]S_AXI_wvalid;

  wire [31:0]m01_couplers_to_m01_couplers_ARADDR;
  wire [2:0]m01_couplers_to_m01_couplers_ARPROT;
  wire [0:0]m01_couplers_to_m01_couplers_ARREADY;
  wire [0:0]m01_couplers_to_m01_couplers_ARVALID;
  wire [31:0]m01_couplers_to_m01_couplers_AWADDR;
  wire [2:0]m01_couplers_to_m01_couplers_AWPROT;
  wire [0:0]m01_couplers_to_m01_couplers_AWREADY;
  wire [0:0]m01_couplers_to_m01_couplers_AWVALID;
  wire [0:0]m01_couplers_to_m01_couplers_BREADY;
  wire [1:0]m01_couplers_to_m01_couplers_BRESP;
  wire [0:0]m01_couplers_to_m01_couplers_BVALID;
  wire [31:0]m01_couplers_to_m01_couplers_RDATA;
  wire [0:0]m01_couplers_to_m01_couplers_RREADY;
  wire [1:0]m01_couplers_to_m01_couplers_RRESP;
  wire [0:0]m01_couplers_to_m01_couplers_RVALID;
  wire [31:0]m01_couplers_to_m01_couplers_WDATA;
  wire [0:0]m01_couplers_to_m01_couplers_WREADY;
  wire [3:0]m01_couplers_to_m01_couplers_WSTRB;
  wire [0:0]m01_couplers_to_m01_couplers_WVALID;

  assign M_AXI_araddr[31:0] = m01_couplers_to_m01_couplers_ARADDR;
  assign M_AXI_arprot[2:0] = m01_couplers_to_m01_couplers_ARPROT;
  assign M_AXI_arvalid[0] = m01_couplers_to_m01_couplers_ARVALID;
  assign M_AXI_awaddr[31:0] = m01_couplers_to_m01_couplers_AWADDR;
  assign M_AXI_awprot[2:0] = m01_couplers_to_m01_couplers_AWPROT;
  assign M_AXI_awvalid[0] = m01_couplers_to_m01_couplers_AWVALID;
  assign M_AXI_bready[0] = m01_couplers_to_m01_couplers_BREADY;
  assign M_AXI_rready[0] = m01_couplers_to_m01_couplers_RREADY;
  assign M_AXI_wdata[31:0] = m01_couplers_to_m01_couplers_WDATA;
  assign M_AXI_wstrb[3:0] = m01_couplers_to_m01_couplers_WSTRB;
  assign M_AXI_wvalid[0] = m01_couplers_to_m01_couplers_WVALID;
  assign S_AXI_arready[0] = m01_couplers_to_m01_couplers_ARREADY;
  assign S_AXI_awready[0] = m01_couplers_to_m01_couplers_AWREADY;
  assign S_AXI_bresp[1:0] = m01_couplers_to_m01_couplers_BRESP;
  assign S_AXI_bvalid[0] = m01_couplers_to_m01_couplers_BVALID;
  assign S_AXI_rdata[31:0] = m01_couplers_to_m01_couplers_RDATA;
  assign S_AXI_rresp[1:0] = m01_couplers_to_m01_couplers_RRESP;
  assign S_AXI_rvalid[0] = m01_couplers_to_m01_couplers_RVALID;
  assign S_AXI_wready[0] = m01_couplers_to_m01_couplers_WREADY;
  assign m01_couplers_to_m01_couplers_ARADDR = S_AXI_araddr[31:0];
  assign m01_couplers_to_m01_couplers_ARPROT = S_AXI_arprot[2:0];
  assign m01_couplers_to_m01_couplers_ARREADY = M_AXI_arready[0];
  assign m01_couplers_to_m01_couplers_ARVALID = S_AXI_arvalid[0];
  assign m01_couplers_to_m01_couplers_AWADDR = S_AXI_awaddr[31:0];
  assign m01_couplers_to_m01_couplers_AWPROT = S_AXI_awprot[2:0];
  assign m01_couplers_to_m01_couplers_AWREADY = M_AXI_awready[0];
  assign m01_couplers_to_m01_couplers_AWVALID = S_AXI_awvalid[0];
  assign m01_couplers_to_m01_couplers_BREADY = S_AXI_bready[0];
  assign m01_couplers_to_m01_couplers_BRESP = M_AXI_bresp[1:0];
  assign m01_couplers_to_m01_couplers_BVALID = M_AXI_bvalid[0];
  assign m01_couplers_to_m01_couplers_RDATA = M_AXI_rdata[31:0];
  assign m01_couplers_to_m01_couplers_RREADY = S_AXI_rready[0];
  assign m01_couplers_to_m01_couplers_RRESP = M_AXI_rresp[1:0];
  assign m01_couplers_to_m01_couplers_RVALID = M_AXI_rvalid[0];
  assign m01_couplers_to_m01_couplers_WDATA = S_AXI_wdata[31:0];
  assign m01_couplers_to_m01_couplers_WREADY = M_AXI_wready[0];
  assign m01_couplers_to_m01_couplers_WSTRB = S_AXI_wstrb[3:0];
  assign m01_couplers_to_m01_couplers_WVALID = S_AXI_wvalid[0];
endmodule

module m01_couplers_imp_1FFZTVU
   (M_ACLK,
    M_ARESETN,
    M_AXI_araddr,
    M_AXI_arready,
    M_AXI_arvalid,
    M_AXI_awaddr,
    M_AXI_awready,
    M_AXI_awvalid,
    M_AXI_bready,
    M_AXI_bresp,
    M_AXI_bvalid,
    M_AXI_rdata,
    M_AXI_rready,
    M_AXI_rresp,
    M_AXI_rvalid,
    M_AXI_wdata,
    M_AXI_wready,
    M_AXI_wstrb,
    M_AXI_wvalid,
    S_ACLK,
    S_ARESETN,
    S_AXI_araddr,
    S_AXI_arready,
    S_AXI_arvalid,
    S_AXI_awaddr,
    S_AXI_awready,
    S_AXI_awvalid,
    S_AXI_bready,
    S_AXI_bresp,
    S_AXI_bvalid,
    S_AXI_rdata,
    S_AXI_rready,
    S_AXI_rresp,
    S_AXI_rvalid,
    S_AXI_wdata,
    S_AXI_wready,
    S_AXI_wstrb,
    S_AXI_wvalid);
  input M_ACLK;
  input M_ARESETN;
  output [31:0]M_AXI_araddr;
  input M_AXI_arready;
  output M_AXI_arvalid;
  output [31:0]M_AXI_awaddr;
  input M_AXI_awready;
  output M_AXI_awvalid;
  output M_AXI_bready;
  input [1:0]M_AXI_bresp;
  input M_AXI_bvalid;
  input [31:0]M_AXI_rdata;
  output M_AXI_rready;
  input [1:0]M_AXI_rresp;
  input M_AXI_rvalid;
  output [31:0]M_AXI_wdata;
  input M_AXI_wready;
  output [3:0]M_AXI_wstrb;
  output M_AXI_wvalid;
  input S_ACLK;
  input S_ARESETN;
  input [31:0]S_AXI_araddr;
  output S_AXI_arready;
  input S_AXI_arvalid;
  input [31:0]S_AXI_awaddr;
  output S_AXI_awready;
  input S_AXI_awvalid;
  input S_AXI_bready;
  output [1:0]S_AXI_bresp;
  output S_AXI_bvalid;
  output [31:0]S_AXI_rdata;
  input S_AXI_rready;
  output [1:0]S_AXI_rresp;
  output S_AXI_rvalid;
  input [31:0]S_AXI_wdata;
  output S_AXI_wready;
  input [3:0]S_AXI_wstrb;
  input S_AXI_wvalid;

  wire [31:0]m01_couplers_to_m01_couplers_ARADDR;
  wire m01_couplers_to_m01_couplers_ARREADY;
  wire m01_couplers_to_m01_couplers_ARVALID;
  wire [31:0]m01_couplers_to_m01_couplers_AWADDR;
  wire m01_couplers_to_m01_couplers_AWREADY;
  wire m01_couplers_to_m01_couplers_AWVALID;
  wire m01_couplers_to_m01_couplers_BREADY;
  wire [1:0]m01_couplers_to_m01_couplers_BRESP;
  wire m01_couplers_to_m01_couplers_BVALID;
  wire [31:0]m01_couplers_to_m01_couplers_RDATA;
  wire m01_couplers_to_m01_couplers_RREADY;
  wire [1:0]m01_couplers_to_m01_couplers_RRESP;
  wire m01_couplers_to_m01_couplers_RVALID;
  wire [31:0]m01_couplers_to_m01_couplers_WDATA;
  wire m01_couplers_to_m01_couplers_WREADY;
  wire [3:0]m01_couplers_to_m01_couplers_WSTRB;
  wire m01_couplers_to_m01_couplers_WVALID;

  assign M_AXI_araddr[31:0] = m01_couplers_to_m01_couplers_ARADDR;
  assign M_AXI_arvalid = m01_couplers_to_m01_couplers_ARVALID;
  assign M_AXI_awaddr[31:0] = m01_couplers_to_m01_couplers_AWADDR;
  assign M_AXI_awvalid = m01_couplers_to_m01_couplers_AWVALID;
  assign M_AXI_bready = m01_couplers_to_m01_couplers_BREADY;
  assign M_AXI_rready = m01_couplers_to_m01_couplers_RREADY;
  assign M_AXI_wdata[31:0] = m01_couplers_to_m01_couplers_WDATA;
  assign M_AXI_wstrb[3:0] = m01_couplers_to_m01_couplers_WSTRB;
  assign M_AXI_wvalid = m01_couplers_to_m01_couplers_WVALID;
  assign S_AXI_arready = m01_couplers_to_m01_couplers_ARREADY;
  assign S_AXI_awready = m01_couplers_to_m01_couplers_AWREADY;
  assign S_AXI_bresp[1:0] = m01_couplers_to_m01_couplers_BRESP;
  assign S_AXI_bvalid = m01_couplers_to_m01_couplers_BVALID;
  assign S_AXI_rdata[31:0] = m01_couplers_to_m01_couplers_RDATA;
  assign S_AXI_rresp[1:0] = m01_couplers_to_m01_couplers_RRESP;
  assign S_AXI_rvalid = m01_couplers_to_m01_couplers_RVALID;
  assign S_AXI_wready = m01_couplers_to_m01_couplers_WREADY;
  assign m01_couplers_to_m01_couplers_ARADDR = S_AXI_araddr[31:0];
  assign m01_couplers_to_m01_couplers_ARREADY = M_AXI_arready;
  assign m01_couplers_to_m01_couplers_ARVALID = S_AXI_arvalid;
  assign m01_couplers_to_m01_couplers_AWADDR = S_AXI_awaddr[31:0];
  assign m01_couplers_to_m01_couplers_AWREADY = M_AXI_awready;
  assign m01_couplers_to_m01_couplers_AWVALID = S_AXI_awvalid;
  assign m01_couplers_to_m01_couplers_BREADY = S_AXI_bready;
  assign m01_couplers_to_m01_couplers_BRESP = M_AXI_bresp[1:0];
  assign m01_couplers_to_m01_couplers_BVALID = M_AXI_bvalid;
  assign m01_couplers_to_m01_couplers_RDATA = M_AXI_rdata[31:0];
  assign m01_couplers_to_m01_couplers_RREADY = S_AXI_rready;
  assign m01_couplers_to_m01_couplers_RRESP = M_AXI_rresp[1:0];
  assign m01_couplers_to_m01_couplers_RVALID = M_AXI_rvalid;
  assign m01_couplers_to_m01_couplers_WDATA = S_AXI_wdata[31:0];
  assign m01_couplers_to_m01_couplers_WREADY = M_AXI_wready;
  assign m01_couplers_to_m01_couplers_WSTRB = S_AXI_wstrb[3:0];
  assign m01_couplers_to_m01_couplers_WVALID = S_AXI_wvalid;
endmodule

module m02_couplers_imp_145JDEF
   (M_ACLK,
    M_ARESETN,
    M_AXI_araddr,
    M_AXI_arprot,
    M_AXI_arready,
    M_AXI_arvalid,
    M_AXI_awaddr,
    M_AXI_awprot,
    M_AXI_awready,
    M_AXI_awvalid,
    M_AXI_bready,
    M_AXI_bresp,
    M_AXI_bvalid,
    M_AXI_rdata,
    M_AXI_rready,
    M_AXI_rresp,
    M_AXI_rvalid,
    M_AXI_wdata,
    M_AXI_wready,
    M_AXI_wstrb,
    M_AXI_wvalid,
    S_ACLK,
    S_ARESETN,
    S_AXI_araddr,
    S_AXI_arprot,
    S_AXI_arready,
    S_AXI_arvalid,
    S_AXI_awaddr,
    S_AXI_awprot,
    S_AXI_awready,
    S_AXI_awvalid,
    S_AXI_bready,
    S_AXI_bresp,
    S_AXI_bvalid,
    S_AXI_rdata,
    S_AXI_rready,
    S_AXI_rresp,
    S_AXI_rvalid,
    S_AXI_wdata,
    S_AXI_wready,
    S_AXI_wstrb,
    S_AXI_wvalid);
  input M_ACLK;
  input M_ARESETN;
  output [31:0]M_AXI_araddr;
  output [2:0]M_AXI_arprot;
  input [0:0]M_AXI_arready;
  output [0:0]M_AXI_arvalid;
  output [31:0]M_AXI_awaddr;
  output [2:0]M_AXI_awprot;
  input [0:0]M_AXI_awready;
  output [0:0]M_AXI_awvalid;
  output [0:0]M_AXI_bready;
  input [1:0]M_AXI_bresp;
  input [0:0]M_AXI_bvalid;
  input [31:0]M_AXI_rdata;
  output [0:0]M_AXI_rready;
  input [1:0]M_AXI_rresp;
  input [0:0]M_AXI_rvalid;
  output [31:0]M_AXI_wdata;
  input [0:0]M_AXI_wready;
  output [3:0]M_AXI_wstrb;
  output [0:0]M_AXI_wvalid;
  input S_ACLK;
  input S_ARESETN;
  input [31:0]S_AXI_araddr;
  input [2:0]S_AXI_arprot;
  output [0:0]S_AXI_arready;
  input [0:0]S_AXI_arvalid;
  input [31:0]S_AXI_awaddr;
  input [2:0]S_AXI_awprot;
  output [0:0]S_AXI_awready;
  input [0:0]S_AXI_awvalid;
  input [0:0]S_AXI_bready;
  output [1:0]S_AXI_bresp;
  output [0:0]S_AXI_bvalid;
  output [31:0]S_AXI_rdata;
  input [0:0]S_AXI_rready;
  output [1:0]S_AXI_rresp;
  output [0:0]S_AXI_rvalid;
  input [31:0]S_AXI_wdata;
  output [0:0]S_AXI_wready;
  input [3:0]S_AXI_wstrb;
  input [0:0]S_AXI_wvalid;

  wire [31:0]m02_couplers_to_m02_couplers_ARADDR;
  wire [2:0]m02_couplers_to_m02_couplers_ARPROT;
  wire [0:0]m02_couplers_to_m02_couplers_ARREADY;
  wire [0:0]m02_couplers_to_m02_couplers_ARVALID;
  wire [31:0]m02_couplers_to_m02_couplers_AWADDR;
  wire [2:0]m02_couplers_to_m02_couplers_AWPROT;
  wire [0:0]m02_couplers_to_m02_couplers_AWREADY;
  wire [0:0]m02_couplers_to_m02_couplers_AWVALID;
  wire [0:0]m02_couplers_to_m02_couplers_BREADY;
  wire [1:0]m02_couplers_to_m02_couplers_BRESP;
  wire [0:0]m02_couplers_to_m02_couplers_BVALID;
  wire [31:0]m02_couplers_to_m02_couplers_RDATA;
  wire [0:0]m02_couplers_to_m02_couplers_RREADY;
  wire [1:0]m02_couplers_to_m02_couplers_RRESP;
  wire [0:0]m02_couplers_to_m02_couplers_RVALID;
  wire [31:0]m02_couplers_to_m02_couplers_WDATA;
  wire [0:0]m02_couplers_to_m02_couplers_WREADY;
  wire [3:0]m02_couplers_to_m02_couplers_WSTRB;
  wire [0:0]m02_couplers_to_m02_couplers_WVALID;

  assign M_AXI_araddr[31:0] = m02_couplers_to_m02_couplers_ARADDR;
  assign M_AXI_arprot[2:0] = m02_couplers_to_m02_couplers_ARPROT;
  assign M_AXI_arvalid[0] = m02_couplers_to_m02_couplers_ARVALID;
  assign M_AXI_awaddr[31:0] = m02_couplers_to_m02_couplers_AWADDR;
  assign M_AXI_awprot[2:0] = m02_couplers_to_m02_couplers_AWPROT;
  assign M_AXI_awvalid[0] = m02_couplers_to_m02_couplers_AWVALID;
  assign M_AXI_bready[0] = m02_couplers_to_m02_couplers_BREADY;
  assign M_AXI_rready[0] = m02_couplers_to_m02_couplers_RREADY;
  assign M_AXI_wdata[31:0] = m02_couplers_to_m02_couplers_WDATA;
  assign M_AXI_wstrb[3:0] = m02_couplers_to_m02_couplers_WSTRB;
  assign M_AXI_wvalid[0] = m02_couplers_to_m02_couplers_WVALID;
  assign S_AXI_arready[0] = m02_couplers_to_m02_couplers_ARREADY;
  assign S_AXI_awready[0] = m02_couplers_to_m02_couplers_AWREADY;
  assign S_AXI_bresp[1:0] = m02_couplers_to_m02_couplers_BRESP;
  assign S_AXI_bvalid[0] = m02_couplers_to_m02_couplers_BVALID;
  assign S_AXI_rdata[31:0] = m02_couplers_to_m02_couplers_RDATA;
  assign S_AXI_rresp[1:0] = m02_couplers_to_m02_couplers_RRESP;
  assign S_AXI_rvalid[0] = m02_couplers_to_m02_couplers_RVALID;
  assign S_AXI_wready[0] = m02_couplers_to_m02_couplers_WREADY;
  assign m02_couplers_to_m02_couplers_ARADDR = S_AXI_araddr[31:0];
  assign m02_couplers_to_m02_couplers_ARPROT = S_AXI_arprot[2:0];
  assign m02_couplers_to_m02_couplers_ARREADY = M_AXI_arready[0];
  assign m02_couplers_to_m02_couplers_ARVALID = S_AXI_arvalid[0];
  assign m02_couplers_to_m02_couplers_AWADDR = S_AXI_awaddr[31:0];
  assign m02_couplers_to_m02_couplers_AWPROT = S_AXI_awprot[2:0];
  assign m02_couplers_to_m02_couplers_AWREADY = M_AXI_awready[0];
  assign m02_couplers_to_m02_couplers_AWVALID = S_AXI_awvalid[0];
  assign m02_couplers_to_m02_couplers_BREADY = S_AXI_bready[0];
  assign m02_couplers_to_m02_couplers_BRESP = M_AXI_bresp[1:0];
  assign m02_couplers_to_m02_couplers_BVALID = M_AXI_bvalid[0];
  assign m02_couplers_to_m02_couplers_RDATA = M_AXI_rdata[31:0];
  assign m02_couplers_to_m02_couplers_RREADY = S_AXI_rready[0];
  assign m02_couplers_to_m02_couplers_RRESP = M_AXI_rresp[1:0];
  assign m02_couplers_to_m02_couplers_RVALID = M_AXI_rvalid[0];
  assign m02_couplers_to_m02_couplers_WDATA = S_AXI_wdata[31:0];
  assign m02_couplers_to_m02_couplers_WREADY = M_AXI_wready[0];
  assign m02_couplers_to_m02_couplers_WSTRB = S_AXI_wstrb[3:0];
  assign m02_couplers_to_m02_couplers_WVALID = S_AXI_wvalid[0];
endmodule

module m02_couplers_imp_1AMYN3N
   (M_ACLK,
    M_ARESETN,
    M_AXI_araddr,
    M_AXI_arready,
    M_AXI_arvalid,
    M_AXI_awaddr,
    M_AXI_awready,
    M_AXI_awvalid,
    M_AXI_bready,
    M_AXI_bresp,
    M_AXI_bvalid,
    M_AXI_rdata,
    M_AXI_rready,
    M_AXI_rresp,
    M_AXI_rvalid,
    M_AXI_wdata,
    M_AXI_wready,
    M_AXI_wstrb,
    M_AXI_wvalid,
    S_ACLK,
    S_ARESETN,
    S_AXI_araddr,
    S_AXI_arready,
    S_AXI_arvalid,
    S_AXI_awaddr,
    S_AXI_awready,
    S_AXI_awvalid,
    S_AXI_bready,
    S_AXI_bresp,
    S_AXI_bvalid,
    S_AXI_rdata,
    S_AXI_rready,
    S_AXI_rresp,
    S_AXI_rvalid,
    S_AXI_wdata,
    S_AXI_wready,
    S_AXI_wstrb,
    S_AXI_wvalid);
  input M_ACLK;
  input M_ARESETN;
  output [31:0]M_AXI_araddr;
  input M_AXI_arready;
  output M_AXI_arvalid;
  output [31:0]M_AXI_awaddr;
  input M_AXI_awready;
  output M_AXI_awvalid;
  output M_AXI_bready;
  input [1:0]M_AXI_bresp;
  input M_AXI_bvalid;
  input [31:0]M_AXI_rdata;
  output M_AXI_rready;
  input [1:0]M_AXI_rresp;
  input M_AXI_rvalid;
  output [31:0]M_AXI_wdata;
  input M_AXI_wready;
  output [3:0]M_AXI_wstrb;
  output M_AXI_wvalid;
  input S_ACLK;
  input S_ARESETN;
  input [31:0]S_AXI_araddr;
  output S_AXI_arready;
  input S_AXI_arvalid;
  input [31:0]S_AXI_awaddr;
  output S_AXI_awready;
  input S_AXI_awvalid;
  input S_AXI_bready;
  output [1:0]S_AXI_bresp;
  output S_AXI_bvalid;
  output [31:0]S_AXI_rdata;
  input S_AXI_rready;
  output [1:0]S_AXI_rresp;
  output S_AXI_rvalid;
  input [31:0]S_AXI_wdata;
  output S_AXI_wready;
  input [3:0]S_AXI_wstrb;
  input S_AXI_wvalid;

  wire [31:0]m02_couplers_to_m02_couplers_ARADDR;
  wire m02_couplers_to_m02_couplers_ARREADY;
  wire m02_couplers_to_m02_couplers_ARVALID;
  wire [31:0]m02_couplers_to_m02_couplers_AWADDR;
  wire m02_couplers_to_m02_couplers_AWREADY;
  wire m02_couplers_to_m02_couplers_AWVALID;
  wire m02_couplers_to_m02_couplers_BREADY;
  wire [1:0]m02_couplers_to_m02_couplers_BRESP;
  wire m02_couplers_to_m02_couplers_BVALID;
  wire [31:0]m02_couplers_to_m02_couplers_RDATA;
  wire m02_couplers_to_m02_couplers_RREADY;
  wire [1:0]m02_couplers_to_m02_couplers_RRESP;
  wire m02_couplers_to_m02_couplers_RVALID;
  wire [31:0]m02_couplers_to_m02_couplers_WDATA;
  wire m02_couplers_to_m02_couplers_WREADY;
  wire [3:0]m02_couplers_to_m02_couplers_WSTRB;
  wire m02_couplers_to_m02_couplers_WVALID;

  assign M_AXI_araddr[31:0] = m02_couplers_to_m02_couplers_ARADDR;
  assign M_AXI_arvalid = m02_couplers_to_m02_couplers_ARVALID;
  assign M_AXI_awaddr[31:0] = m02_couplers_to_m02_couplers_AWADDR;
  assign M_AXI_awvalid = m02_couplers_to_m02_couplers_AWVALID;
  assign M_AXI_bready = m02_couplers_to_m02_couplers_BREADY;
  assign M_AXI_rready = m02_couplers_to_m02_couplers_RREADY;
  assign M_AXI_wdata[31:0] = m02_couplers_to_m02_couplers_WDATA;
  assign M_AXI_wstrb[3:0] = m02_couplers_to_m02_couplers_WSTRB;
  assign M_AXI_wvalid = m02_couplers_to_m02_couplers_WVALID;
  assign S_AXI_arready = m02_couplers_to_m02_couplers_ARREADY;
  assign S_AXI_awready = m02_couplers_to_m02_couplers_AWREADY;
  assign S_AXI_bresp[1:0] = m02_couplers_to_m02_couplers_BRESP;
  assign S_AXI_bvalid = m02_couplers_to_m02_couplers_BVALID;
  assign S_AXI_rdata[31:0] = m02_couplers_to_m02_couplers_RDATA;
  assign S_AXI_rresp[1:0] = m02_couplers_to_m02_couplers_RRESP;
  assign S_AXI_rvalid = m02_couplers_to_m02_couplers_RVALID;
  assign S_AXI_wready = m02_couplers_to_m02_couplers_WREADY;
  assign m02_couplers_to_m02_couplers_ARADDR = S_AXI_araddr[31:0];
  assign m02_couplers_to_m02_couplers_ARREADY = M_AXI_arready;
  assign m02_couplers_to_m02_couplers_ARVALID = S_AXI_arvalid;
  assign m02_couplers_to_m02_couplers_AWADDR = S_AXI_awaddr[31:0];
  assign m02_couplers_to_m02_couplers_AWREADY = M_AXI_awready;
  assign m02_couplers_to_m02_couplers_AWVALID = S_AXI_awvalid;
  assign m02_couplers_to_m02_couplers_BREADY = S_AXI_bready;
  assign m02_couplers_to_m02_couplers_BRESP = M_AXI_bresp[1:0];
  assign m02_couplers_to_m02_couplers_BVALID = M_AXI_bvalid;
  assign m02_couplers_to_m02_couplers_RDATA = M_AXI_rdata[31:0];
  assign m02_couplers_to_m02_couplers_RREADY = S_AXI_rready;
  assign m02_couplers_to_m02_couplers_RRESP = M_AXI_rresp[1:0];
  assign m02_couplers_to_m02_couplers_RVALID = M_AXI_rvalid;
  assign m02_couplers_to_m02_couplers_WDATA = S_AXI_wdata[31:0];
  assign m02_couplers_to_m02_couplers_WREADY = M_AXI_wready;
  assign m02_couplers_to_m02_couplers_WSTRB = S_AXI_wstrb[3:0];
  assign m02_couplers_to_m02_couplers_WVALID = S_AXI_wvalid;
endmodule

module m03_couplers_imp_BGIKJJ
   (M_ACLK,
    M_ARESETN,
    M_AXI_araddr,
    M_AXI_arready,
    M_AXI_arvalid,
    M_AXI_awaddr,
    M_AXI_awready,
    M_AXI_awvalid,
    M_AXI_bready,
    M_AXI_bresp,
    M_AXI_bvalid,
    M_AXI_rdata,
    M_AXI_rready,
    M_AXI_rresp,
    M_AXI_rvalid,
    M_AXI_wdata,
    M_AXI_wready,
    M_AXI_wstrb,
    M_AXI_wvalid,
    S_ACLK,
    S_ARESETN,
    S_AXI_araddr,
    S_AXI_arready,
    S_AXI_arvalid,
    S_AXI_awaddr,
    S_AXI_awready,
    S_AXI_awvalid,
    S_AXI_bready,
    S_AXI_bresp,
    S_AXI_bvalid,
    S_AXI_rdata,
    S_AXI_rready,
    S_AXI_rresp,
    S_AXI_rvalid,
    S_AXI_wdata,
    S_AXI_wready,
    S_AXI_wstrb,
    S_AXI_wvalid);
  input M_ACLK;
  input M_ARESETN;
  output [31:0]M_AXI_araddr;
  input M_AXI_arready;
  output M_AXI_arvalid;
  output [31:0]M_AXI_awaddr;
  input M_AXI_awready;
  output M_AXI_awvalid;
  output M_AXI_bready;
  input [1:0]M_AXI_bresp;
  input M_AXI_bvalid;
  input [31:0]M_AXI_rdata;
  output M_AXI_rready;
  input [1:0]M_AXI_rresp;
  input M_AXI_rvalid;
  output [31:0]M_AXI_wdata;
  input M_AXI_wready;
  output [3:0]M_AXI_wstrb;
  output M_AXI_wvalid;
  input S_ACLK;
  input S_ARESETN;
  input [31:0]S_AXI_araddr;
  output S_AXI_arready;
  input S_AXI_arvalid;
  input [31:0]S_AXI_awaddr;
  output S_AXI_awready;
  input S_AXI_awvalid;
  input S_AXI_bready;
  output [1:0]S_AXI_bresp;
  output S_AXI_bvalid;
  output [31:0]S_AXI_rdata;
  input S_AXI_rready;
  output [1:0]S_AXI_rresp;
  output S_AXI_rvalid;
  input [31:0]S_AXI_wdata;
  output S_AXI_wready;
  input [3:0]S_AXI_wstrb;
  input S_AXI_wvalid;

  wire [31:0]m03_couplers_to_m03_couplers_ARADDR;
  wire m03_couplers_to_m03_couplers_ARREADY;
  wire m03_couplers_to_m03_couplers_ARVALID;
  wire [31:0]m03_couplers_to_m03_couplers_AWADDR;
  wire m03_couplers_to_m03_couplers_AWREADY;
  wire m03_couplers_to_m03_couplers_AWVALID;
  wire m03_couplers_to_m03_couplers_BREADY;
  wire [1:0]m03_couplers_to_m03_couplers_BRESP;
  wire m03_couplers_to_m03_couplers_BVALID;
  wire [31:0]m03_couplers_to_m03_couplers_RDATA;
  wire m03_couplers_to_m03_couplers_RREADY;
  wire [1:0]m03_couplers_to_m03_couplers_RRESP;
  wire m03_couplers_to_m03_couplers_RVALID;
  wire [31:0]m03_couplers_to_m03_couplers_WDATA;
  wire m03_couplers_to_m03_couplers_WREADY;
  wire [3:0]m03_couplers_to_m03_couplers_WSTRB;
  wire m03_couplers_to_m03_couplers_WVALID;

  assign M_AXI_araddr[31:0] = m03_couplers_to_m03_couplers_ARADDR;
  assign M_AXI_arvalid = m03_couplers_to_m03_couplers_ARVALID;
  assign M_AXI_awaddr[31:0] = m03_couplers_to_m03_couplers_AWADDR;
  assign M_AXI_awvalid = m03_couplers_to_m03_couplers_AWVALID;
  assign M_AXI_bready = m03_couplers_to_m03_couplers_BREADY;
  assign M_AXI_rready = m03_couplers_to_m03_couplers_RREADY;
  assign M_AXI_wdata[31:0] = m03_couplers_to_m03_couplers_WDATA;
  assign M_AXI_wstrb[3:0] = m03_couplers_to_m03_couplers_WSTRB;
  assign M_AXI_wvalid = m03_couplers_to_m03_couplers_WVALID;
  assign S_AXI_arready = m03_couplers_to_m03_couplers_ARREADY;
  assign S_AXI_awready = m03_couplers_to_m03_couplers_AWREADY;
  assign S_AXI_bresp[1:0] = m03_couplers_to_m03_couplers_BRESP;
  assign S_AXI_bvalid = m03_couplers_to_m03_couplers_BVALID;
  assign S_AXI_rdata[31:0] = m03_couplers_to_m03_couplers_RDATA;
  assign S_AXI_rresp[1:0] = m03_couplers_to_m03_couplers_RRESP;
  assign S_AXI_rvalid = m03_couplers_to_m03_couplers_RVALID;
  assign S_AXI_wready = m03_couplers_to_m03_couplers_WREADY;
  assign m03_couplers_to_m03_couplers_ARADDR = S_AXI_araddr[31:0];
  assign m03_couplers_to_m03_couplers_ARREADY = M_AXI_arready;
  assign m03_couplers_to_m03_couplers_ARVALID = S_AXI_arvalid;
  assign m03_couplers_to_m03_couplers_AWADDR = S_AXI_awaddr[31:0];
  assign m03_couplers_to_m03_couplers_AWREADY = M_AXI_awready;
  assign m03_couplers_to_m03_couplers_AWVALID = S_AXI_awvalid;
  assign m03_couplers_to_m03_couplers_BREADY = S_AXI_bready;
  assign m03_couplers_to_m03_couplers_BRESP = M_AXI_bresp[1:0];
  assign m03_couplers_to_m03_couplers_BVALID = M_AXI_bvalid;
  assign m03_couplers_to_m03_couplers_RDATA = M_AXI_rdata[31:0];
  assign m03_couplers_to_m03_couplers_RREADY = S_AXI_rready;
  assign m03_couplers_to_m03_couplers_RRESP = M_AXI_rresp[1:0];
  assign m03_couplers_to_m03_couplers_RVALID = M_AXI_rvalid;
  assign m03_couplers_to_m03_couplers_WDATA = S_AXI_wdata[31:0];
  assign m03_couplers_to_m03_couplers_WREADY = M_AXI_wready;
  assign m03_couplers_to_m03_couplers_WSTRB = S_AXI_wstrb[3:0];
  assign m03_couplers_to_m03_couplers_WVALID = S_AXI_wvalid;
endmodule

module m04_couplers_imp_1DH0DWL
   (M_ACLK,
    M_ARESETN,
    M_AXI_araddr,
    M_AXI_arready,
    M_AXI_arvalid,
    M_AXI_awaddr,
    M_AXI_awready,
    M_AXI_awvalid,
    M_AXI_bready,
    M_AXI_bresp,
    M_AXI_bvalid,
    M_AXI_rdata,
    M_AXI_rready,
    M_AXI_rresp,
    M_AXI_rvalid,
    M_AXI_wdata,
    M_AXI_wready,
    M_AXI_wstrb,
    M_AXI_wvalid,
    S_ACLK,
    S_ARESETN,
    S_AXI_araddr,
    S_AXI_arready,
    S_AXI_arvalid,
    S_AXI_awaddr,
    S_AXI_awready,
    S_AXI_awvalid,
    S_AXI_bready,
    S_AXI_bresp,
    S_AXI_bvalid,
    S_AXI_rdata,
    S_AXI_rready,
    S_AXI_rresp,
    S_AXI_rvalid,
    S_AXI_wdata,
    S_AXI_wready,
    S_AXI_wstrb,
    S_AXI_wvalid);
  input M_ACLK;
  input M_ARESETN;
  output [31:0]M_AXI_araddr;
  input M_AXI_arready;
  output M_AXI_arvalid;
  output [31:0]M_AXI_awaddr;
  input M_AXI_awready;
  output M_AXI_awvalid;
  output M_AXI_bready;
  input [1:0]M_AXI_bresp;
  input M_AXI_bvalid;
  input [31:0]M_AXI_rdata;
  output M_AXI_rready;
  input [1:0]M_AXI_rresp;
  input M_AXI_rvalid;
  output [31:0]M_AXI_wdata;
  input M_AXI_wready;
  output [3:0]M_AXI_wstrb;
  output M_AXI_wvalid;
  input S_ACLK;
  input S_ARESETN;
  input [31:0]S_AXI_araddr;
  output S_AXI_arready;
  input S_AXI_arvalid;
  input [31:0]S_AXI_awaddr;
  output S_AXI_awready;
  input S_AXI_awvalid;
  input S_AXI_bready;
  output [1:0]S_AXI_bresp;
  output S_AXI_bvalid;
  output [31:0]S_AXI_rdata;
  input S_AXI_rready;
  output [1:0]S_AXI_rresp;
  output S_AXI_rvalid;
  input [31:0]S_AXI_wdata;
  output S_AXI_wready;
  input [3:0]S_AXI_wstrb;
  input S_AXI_wvalid;

  wire [31:0]m04_couplers_to_m04_couplers_ARADDR;
  wire m04_couplers_to_m04_couplers_ARREADY;
  wire m04_couplers_to_m04_couplers_ARVALID;
  wire [31:0]m04_couplers_to_m04_couplers_AWADDR;
  wire m04_couplers_to_m04_couplers_AWREADY;
  wire m04_couplers_to_m04_couplers_AWVALID;
  wire m04_couplers_to_m04_couplers_BREADY;
  wire [1:0]m04_couplers_to_m04_couplers_BRESP;
  wire m04_couplers_to_m04_couplers_BVALID;
  wire [31:0]m04_couplers_to_m04_couplers_RDATA;
  wire m04_couplers_to_m04_couplers_RREADY;
  wire [1:0]m04_couplers_to_m04_couplers_RRESP;
  wire m04_couplers_to_m04_couplers_RVALID;
  wire [31:0]m04_couplers_to_m04_couplers_WDATA;
  wire m04_couplers_to_m04_couplers_WREADY;
  wire [3:0]m04_couplers_to_m04_couplers_WSTRB;
  wire m04_couplers_to_m04_couplers_WVALID;

  assign M_AXI_araddr[31:0] = m04_couplers_to_m04_couplers_ARADDR;
  assign M_AXI_arvalid = m04_couplers_to_m04_couplers_ARVALID;
  assign M_AXI_awaddr[31:0] = m04_couplers_to_m04_couplers_AWADDR;
  assign M_AXI_awvalid = m04_couplers_to_m04_couplers_AWVALID;
  assign M_AXI_bready = m04_couplers_to_m04_couplers_BREADY;
  assign M_AXI_rready = m04_couplers_to_m04_couplers_RREADY;
  assign M_AXI_wdata[31:0] = m04_couplers_to_m04_couplers_WDATA;
  assign M_AXI_wstrb[3:0] = m04_couplers_to_m04_couplers_WSTRB;
  assign M_AXI_wvalid = m04_couplers_to_m04_couplers_WVALID;
  assign S_AXI_arready = m04_couplers_to_m04_couplers_ARREADY;
  assign S_AXI_awready = m04_couplers_to_m04_couplers_AWREADY;
  assign S_AXI_bresp[1:0] = m04_couplers_to_m04_couplers_BRESP;
  assign S_AXI_bvalid = m04_couplers_to_m04_couplers_BVALID;
  assign S_AXI_rdata[31:0] = m04_couplers_to_m04_couplers_RDATA;
  assign S_AXI_rresp[1:0] = m04_couplers_to_m04_couplers_RRESP;
  assign S_AXI_rvalid = m04_couplers_to_m04_couplers_RVALID;
  assign S_AXI_wready = m04_couplers_to_m04_couplers_WREADY;
  assign m04_couplers_to_m04_couplers_ARADDR = S_AXI_araddr[31:0];
  assign m04_couplers_to_m04_couplers_ARREADY = M_AXI_arready;
  assign m04_couplers_to_m04_couplers_ARVALID = S_AXI_arvalid;
  assign m04_couplers_to_m04_couplers_AWADDR = S_AXI_awaddr[31:0];
  assign m04_couplers_to_m04_couplers_AWREADY = M_AXI_awready;
  assign m04_couplers_to_m04_couplers_AWVALID = S_AXI_awvalid;
  assign m04_couplers_to_m04_couplers_BREADY = S_AXI_bready;
  assign m04_couplers_to_m04_couplers_BRESP = M_AXI_bresp[1:0];
  assign m04_couplers_to_m04_couplers_BVALID = M_AXI_bvalid;
  assign m04_couplers_to_m04_couplers_RDATA = M_AXI_rdata[31:0];
  assign m04_couplers_to_m04_couplers_RREADY = S_AXI_rready;
  assign m04_couplers_to_m04_couplers_RRESP = M_AXI_rresp[1:0];
  assign m04_couplers_to_m04_couplers_RVALID = M_AXI_rvalid;
  assign m04_couplers_to_m04_couplers_WDATA = S_AXI_wdata[31:0];
  assign m04_couplers_to_m04_couplers_WREADY = M_AXI_wready;
  assign m04_couplers_to_m04_couplers_WSTRB = S_AXI_wstrb[3:0];
  assign m04_couplers_to_m04_couplers_WVALID = S_AXI_wvalid;
endmodule

module m05_couplers_imp_38ZVYL
   (M_ACLK,
    M_ARESETN,
    M_AXI_araddr,
    M_AXI_arready,
    M_AXI_arvalid,
    M_AXI_awaddr,
    M_AXI_awready,
    M_AXI_awvalid,
    M_AXI_bready,
    M_AXI_bresp,
    M_AXI_bvalid,
    M_AXI_rdata,
    M_AXI_rready,
    M_AXI_rresp,
    M_AXI_rvalid,
    M_AXI_wdata,
    M_AXI_wready,
    M_AXI_wstrb,
    M_AXI_wvalid,
    S_ACLK,
    S_ARESETN,
    S_AXI_araddr,
    S_AXI_arprot,
    S_AXI_arready,
    S_AXI_arvalid,
    S_AXI_awaddr,
    S_AXI_awprot,
    S_AXI_awready,
    S_AXI_awvalid,
    S_AXI_bready,
    S_AXI_bresp,
    S_AXI_bvalid,
    S_AXI_rdata,
    S_AXI_rready,
    S_AXI_rresp,
    S_AXI_rvalid,
    S_AXI_wdata,
    S_AXI_wready,
    S_AXI_wstrb,
    S_AXI_wvalid);
  input M_ACLK;
  input M_ARESETN;
  output [7:0]M_AXI_araddr;
  input M_AXI_arready;
  output M_AXI_arvalid;
  output [7:0]M_AXI_awaddr;
  input M_AXI_awready;
  output M_AXI_awvalid;
  output M_AXI_bready;
  input [1:0]M_AXI_bresp;
  input M_AXI_bvalid;
  input [31:0]M_AXI_rdata;
  output M_AXI_rready;
  input [1:0]M_AXI_rresp;
  input M_AXI_rvalid;
  output [31:0]M_AXI_wdata;
  input M_AXI_wready;
  output [3:0]M_AXI_wstrb;
  output M_AXI_wvalid;
  input S_ACLK;
  input S_ARESETN;
  input [31:0]S_AXI_araddr;
  input [2:0]S_AXI_arprot;
  output S_AXI_arready;
  input S_AXI_arvalid;
  input [31:0]S_AXI_awaddr;
  input [2:0]S_AXI_awprot;
  output S_AXI_awready;
  input S_AXI_awvalid;
  input S_AXI_bready;
  output [1:0]S_AXI_bresp;
  output S_AXI_bvalid;
  output [31:0]S_AXI_rdata;
  input S_AXI_rready;
  output [1:0]S_AXI_rresp;
  output S_AXI_rvalid;
  input [31:0]S_AXI_wdata;
  output S_AXI_wready;
  input [3:0]S_AXI_wstrb;
  input S_AXI_wvalid;

  wire M_ACLK_1;
  wire M_ARESETN_1;
  wire S_ACLK_1;
  wire S_ARESETN_1;
  wire [7:0]auto_cc_to_m05_couplers_ARADDR;
  wire auto_cc_to_m05_couplers_ARREADY;
  wire auto_cc_to_m05_couplers_ARVALID;
  wire [7:0]auto_cc_to_m05_couplers_AWADDR;
  wire auto_cc_to_m05_couplers_AWREADY;
  wire auto_cc_to_m05_couplers_AWVALID;
  wire auto_cc_to_m05_couplers_BREADY;
  wire [1:0]auto_cc_to_m05_couplers_BRESP;
  wire auto_cc_to_m05_couplers_BVALID;
  wire [31:0]auto_cc_to_m05_couplers_RDATA;
  wire auto_cc_to_m05_couplers_RREADY;
  wire [1:0]auto_cc_to_m05_couplers_RRESP;
  wire auto_cc_to_m05_couplers_RVALID;
  wire [31:0]auto_cc_to_m05_couplers_WDATA;
  wire auto_cc_to_m05_couplers_WREADY;
  wire [3:0]auto_cc_to_m05_couplers_WSTRB;
  wire auto_cc_to_m05_couplers_WVALID;
  wire [31:0]m05_couplers_to_auto_cc_ARADDR;
  wire [2:0]m05_couplers_to_auto_cc_ARPROT;
  wire m05_couplers_to_auto_cc_ARREADY;
  wire m05_couplers_to_auto_cc_ARVALID;
  wire [31:0]m05_couplers_to_auto_cc_AWADDR;
  wire [2:0]m05_couplers_to_auto_cc_AWPROT;
  wire m05_couplers_to_auto_cc_AWREADY;
  wire m05_couplers_to_auto_cc_AWVALID;
  wire m05_couplers_to_auto_cc_BREADY;
  wire [1:0]m05_couplers_to_auto_cc_BRESP;
  wire m05_couplers_to_auto_cc_BVALID;
  wire [31:0]m05_couplers_to_auto_cc_RDATA;
  wire m05_couplers_to_auto_cc_RREADY;
  wire [1:0]m05_couplers_to_auto_cc_RRESP;
  wire m05_couplers_to_auto_cc_RVALID;
  wire [31:0]m05_couplers_to_auto_cc_WDATA;
  wire m05_couplers_to_auto_cc_WREADY;
  wire [3:0]m05_couplers_to_auto_cc_WSTRB;
  wire m05_couplers_to_auto_cc_WVALID;

  assign M_ACLK_1 = M_ACLK;
  assign M_ARESETN_1 = M_ARESETN;
  assign M_AXI_araddr[7:0] = auto_cc_to_m05_couplers_ARADDR;
  assign M_AXI_arvalid = auto_cc_to_m05_couplers_ARVALID;
  assign M_AXI_awaddr[7:0] = auto_cc_to_m05_couplers_AWADDR;
  assign M_AXI_awvalid = auto_cc_to_m05_couplers_AWVALID;
  assign M_AXI_bready = auto_cc_to_m05_couplers_BREADY;
  assign M_AXI_rready = auto_cc_to_m05_couplers_RREADY;
  assign M_AXI_wdata[31:0] = auto_cc_to_m05_couplers_WDATA;
  assign M_AXI_wstrb[3:0] = auto_cc_to_m05_couplers_WSTRB;
  assign M_AXI_wvalid = auto_cc_to_m05_couplers_WVALID;
  assign S_ACLK_1 = S_ACLK;
  assign S_ARESETN_1 = S_ARESETN;
  assign S_AXI_arready = m05_couplers_to_auto_cc_ARREADY;
  assign S_AXI_awready = m05_couplers_to_auto_cc_AWREADY;
  assign S_AXI_bresp[1:0] = m05_couplers_to_auto_cc_BRESP;
  assign S_AXI_bvalid = m05_couplers_to_auto_cc_BVALID;
  assign S_AXI_rdata[31:0] = m05_couplers_to_auto_cc_RDATA;
  assign S_AXI_rresp[1:0] = m05_couplers_to_auto_cc_RRESP;
  assign S_AXI_rvalid = m05_couplers_to_auto_cc_RVALID;
  assign S_AXI_wready = m05_couplers_to_auto_cc_WREADY;
  assign auto_cc_to_m05_couplers_ARREADY = M_AXI_arready;
  assign auto_cc_to_m05_couplers_AWREADY = M_AXI_awready;
  assign auto_cc_to_m05_couplers_BRESP = M_AXI_bresp[1:0];
  assign auto_cc_to_m05_couplers_BVALID = M_AXI_bvalid;
  assign auto_cc_to_m05_couplers_RDATA = M_AXI_rdata[31:0];
  assign auto_cc_to_m05_couplers_RRESP = M_AXI_rresp[1:0];
  assign auto_cc_to_m05_couplers_RVALID = M_AXI_rvalid;
  assign auto_cc_to_m05_couplers_WREADY = M_AXI_wready;
  assign m05_couplers_to_auto_cc_ARADDR = S_AXI_araddr[31:0];
  assign m05_couplers_to_auto_cc_ARPROT = S_AXI_arprot[2:0];
  assign m05_couplers_to_auto_cc_ARVALID = S_AXI_arvalid;
  assign m05_couplers_to_auto_cc_AWADDR = S_AXI_awaddr[31:0];
  assign m05_couplers_to_auto_cc_AWPROT = S_AXI_awprot[2:0];
  assign m05_couplers_to_auto_cc_AWVALID = S_AXI_awvalid;
  assign m05_couplers_to_auto_cc_BREADY = S_AXI_bready;
  assign m05_couplers_to_auto_cc_RREADY = S_AXI_rready;
  assign m05_couplers_to_auto_cc_WDATA = S_AXI_wdata[31:0];
  assign m05_couplers_to_auto_cc_WSTRB = S_AXI_wstrb[3:0];
  assign m05_couplers_to_auto_cc_WVALID = S_AXI_wvalid;
  exdes_auto_cc_0 auto_cc
       (.m_axi_aclk(M_ACLK_1),
        .m_axi_araddr(auto_cc_to_m05_couplers_ARADDR),
        .m_axi_aresetn(M_ARESETN_1),
        .m_axi_arready(auto_cc_to_m05_couplers_ARREADY),
        .m_axi_arvalid(auto_cc_to_m05_couplers_ARVALID),
        .m_axi_awaddr(auto_cc_to_m05_couplers_AWADDR),
        .m_axi_awready(auto_cc_to_m05_couplers_AWREADY),
        .m_axi_awvalid(auto_cc_to_m05_couplers_AWVALID),
        .m_axi_bready(auto_cc_to_m05_couplers_BREADY),
        .m_axi_bresp(auto_cc_to_m05_couplers_BRESP),
        .m_axi_bvalid(auto_cc_to_m05_couplers_BVALID),
        .m_axi_rdata(auto_cc_to_m05_couplers_RDATA),
        .m_axi_rready(auto_cc_to_m05_couplers_RREADY),
        .m_axi_rresp(auto_cc_to_m05_couplers_RRESP),
        .m_axi_rvalid(auto_cc_to_m05_couplers_RVALID),
        .m_axi_wdata(auto_cc_to_m05_couplers_WDATA),
        .m_axi_wready(auto_cc_to_m05_couplers_WREADY),
        .m_axi_wstrb(auto_cc_to_m05_couplers_WSTRB),
        .m_axi_wvalid(auto_cc_to_m05_couplers_WVALID),
        .s_axi_aclk(S_ACLK_1),
        .s_axi_araddr(m05_couplers_to_auto_cc_ARADDR[7:0]),
        .s_axi_aresetn(S_ARESETN_1),
        .s_axi_arprot(m05_couplers_to_auto_cc_ARPROT),
        .s_axi_arready(m05_couplers_to_auto_cc_ARREADY),
        .s_axi_arvalid(m05_couplers_to_auto_cc_ARVALID),
        .s_axi_awaddr(m05_couplers_to_auto_cc_AWADDR[7:0]),
        .s_axi_awprot(m05_couplers_to_auto_cc_AWPROT),
        .s_axi_awready(m05_couplers_to_auto_cc_AWREADY),
        .s_axi_awvalid(m05_couplers_to_auto_cc_AWVALID),
        .s_axi_bready(m05_couplers_to_auto_cc_BREADY),
        .s_axi_bresp(m05_couplers_to_auto_cc_BRESP),
        .s_axi_bvalid(m05_couplers_to_auto_cc_BVALID),
        .s_axi_rdata(m05_couplers_to_auto_cc_RDATA),
        .s_axi_rready(m05_couplers_to_auto_cc_RREADY),
        .s_axi_rresp(m05_couplers_to_auto_cc_RRESP),
        .s_axi_rvalid(m05_couplers_to_auto_cc_RVALID),
        .s_axi_wdata(m05_couplers_to_auto_cc_WDATA),
        .s_axi_wready(m05_couplers_to_auto_cc_WREADY),
        .s_axi_wstrb(m05_couplers_to_auto_cc_WSTRB),
        .s_axi_wvalid(m05_couplers_to_auto_cc_WVALID));
endmodule

module m06_couplers_imp_7FNVN8
   (M_ACLK,
    M_ARESETN,
    M_AXI_araddr,
    M_AXI_arprot,
    M_AXI_arready,
    M_AXI_arvalid,
    M_AXI_awaddr,
    M_AXI_awprot,
    M_AXI_awready,
    M_AXI_awvalid,
    M_AXI_bready,
    M_AXI_bresp,
    M_AXI_bvalid,
    M_AXI_rdata,
    M_AXI_rready,
    M_AXI_rresp,
    M_AXI_rvalid,
    M_AXI_wdata,
    M_AXI_wready,
    M_AXI_wstrb,
    M_AXI_wvalid,
    S_ACLK,
    S_ARESETN,
    S_AXI_araddr,
    S_AXI_arprot,
    S_AXI_arready,
    S_AXI_arvalid,
    S_AXI_awaddr,
    S_AXI_awprot,
    S_AXI_awready,
    S_AXI_awvalid,
    S_AXI_bready,
    S_AXI_bresp,
    S_AXI_bvalid,
    S_AXI_rdata,
    S_AXI_rready,
    S_AXI_rresp,
    S_AXI_rvalid,
    S_AXI_wdata,
    S_AXI_wready,
    S_AXI_wstrb,
    S_AXI_wvalid);
  input M_ACLK;
  input M_ARESETN;
  output [31:0]M_AXI_araddr;
  output [2:0]M_AXI_arprot;
  input [0:0]M_AXI_arready;
  output [0:0]M_AXI_arvalid;
  output [31:0]M_AXI_awaddr;
  output [2:0]M_AXI_awprot;
  input [0:0]M_AXI_awready;
  output [0:0]M_AXI_awvalid;
  output [0:0]M_AXI_bready;
  input [1:0]M_AXI_bresp;
  input [0:0]M_AXI_bvalid;
  input [31:0]M_AXI_rdata;
  output [0:0]M_AXI_rready;
  input [1:0]M_AXI_rresp;
  input [0:0]M_AXI_rvalid;
  output [31:0]M_AXI_wdata;
  input [0:0]M_AXI_wready;
  output [3:0]M_AXI_wstrb;
  output [0:0]M_AXI_wvalid;
  input S_ACLK;
  input S_ARESETN;
  input [31:0]S_AXI_araddr;
  input [2:0]S_AXI_arprot;
  output [0:0]S_AXI_arready;
  input [0:0]S_AXI_arvalid;
  input [31:0]S_AXI_awaddr;
  input [2:0]S_AXI_awprot;
  output [0:0]S_AXI_awready;
  input [0:0]S_AXI_awvalid;
  input [0:0]S_AXI_bready;
  output [1:0]S_AXI_bresp;
  output [0:0]S_AXI_bvalid;
  output [31:0]S_AXI_rdata;
  input [0:0]S_AXI_rready;
  output [1:0]S_AXI_rresp;
  output [0:0]S_AXI_rvalid;
  input [31:0]S_AXI_wdata;
  output [0:0]S_AXI_wready;
  input [3:0]S_AXI_wstrb;
  input [0:0]S_AXI_wvalid;

  wire [31:0]m06_couplers_to_m06_couplers_ARADDR;
  wire [2:0]m06_couplers_to_m06_couplers_ARPROT;
  wire [0:0]m06_couplers_to_m06_couplers_ARREADY;
  wire [0:0]m06_couplers_to_m06_couplers_ARVALID;
  wire [31:0]m06_couplers_to_m06_couplers_AWADDR;
  wire [2:0]m06_couplers_to_m06_couplers_AWPROT;
  wire [0:0]m06_couplers_to_m06_couplers_AWREADY;
  wire [0:0]m06_couplers_to_m06_couplers_AWVALID;
  wire [0:0]m06_couplers_to_m06_couplers_BREADY;
  wire [1:0]m06_couplers_to_m06_couplers_BRESP;
  wire [0:0]m06_couplers_to_m06_couplers_BVALID;
  wire [31:0]m06_couplers_to_m06_couplers_RDATA;
  wire [0:0]m06_couplers_to_m06_couplers_RREADY;
  wire [1:0]m06_couplers_to_m06_couplers_RRESP;
  wire [0:0]m06_couplers_to_m06_couplers_RVALID;
  wire [31:0]m06_couplers_to_m06_couplers_WDATA;
  wire [0:0]m06_couplers_to_m06_couplers_WREADY;
  wire [3:0]m06_couplers_to_m06_couplers_WSTRB;
  wire [0:0]m06_couplers_to_m06_couplers_WVALID;

  assign M_AXI_araddr[31:0] = m06_couplers_to_m06_couplers_ARADDR;
  assign M_AXI_arprot[2:0] = m06_couplers_to_m06_couplers_ARPROT;
  assign M_AXI_arvalid[0] = m06_couplers_to_m06_couplers_ARVALID;
  assign M_AXI_awaddr[31:0] = m06_couplers_to_m06_couplers_AWADDR;
  assign M_AXI_awprot[2:0] = m06_couplers_to_m06_couplers_AWPROT;
  assign M_AXI_awvalid[0] = m06_couplers_to_m06_couplers_AWVALID;
  assign M_AXI_bready[0] = m06_couplers_to_m06_couplers_BREADY;
  assign M_AXI_rready[0] = m06_couplers_to_m06_couplers_RREADY;
  assign M_AXI_wdata[31:0] = m06_couplers_to_m06_couplers_WDATA;
  assign M_AXI_wstrb[3:0] = m06_couplers_to_m06_couplers_WSTRB;
  assign M_AXI_wvalid[0] = m06_couplers_to_m06_couplers_WVALID;
  assign S_AXI_arready[0] = m06_couplers_to_m06_couplers_ARREADY;
  assign S_AXI_awready[0] = m06_couplers_to_m06_couplers_AWREADY;
  assign S_AXI_bresp[1:0] = m06_couplers_to_m06_couplers_BRESP;
  assign S_AXI_bvalid[0] = m06_couplers_to_m06_couplers_BVALID;
  assign S_AXI_rdata[31:0] = m06_couplers_to_m06_couplers_RDATA;
  assign S_AXI_rresp[1:0] = m06_couplers_to_m06_couplers_RRESP;
  assign S_AXI_rvalid[0] = m06_couplers_to_m06_couplers_RVALID;
  assign S_AXI_wready[0] = m06_couplers_to_m06_couplers_WREADY;
  assign m06_couplers_to_m06_couplers_ARADDR = S_AXI_araddr[31:0];
  assign m06_couplers_to_m06_couplers_ARPROT = S_AXI_arprot[2:0];
  assign m06_couplers_to_m06_couplers_ARREADY = M_AXI_arready[0];
  assign m06_couplers_to_m06_couplers_ARVALID = S_AXI_arvalid[0];
  assign m06_couplers_to_m06_couplers_AWADDR = S_AXI_awaddr[31:0];
  assign m06_couplers_to_m06_couplers_AWPROT = S_AXI_awprot[2:0];
  assign m06_couplers_to_m06_couplers_AWREADY = M_AXI_awready[0];
  assign m06_couplers_to_m06_couplers_AWVALID = S_AXI_awvalid[0];
  assign m06_couplers_to_m06_couplers_BREADY = S_AXI_bready[0];
  assign m06_couplers_to_m06_couplers_BRESP = M_AXI_bresp[1:0];
  assign m06_couplers_to_m06_couplers_BVALID = M_AXI_bvalid[0];
  assign m06_couplers_to_m06_couplers_RDATA = M_AXI_rdata[31:0];
  assign m06_couplers_to_m06_couplers_RREADY = S_AXI_rready[0];
  assign m06_couplers_to_m06_couplers_RRESP = M_AXI_rresp[1:0];
  assign m06_couplers_to_m06_couplers_RVALID = M_AXI_rvalid[0];
  assign m06_couplers_to_m06_couplers_WDATA = S_AXI_wdata[31:0];
  assign m06_couplers_to_m06_couplers_WREADY = M_AXI_wready[0];
  assign m06_couplers_to_m06_couplers_WSTRB = S_AXI_wstrb[3:0];
  assign m06_couplers_to_m06_couplers_WVALID = S_AXI_wvalid[0];
endmodule

module m07_couplers_imp_19A1ICC
   (M_ACLK,
    M_ARESETN,
    M_AXI_araddr,
    M_AXI_arready,
    M_AXI_arvalid,
    M_AXI_awaddr,
    M_AXI_awready,
    M_AXI_awvalid,
    M_AXI_bready,
    M_AXI_bresp,
    M_AXI_bvalid,
    M_AXI_rdata,
    M_AXI_rready,
    M_AXI_rresp,
    M_AXI_rvalid,
    M_AXI_wdata,
    M_AXI_wready,
    M_AXI_wstrb,
    M_AXI_wvalid,
    S_ACLK,
    S_ARESETN,
    S_AXI_araddr,
    S_AXI_arready,
    S_AXI_arvalid,
    S_AXI_awaddr,
    S_AXI_awready,
    S_AXI_awvalid,
    S_AXI_bready,
    S_AXI_bresp,
    S_AXI_bvalid,
    S_AXI_rdata,
    S_AXI_rready,
    S_AXI_rresp,
    S_AXI_rvalid,
    S_AXI_wdata,
    S_AXI_wready,
    S_AXI_wstrb,
    S_AXI_wvalid);
  input M_ACLK;
  input M_ARESETN;
  output [31:0]M_AXI_araddr;
  input M_AXI_arready;
  output M_AXI_arvalid;
  output [31:0]M_AXI_awaddr;
  input M_AXI_awready;
  output M_AXI_awvalid;
  output M_AXI_bready;
  input [1:0]M_AXI_bresp;
  input M_AXI_bvalid;
  input [31:0]M_AXI_rdata;
  output M_AXI_rready;
  input [1:0]M_AXI_rresp;
  input M_AXI_rvalid;
  output [31:0]M_AXI_wdata;
  input M_AXI_wready;
  output [3:0]M_AXI_wstrb;
  output M_AXI_wvalid;
  input S_ACLK;
  input S_ARESETN;
  input [31:0]S_AXI_araddr;
  output S_AXI_arready;
  input S_AXI_arvalid;
  input [31:0]S_AXI_awaddr;
  output S_AXI_awready;
  input S_AXI_awvalid;
  input S_AXI_bready;
  output [1:0]S_AXI_bresp;
  output S_AXI_bvalid;
  output [31:0]S_AXI_rdata;
  input S_AXI_rready;
  output [1:0]S_AXI_rresp;
  output S_AXI_rvalid;
  input [31:0]S_AXI_wdata;
  output S_AXI_wready;
  input [3:0]S_AXI_wstrb;
  input S_AXI_wvalid;

  wire [31:0]m07_couplers_to_m07_couplers_ARADDR;
  wire m07_couplers_to_m07_couplers_ARREADY;
  wire m07_couplers_to_m07_couplers_ARVALID;
  wire [31:0]m07_couplers_to_m07_couplers_AWADDR;
  wire m07_couplers_to_m07_couplers_AWREADY;
  wire m07_couplers_to_m07_couplers_AWVALID;
  wire m07_couplers_to_m07_couplers_BREADY;
  wire [1:0]m07_couplers_to_m07_couplers_BRESP;
  wire m07_couplers_to_m07_couplers_BVALID;
  wire [31:0]m07_couplers_to_m07_couplers_RDATA;
  wire m07_couplers_to_m07_couplers_RREADY;
  wire [1:0]m07_couplers_to_m07_couplers_RRESP;
  wire m07_couplers_to_m07_couplers_RVALID;
  wire [31:0]m07_couplers_to_m07_couplers_WDATA;
  wire m07_couplers_to_m07_couplers_WREADY;
  wire [3:0]m07_couplers_to_m07_couplers_WSTRB;
  wire m07_couplers_to_m07_couplers_WVALID;

  assign M_AXI_araddr[31:0] = m07_couplers_to_m07_couplers_ARADDR;
  assign M_AXI_arvalid = m07_couplers_to_m07_couplers_ARVALID;
  assign M_AXI_awaddr[31:0] = m07_couplers_to_m07_couplers_AWADDR;
  assign M_AXI_awvalid = m07_couplers_to_m07_couplers_AWVALID;
  assign M_AXI_bready = m07_couplers_to_m07_couplers_BREADY;
  assign M_AXI_rready = m07_couplers_to_m07_couplers_RREADY;
  assign M_AXI_wdata[31:0] = m07_couplers_to_m07_couplers_WDATA;
  assign M_AXI_wstrb[3:0] = m07_couplers_to_m07_couplers_WSTRB;
  assign M_AXI_wvalid = m07_couplers_to_m07_couplers_WVALID;
  assign S_AXI_arready = m07_couplers_to_m07_couplers_ARREADY;
  assign S_AXI_awready = m07_couplers_to_m07_couplers_AWREADY;
  assign S_AXI_bresp[1:0] = m07_couplers_to_m07_couplers_BRESP;
  assign S_AXI_bvalid = m07_couplers_to_m07_couplers_BVALID;
  assign S_AXI_rdata[31:0] = m07_couplers_to_m07_couplers_RDATA;
  assign S_AXI_rresp[1:0] = m07_couplers_to_m07_couplers_RRESP;
  assign S_AXI_rvalid = m07_couplers_to_m07_couplers_RVALID;
  assign S_AXI_wready = m07_couplers_to_m07_couplers_WREADY;
  assign m07_couplers_to_m07_couplers_ARADDR = S_AXI_araddr[31:0];
  assign m07_couplers_to_m07_couplers_ARREADY = M_AXI_arready;
  assign m07_couplers_to_m07_couplers_ARVALID = S_AXI_arvalid;
  assign m07_couplers_to_m07_couplers_AWADDR = S_AXI_awaddr[31:0];
  assign m07_couplers_to_m07_couplers_AWREADY = M_AXI_awready;
  assign m07_couplers_to_m07_couplers_AWVALID = S_AXI_awvalid;
  assign m07_couplers_to_m07_couplers_BREADY = S_AXI_bready;
  assign m07_couplers_to_m07_couplers_BRESP = M_AXI_bresp[1:0];
  assign m07_couplers_to_m07_couplers_BVALID = M_AXI_bvalid;
  assign m07_couplers_to_m07_couplers_RDATA = M_AXI_rdata[31:0];
  assign m07_couplers_to_m07_couplers_RREADY = S_AXI_rready;
  assign m07_couplers_to_m07_couplers_RRESP = M_AXI_rresp[1:0];
  assign m07_couplers_to_m07_couplers_RVALID = M_AXI_rvalid;
  assign m07_couplers_to_m07_couplers_WDATA = S_AXI_wdata[31:0];
  assign m07_couplers_to_m07_couplers_WREADY = M_AXI_wready;
  assign m07_couplers_to_m07_couplers_WSTRB = S_AXI_wstrb[3:0];
  assign m07_couplers_to_m07_couplers_WVALID = S_AXI_wvalid;
endmodule

module m08_couplers_imp_1WQFHXD
   (M_ACLK,
    M_ARESETN,
    M_AXI_araddr,
    M_AXI_arready,
    M_AXI_arvalid,
    M_AXI_awaddr,
    M_AXI_awready,
    M_AXI_awvalid,
    M_AXI_bready,
    M_AXI_bresp,
    M_AXI_bvalid,
    M_AXI_rdata,
    M_AXI_rready,
    M_AXI_rresp,
    M_AXI_rvalid,
    M_AXI_wdata,
    M_AXI_wready,
    M_AXI_wstrb,
    M_AXI_wvalid,
    S_ACLK,
    S_ARESETN,
    S_AXI_araddr,
    S_AXI_arprot,
    S_AXI_arready,
    S_AXI_arvalid,
    S_AXI_awaddr,
    S_AXI_awprot,
    S_AXI_awready,
    S_AXI_awvalid,
    S_AXI_bready,
    S_AXI_bresp,
    S_AXI_bvalid,
    S_AXI_rdata,
    S_AXI_rready,
    S_AXI_rresp,
    S_AXI_rvalid,
    S_AXI_wdata,
    S_AXI_wready,
    S_AXI_wstrb,
    S_AXI_wvalid);
  input M_ACLK;
  input M_ARESETN;
  output [8:0]M_AXI_araddr;
  input M_AXI_arready;
  output M_AXI_arvalid;
  output [8:0]M_AXI_awaddr;
  input M_AXI_awready;
  output M_AXI_awvalid;
  output M_AXI_bready;
  input [1:0]M_AXI_bresp;
  input M_AXI_bvalid;
  input [31:0]M_AXI_rdata;
  output M_AXI_rready;
  input [1:0]M_AXI_rresp;
  input M_AXI_rvalid;
  output [31:0]M_AXI_wdata;
  input M_AXI_wready;
  output [3:0]M_AXI_wstrb;
  output M_AXI_wvalid;
  input S_ACLK;
  input S_ARESETN;
  input [31:0]S_AXI_araddr;
  input [2:0]S_AXI_arprot;
  output S_AXI_arready;
  input S_AXI_arvalid;
  input [31:0]S_AXI_awaddr;
  input [2:0]S_AXI_awprot;
  output S_AXI_awready;
  input S_AXI_awvalid;
  input S_AXI_bready;
  output [1:0]S_AXI_bresp;
  output S_AXI_bvalid;
  output [31:0]S_AXI_rdata;
  input S_AXI_rready;
  output [1:0]S_AXI_rresp;
  output S_AXI_rvalid;
  input [31:0]S_AXI_wdata;
  output S_AXI_wready;
  input [3:0]S_AXI_wstrb;
  input S_AXI_wvalid;

  wire M_ACLK_1;
  wire M_ARESETN_1;
  wire S_ACLK_1;
  wire S_ARESETN_1;
  wire [8:0]auto_cc_to_m08_couplers_ARADDR;
  wire auto_cc_to_m08_couplers_ARREADY;
  wire auto_cc_to_m08_couplers_ARVALID;
  wire [8:0]auto_cc_to_m08_couplers_AWADDR;
  wire auto_cc_to_m08_couplers_AWREADY;
  wire auto_cc_to_m08_couplers_AWVALID;
  wire auto_cc_to_m08_couplers_BREADY;
  wire [1:0]auto_cc_to_m08_couplers_BRESP;
  wire auto_cc_to_m08_couplers_BVALID;
  wire [31:0]auto_cc_to_m08_couplers_RDATA;
  wire auto_cc_to_m08_couplers_RREADY;
  wire [1:0]auto_cc_to_m08_couplers_RRESP;
  wire auto_cc_to_m08_couplers_RVALID;
  wire [31:0]auto_cc_to_m08_couplers_WDATA;
  wire auto_cc_to_m08_couplers_WREADY;
  wire [3:0]auto_cc_to_m08_couplers_WSTRB;
  wire auto_cc_to_m08_couplers_WVALID;
  wire [31:0]m08_couplers_to_auto_cc_ARADDR;
  wire [2:0]m08_couplers_to_auto_cc_ARPROT;
  wire m08_couplers_to_auto_cc_ARREADY;
  wire m08_couplers_to_auto_cc_ARVALID;
  wire [31:0]m08_couplers_to_auto_cc_AWADDR;
  wire [2:0]m08_couplers_to_auto_cc_AWPROT;
  wire m08_couplers_to_auto_cc_AWREADY;
  wire m08_couplers_to_auto_cc_AWVALID;
  wire m08_couplers_to_auto_cc_BREADY;
  wire [1:0]m08_couplers_to_auto_cc_BRESP;
  wire m08_couplers_to_auto_cc_BVALID;
  wire [31:0]m08_couplers_to_auto_cc_RDATA;
  wire m08_couplers_to_auto_cc_RREADY;
  wire [1:0]m08_couplers_to_auto_cc_RRESP;
  wire m08_couplers_to_auto_cc_RVALID;
  wire [31:0]m08_couplers_to_auto_cc_WDATA;
  wire m08_couplers_to_auto_cc_WREADY;
  wire [3:0]m08_couplers_to_auto_cc_WSTRB;
  wire m08_couplers_to_auto_cc_WVALID;

  assign M_ACLK_1 = M_ACLK;
  assign M_ARESETN_1 = M_ARESETN;
  assign M_AXI_araddr[8:0] = auto_cc_to_m08_couplers_ARADDR;
  assign M_AXI_arvalid = auto_cc_to_m08_couplers_ARVALID;
  assign M_AXI_awaddr[8:0] = auto_cc_to_m08_couplers_AWADDR;
  assign M_AXI_awvalid = auto_cc_to_m08_couplers_AWVALID;
  assign M_AXI_bready = auto_cc_to_m08_couplers_BREADY;
  assign M_AXI_rready = auto_cc_to_m08_couplers_RREADY;
  assign M_AXI_wdata[31:0] = auto_cc_to_m08_couplers_WDATA;
  assign M_AXI_wstrb[3:0] = auto_cc_to_m08_couplers_WSTRB;
  assign M_AXI_wvalid = auto_cc_to_m08_couplers_WVALID;
  assign S_ACLK_1 = S_ACLK;
  assign S_ARESETN_1 = S_ARESETN;
  assign S_AXI_arready = m08_couplers_to_auto_cc_ARREADY;
  assign S_AXI_awready = m08_couplers_to_auto_cc_AWREADY;
  assign S_AXI_bresp[1:0] = m08_couplers_to_auto_cc_BRESP;
  assign S_AXI_bvalid = m08_couplers_to_auto_cc_BVALID;
  assign S_AXI_rdata[31:0] = m08_couplers_to_auto_cc_RDATA;
  assign S_AXI_rresp[1:0] = m08_couplers_to_auto_cc_RRESP;
  assign S_AXI_rvalid = m08_couplers_to_auto_cc_RVALID;
  assign S_AXI_wready = m08_couplers_to_auto_cc_WREADY;
  assign auto_cc_to_m08_couplers_ARREADY = M_AXI_arready;
  assign auto_cc_to_m08_couplers_AWREADY = M_AXI_awready;
  assign auto_cc_to_m08_couplers_BRESP = M_AXI_bresp[1:0];
  assign auto_cc_to_m08_couplers_BVALID = M_AXI_bvalid;
  assign auto_cc_to_m08_couplers_RDATA = M_AXI_rdata[31:0];
  assign auto_cc_to_m08_couplers_RRESP = M_AXI_rresp[1:0];
  assign auto_cc_to_m08_couplers_RVALID = M_AXI_rvalid;
  assign auto_cc_to_m08_couplers_WREADY = M_AXI_wready;
  assign m08_couplers_to_auto_cc_ARADDR = S_AXI_araddr[31:0];
  assign m08_couplers_to_auto_cc_ARPROT = S_AXI_arprot[2:0];
  assign m08_couplers_to_auto_cc_ARVALID = S_AXI_arvalid;
  assign m08_couplers_to_auto_cc_AWADDR = S_AXI_awaddr[31:0];
  assign m08_couplers_to_auto_cc_AWPROT = S_AXI_awprot[2:0];
  assign m08_couplers_to_auto_cc_AWVALID = S_AXI_awvalid;
  assign m08_couplers_to_auto_cc_BREADY = S_AXI_bready;
  assign m08_couplers_to_auto_cc_RREADY = S_AXI_rready;
  assign m08_couplers_to_auto_cc_WDATA = S_AXI_wdata[31:0];
  assign m08_couplers_to_auto_cc_WSTRB = S_AXI_wstrb[3:0];
  assign m08_couplers_to_auto_cc_WVALID = S_AXI_wvalid;
  exdes_auto_cc_1 auto_cc
       (.m_axi_aclk(M_ACLK_1),
        .m_axi_araddr(auto_cc_to_m08_couplers_ARADDR),
        .m_axi_aresetn(M_ARESETN_1),
        .m_axi_arready(auto_cc_to_m08_couplers_ARREADY),
        .m_axi_arvalid(auto_cc_to_m08_couplers_ARVALID),
        .m_axi_awaddr(auto_cc_to_m08_couplers_AWADDR),
        .m_axi_awready(auto_cc_to_m08_couplers_AWREADY),
        .m_axi_awvalid(auto_cc_to_m08_couplers_AWVALID),
        .m_axi_bready(auto_cc_to_m08_couplers_BREADY),
        .m_axi_bresp(auto_cc_to_m08_couplers_BRESP),
        .m_axi_bvalid(auto_cc_to_m08_couplers_BVALID),
        .m_axi_rdata(auto_cc_to_m08_couplers_RDATA),
        .m_axi_rready(auto_cc_to_m08_couplers_RREADY),
        .m_axi_rresp(auto_cc_to_m08_couplers_RRESP),
        .m_axi_rvalid(auto_cc_to_m08_couplers_RVALID),
        .m_axi_wdata(auto_cc_to_m08_couplers_WDATA),
        .m_axi_wready(auto_cc_to_m08_couplers_WREADY),
        .m_axi_wstrb(auto_cc_to_m08_couplers_WSTRB),
        .m_axi_wvalid(auto_cc_to_m08_couplers_WVALID),
        .s_axi_aclk(S_ACLK_1),
        .s_axi_araddr(m08_couplers_to_auto_cc_ARADDR[8:0]),
        .s_axi_aresetn(S_ARESETN_1),
        .s_axi_arprot(m08_couplers_to_auto_cc_ARPROT),
        .s_axi_arready(m08_couplers_to_auto_cc_ARREADY),
        .s_axi_arvalid(m08_couplers_to_auto_cc_ARVALID),
        .s_axi_awaddr(m08_couplers_to_auto_cc_AWADDR[8:0]),
        .s_axi_awprot(m08_couplers_to_auto_cc_AWPROT),
        .s_axi_awready(m08_couplers_to_auto_cc_AWREADY),
        .s_axi_awvalid(m08_couplers_to_auto_cc_AWVALID),
        .s_axi_bready(m08_couplers_to_auto_cc_BREADY),
        .s_axi_bresp(m08_couplers_to_auto_cc_BRESP),
        .s_axi_bvalid(m08_couplers_to_auto_cc_BVALID),
        .s_axi_rdata(m08_couplers_to_auto_cc_RDATA),
        .s_axi_rready(m08_couplers_to_auto_cc_RREADY),
        .s_axi_rresp(m08_couplers_to_auto_cc_RRESP),
        .s_axi_rvalid(m08_couplers_to_auto_cc_RVALID),
        .s_axi_wdata(m08_couplers_to_auto_cc_WDATA),
        .s_axi_wready(m08_couplers_to_auto_cc_WREADY),
        .s_axi_wstrb(m08_couplers_to_auto_cc_WSTRB),
        .s_axi_wvalid(m08_couplers_to_auto_cc_WVALID));
endmodule

module mb_ss_0_imp_F1JHLQ
   (IIC_scl_i,
    IIC_scl_o,
    IIC_scl_t,
    IIC_sda_i,
    IIC_sda_o,
    IIC_sda_t,
    M00_AXI_araddr,
    M00_AXI_arprot,
    M00_AXI_arready,
    M00_AXI_arvalid,
    M00_AXI_awaddr,
    M00_AXI_awprot,
    M00_AXI_awready,
    M00_AXI_awvalid,
    M00_AXI_bready,
    M00_AXI_bresp,
    M00_AXI_bvalid,
    M00_AXI_rdata,
    M00_AXI_rready,
    M00_AXI_rresp,
    M00_AXI_rvalid,
    M00_AXI_wdata,
    M00_AXI_wready,
    M00_AXI_wstrb,
    M00_AXI_wvalid,
    M01_AXI_araddr,
    M01_AXI_arprot,
    M01_AXI_arready,
    M01_AXI_arvalid,
    M01_AXI_awaddr,
    M01_AXI_awprot,
    M01_AXI_awready,
    M01_AXI_awvalid,
    M01_AXI_bready,
    M01_AXI_bresp,
    M01_AXI_bvalid,
    M01_AXI_rdata,
    M01_AXI_rready,
    M01_AXI_rresp,
    M01_AXI_rvalid,
    M01_AXI_wdata,
    M01_AXI_wready,
    M01_AXI_wstrb,
    M01_AXI_wvalid,
    M02_AXI_araddr,
    M02_AXI_arprot,
    M02_AXI_arready,
    M02_AXI_arvalid,
    M02_AXI_awaddr,
    M02_AXI_awprot,
    M02_AXI_awready,
    M02_AXI_awvalid,
    M02_AXI_bready,
    M02_AXI_bresp,
    M02_AXI_bvalid,
    M02_AXI_rdata,
    M02_AXI_rready,
    M02_AXI_rresp,
    M02_AXI_rvalid,
    M02_AXI_wdata,
    M02_AXI_wready,
    M02_AXI_wstrb,
    M02_AXI_wvalid,
    M05_AXI_araddr,
    M05_AXI_arready,
    M05_AXI_arvalid,
    M05_AXI_awaddr,
    M05_AXI_awready,
    M05_AXI_awvalid,
    M05_AXI_bready,
    M05_AXI_bresp,
    M05_AXI_bvalid,
    M05_AXI_rdata,
    M05_AXI_rready,
    M05_AXI_rresp,
    M05_AXI_rvalid,
    M05_AXI_wdata,
    M05_AXI_wready,
    M05_AXI_wstrb,
    M05_AXI_wvalid,
    M06_AXI_araddr,
    M06_AXI_arprot,
    M06_AXI_arready,
    M06_AXI_arvalid,
    M06_AXI_awaddr,
    M06_AXI_awprot,
    M06_AXI_awready,
    M06_AXI_awvalid,
    M06_AXI_bready,
    M06_AXI_bresp,
    M06_AXI_bvalid,
    M06_AXI_rdata,
    M06_AXI_rready,
    M06_AXI_rresp,
    M06_AXI_rvalid,
    M06_AXI_wdata,
    M06_AXI_wready,
    M06_AXI_wstrb,
    M06_AXI_wvalid,
    M08_AXI_araddr,
    M08_AXI_arready,
    M08_AXI_arvalid,
    M08_AXI_awaddr,
    M08_AXI_awready,
    M08_AXI_awvalid,
    M08_AXI_bready,
    M08_AXI_bresp,
    M08_AXI_bvalid,
    M08_AXI_rdata,
    M08_AXI_rready,
    M08_AXI_rresp,
    M08_AXI_rvalid,
    M08_AXI_wdata,
    M08_AXI_wready,
    M08_AXI_wstrb,
    M08_AXI_wvalid,
    UART_rxd,
    UART_txd,
    clk_out2,
    dcm_locked,
    ext_reset_in,
    hdmi_rx_irq,
    hdmi_tx_irq,
    peripheral_aresetn,
    s_axi_aclk,
    sys_diff_clock_clk_n,
    sys_diff_clock_clk_p,
    vphy_irq);
  input IIC_scl_i;
  output IIC_scl_o;
  output IIC_scl_t;
  input IIC_sda_i;
  output IIC_sda_o;
  output IIC_sda_t;
  output [31:0]M00_AXI_araddr;
  output [2:0]M00_AXI_arprot;
  input [0:0]M00_AXI_arready;
  output [0:0]M00_AXI_arvalid;
  output [31:0]M00_AXI_awaddr;
  output [2:0]M00_AXI_awprot;
  input [0:0]M00_AXI_awready;
  output [0:0]M00_AXI_awvalid;
  output [0:0]M00_AXI_bready;
  input [1:0]M00_AXI_bresp;
  input [0:0]M00_AXI_bvalid;
  input [31:0]M00_AXI_rdata;
  output [0:0]M00_AXI_rready;
  input [1:0]M00_AXI_rresp;
  input [0:0]M00_AXI_rvalid;
  output [31:0]M00_AXI_wdata;
  input [0:0]M00_AXI_wready;
  output [3:0]M00_AXI_wstrb;
  output [0:0]M00_AXI_wvalid;
  output [31:0]M01_AXI_araddr;
  output [2:0]M01_AXI_arprot;
  input [0:0]M01_AXI_arready;
  output [0:0]M01_AXI_arvalid;
  output [31:0]M01_AXI_awaddr;
  output [2:0]M01_AXI_awprot;
  input [0:0]M01_AXI_awready;
  output [0:0]M01_AXI_awvalid;
  output [0:0]M01_AXI_bready;
  input [1:0]M01_AXI_bresp;
  input [0:0]M01_AXI_bvalid;
  input [31:0]M01_AXI_rdata;
  output [0:0]M01_AXI_rready;
  input [1:0]M01_AXI_rresp;
  input [0:0]M01_AXI_rvalid;
  output [31:0]M01_AXI_wdata;
  input [0:0]M01_AXI_wready;
  output [3:0]M01_AXI_wstrb;
  output [0:0]M01_AXI_wvalid;
  output [31:0]M02_AXI_araddr;
  output [2:0]M02_AXI_arprot;
  input [0:0]M02_AXI_arready;
  output [0:0]M02_AXI_arvalid;
  output [31:0]M02_AXI_awaddr;
  output [2:0]M02_AXI_awprot;
  input [0:0]M02_AXI_awready;
  output [0:0]M02_AXI_awvalid;
  output [0:0]M02_AXI_bready;
  input [1:0]M02_AXI_bresp;
  input [0:0]M02_AXI_bvalid;
  input [31:0]M02_AXI_rdata;
  output [0:0]M02_AXI_rready;
  input [1:0]M02_AXI_rresp;
  input [0:0]M02_AXI_rvalid;
  output [31:0]M02_AXI_wdata;
  input [0:0]M02_AXI_wready;
  output [3:0]M02_AXI_wstrb;
  output [0:0]M02_AXI_wvalid;
  output [7:0]M05_AXI_araddr;
  input M05_AXI_arready;
  output M05_AXI_arvalid;
  output [7:0]M05_AXI_awaddr;
  input M05_AXI_awready;
  output M05_AXI_awvalid;
  output M05_AXI_bready;
  input [1:0]M05_AXI_bresp;
  input M05_AXI_bvalid;
  input [31:0]M05_AXI_rdata;
  output M05_AXI_rready;
  input [1:0]M05_AXI_rresp;
  input M05_AXI_rvalid;
  output [31:0]M05_AXI_wdata;
  input M05_AXI_wready;
  output [3:0]M05_AXI_wstrb;
  output M05_AXI_wvalid;
  output [31:0]M06_AXI_araddr;
  output [2:0]M06_AXI_arprot;
  input [0:0]M06_AXI_arready;
  output [0:0]M06_AXI_arvalid;
  output [31:0]M06_AXI_awaddr;
  output [2:0]M06_AXI_awprot;
  input [0:0]M06_AXI_awready;
  output [0:0]M06_AXI_awvalid;
  output [0:0]M06_AXI_bready;
  input [1:0]M06_AXI_bresp;
  input [0:0]M06_AXI_bvalid;
  input [31:0]M06_AXI_rdata;
  output [0:0]M06_AXI_rready;
  input [1:0]M06_AXI_rresp;
  input [0:0]M06_AXI_rvalid;
  output [31:0]M06_AXI_wdata;
  input [0:0]M06_AXI_wready;
  output [3:0]M06_AXI_wstrb;
  output [0:0]M06_AXI_wvalid;
  output [8:0]M08_AXI_araddr;
  input M08_AXI_arready;
  output M08_AXI_arvalid;
  output [8:0]M08_AXI_awaddr;
  input M08_AXI_awready;
  output M08_AXI_awvalid;
  output M08_AXI_bready;
  input [1:0]M08_AXI_bresp;
  input M08_AXI_bvalid;
  input [31:0]M08_AXI_rdata;
  output M08_AXI_rready;
  input [1:0]M08_AXI_rresp;
  input M08_AXI_rvalid;
  output [31:0]M08_AXI_wdata;
  input M08_AXI_wready;
  output [3:0]M08_AXI_wstrb;
  output M08_AXI_wvalid;
  input UART_rxd;
  output UART_txd;
  output clk_out2;
  output [0:0]dcm_locked;
  input ext_reset_in;
  input hdmi_rx_irq;
  input hdmi_tx_irq;
  output [0:0]peripheral_aresetn;
  output s_axi_aclk;
  input sys_diff_clock_clk_n;
  input sys_diff_clock_clk_p;
  input vphy_irq;

  wire Conn1_CLK_N;
  wire Conn1_CLK_P;
  wire intf_net_axi_intc_interrupt_INTERRUPT;
  wire [31:0]intf_net_axi_interconnect_M00_AXI_ARADDR;
  wire [2:0]intf_net_axi_interconnect_M00_AXI_ARPROT;
  wire [0:0]intf_net_axi_interconnect_M00_AXI_ARREADY;
  wire [0:0]intf_net_axi_interconnect_M00_AXI_ARVALID;
  wire [31:0]intf_net_axi_interconnect_M00_AXI_AWADDR;
  wire [2:0]intf_net_axi_interconnect_M00_AXI_AWPROT;
  wire [0:0]intf_net_axi_interconnect_M00_AXI_AWREADY;
  wire [0:0]intf_net_axi_interconnect_M00_AXI_AWVALID;
  wire [0:0]intf_net_axi_interconnect_M00_AXI_BREADY;
  wire [1:0]intf_net_axi_interconnect_M00_AXI_BRESP;
  wire [0:0]intf_net_axi_interconnect_M00_AXI_BVALID;
  wire [31:0]intf_net_axi_interconnect_M00_AXI_RDATA;
  wire [0:0]intf_net_axi_interconnect_M00_AXI_RREADY;
  wire [1:0]intf_net_axi_interconnect_M00_AXI_RRESP;
  wire [0:0]intf_net_axi_interconnect_M00_AXI_RVALID;
  wire [31:0]intf_net_axi_interconnect_M00_AXI_WDATA;
  wire [0:0]intf_net_axi_interconnect_M00_AXI_WREADY;
  wire [3:0]intf_net_axi_interconnect_M00_AXI_WSTRB;
  wire [0:0]intf_net_axi_interconnect_M00_AXI_WVALID;
  wire [31:0]intf_net_axi_interconnect_M01_AXI_ARADDR;
  wire [2:0]intf_net_axi_interconnect_M01_AXI_ARPROT;
  wire [0:0]intf_net_axi_interconnect_M01_AXI_ARREADY;
  wire [0:0]intf_net_axi_interconnect_M01_AXI_ARVALID;
  wire [31:0]intf_net_axi_interconnect_M01_AXI_AWADDR;
  wire [2:0]intf_net_axi_interconnect_M01_AXI_AWPROT;
  wire [0:0]intf_net_axi_interconnect_M01_AXI_AWREADY;
  wire [0:0]intf_net_axi_interconnect_M01_AXI_AWVALID;
  wire [0:0]intf_net_axi_interconnect_M01_AXI_BREADY;
  wire [1:0]intf_net_axi_interconnect_M01_AXI_BRESP;
  wire [0:0]intf_net_axi_interconnect_M01_AXI_BVALID;
  wire [31:0]intf_net_axi_interconnect_M01_AXI_RDATA;
  wire [0:0]intf_net_axi_interconnect_M01_AXI_RREADY;
  wire [1:0]intf_net_axi_interconnect_M01_AXI_RRESP;
  wire [0:0]intf_net_axi_interconnect_M01_AXI_RVALID;
  wire [31:0]intf_net_axi_interconnect_M01_AXI_WDATA;
  wire [0:0]intf_net_axi_interconnect_M01_AXI_WREADY;
  wire [3:0]intf_net_axi_interconnect_M01_AXI_WSTRB;
  wire [0:0]intf_net_axi_interconnect_M01_AXI_WVALID;
  wire [31:0]intf_net_axi_interconnect_M02_AXI_ARADDR;
  wire [2:0]intf_net_axi_interconnect_M02_AXI_ARPROT;
  wire [0:0]intf_net_axi_interconnect_M02_AXI_ARREADY;
  wire [0:0]intf_net_axi_interconnect_M02_AXI_ARVALID;
  wire [31:0]intf_net_axi_interconnect_M02_AXI_AWADDR;
  wire [2:0]intf_net_axi_interconnect_M02_AXI_AWPROT;
  wire [0:0]intf_net_axi_interconnect_M02_AXI_AWREADY;
  wire [0:0]intf_net_axi_interconnect_M02_AXI_AWVALID;
  wire [0:0]intf_net_axi_interconnect_M02_AXI_BREADY;
  wire [1:0]intf_net_axi_interconnect_M02_AXI_BRESP;
  wire [0:0]intf_net_axi_interconnect_M02_AXI_BVALID;
  wire [31:0]intf_net_axi_interconnect_M02_AXI_RDATA;
  wire [0:0]intf_net_axi_interconnect_M02_AXI_RREADY;
  wire [1:0]intf_net_axi_interconnect_M02_AXI_RRESP;
  wire [0:0]intf_net_axi_interconnect_M02_AXI_RVALID;
  wire [31:0]intf_net_axi_interconnect_M02_AXI_WDATA;
  wire [0:0]intf_net_axi_interconnect_M02_AXI_WREADY;
  wire [3:0]intf_net_axi_interconnect_M02_AXI_WSTRB;
  wire [0:0]intf_net_axi_interconnect_M02_AXI_WVALID;
  wire [31:0]intf_net_axi_interconnect_M03_AXI_ARADDR;
  wire intf_net_axi_interconnect_M03_AXI_ARREADY;
  wire intf_net_axi_interconnect_M03_AXI_ARVALID;
  wire [31:0]intf_net_axi_interconnect_M03_AXI_AWADDR;
  wire intf_net_axi_interconnect_M03_AXI_AWREADY;
  wire intf_net_axi_interconnect_M03_AXI_AWVALID;
  wire intf_net_axi_interconnect_M03_AXI_BREADY;
  wire [1:0]intf_net_axi_interconnect_M03_AXI_BRESP;
  wire intf_net_axi_interconnect_M03_AXI_BVALID;
  wire [31:0]intf_net_axi_interconnect_M03_AXI_RDATA;
  wire intf_net_axi_interconnect_M03_AXI_RREADY;
  wire [1:0]intf_net_axi_interconnect_M03_AXI_RRESP;
  wire intf_net_axi_interconnect_M03_AXI_RVALID;
  wire [31:0]intf_net_axi_interconnect_M03_AXI_WDATA;
  wire intf_net_axi_interconnect_M03_AXI_WREADY;
  wire [3:0]intf_net_axi_interconnect_M03_AXI_WSTRB;
  wire intf_net_axi_interconnect_M03_AXI_WVALID;
  wire [31:0]intf_net_axi_interconnect_M04_AXI_ARADDR;
  wire intf_net_axi_interconnect_M04_AXI_ARREADY;
  wire intf_net_axi_interconnect_M04_AXI_ARVALID;
  wire [31:0]intf_net_axi_interconnect_M04_AXI_AWADDR;
  wire intf_net_axi_interconnect_M04_AXI_AWREADY;
  wire intf_net_axi_interconnect_M04_AXI_AWVALID;
  wire intf_net_axi_interconnect_M04_AXI_BREADY;
  wire [1:0]intf_net_axi_interconnect_M04_AXI_BRESP;
  wire intf_net_axi_interconnect_M04_AXI_BVALID;
  wire [31:0]intf_net_axi_interconnect_M04_AXI_RDATA;
  wire intf_net_axi_interconnect_M04_AXI_RREADY;
  wire [1:0]intf_net_axi_interconnect_M04_AXI_RRESP;
  wire intf_net_axi_interconnect_M04_AXI_RVALID;
  wire [31:0]intf_net_axi_interconnect_M04_AXI_WDATA;
  wire intf_net_axi_interconnect_M04_AXI_WREADY;
  wire [3:0]intf_net_axi_interconnect_M04_AXI_WSTRB;
  wire intf_net_axi_interconnect_M04_AXI_WVALID;
  wire [7:0]intf_net_axi_interconnect_M05_AXI_ARADDR;
  wire intf_net_axi_interconnect_M05_AXI_ARREADY;
  wire intf_net_axi_interconnect_M05_AXI_ARVALID;
  wire [7:0]intf_net_axi_interconnect_M05_AXI_AWADDR;
  wire intf_net_axi_interconnect_M05_AXI_AWREADY;
  wire intf_net_axi_interconnect_M05_AXI_AWVALID;
  wire intf_net_axi_interconnect_M05_AXI_BREADY;
  wire [1:0]intf_net_axi_interconnect_M05_AXI_BRESP;
  wire intf_net_axi_interconnect_M05_AXI_BVALID;
  wire [31:0]intf_net_axi_interconnect_M05_AXI_RDATA;
  wire intf_net_axi_interconnect_M05_AXI_RREADY;
  wire [1:0]intf_net_axi_interconnect_M05_AXI_RRESP;
  wire intf_net_axi_interconnect_M05_AXI_RVALID;
  wire [31:0]intf_net_axi_interconnect_M05_AXI_WDATA;
  wire intf_net_axi_interconnect_M05_AXI_WREADY;
  wire [3:0]intf_net_axi_interconnect_M05_AXI_WSTRB;
  wire intf_net_axi_interconnect_M05_AXI_WVALID;
  wire [31:0]intf_net_axi_interconnect_M06_AXI_ARADDR;
  wire [2:0]intf_net_axi_interconnect_M06_AXI_ARPROT;
  wire [0:0]intf_net_axi_interconnect_M06_AXI_ARREADY;
  wire [0:0]intf_net_axi_interconnect_M06_AXI_ARVALID;
  wire [31:0]intf_net_axi_interconnect_M06_AXI_AWADDR;
  wire [2:0]intf_net_axi_interconnect_M06_AXI_AWPROT;
  wire [0:0]intf_net_axi_interconnect_M06_AXI_AWREADY;
  wire [0:0]intf_net_axi_interconnect_M06_AXI_AWVALID;
  wire [0:0]intf_net_axi_interconnect_M06_AXI_BREADY;
  wire [1:0]intf_net_axi_interconnect_M06_AXI_BRESP;
  wire [0:0]intf_net_axi_interconnect_M06_AXI_BVALID;
  wire [31:0]intf_net_axi_interconnect_M06_AXI_RDATA;
  wire [0:0]intf_net_axi_interconnect_M06_AXI_RREADY;
  wire [1:0]intf_net_axi_interconnect_M06_AXI_RRESP;
  wire [0:0]intf_net_axi_interconnect_M06_AXI_RVALID;
  wire [31:0]intf_net_axi_interconnect_M06_AXI_WDATA;
  wire [0:0]intf_net_axi_interconnect_M06_AXI_WREADY;
  wire [3:0]intf_net_axi_interconnect_M06_AXI_WSTRB;
  wire [0:0]intf_net_axi_interconnect_M06_AXI_WVALID;
  wire [31:0]intf_net_axi_interconnect_M07_AXI_ARADDR;
  wire intf_net_axi_interconnect_M07_AXI_ARREADY;
  wire intf_net_axi_interconnect_M07_AXI_ARVALID;
  wire [31:0]intf_net_axi_interconnect_M07_AXI_AWADDR;
  wire intf_net_axi_interconnect_M07_AXI_AWREADY;
  wire intf_net_axi_interconnect_M07_AXI_AWVALID;
  wire intf_net_axi_interconnect_M07_AXI_BREADY;
  wire [1:0]intf_net_axi_interconnect_M07_AXI_BRESP;
  wire intf_net_axi_interconnect_M07_AXI_BVALID;
  wire [31:0]intf_net_axi_interconnect_M07_AXI_RDATA;
  wire intf_net_axi_interconnect_M07_AXI_RREADY;
  wire [1:0]intf_net_axi_interconnect_M07_AXI_RRESP;
  wire intf_net_axi_interconnect_M07_AXI_RVALID;
  wire [31:0]intf_net_axi_interconnect_M07_AXI_WDATA;
  wire intf_net_axi_interconnect_M07_AXI_WREADY;
  wire [3:0]intf_net_axi_interconnect_M07_AXI_WSTRB;
  wire intf_net_axi_interconnect_M07_AXI_WVALID;
  wire [8:0]intf_net_axi_interconnect_M08_AXI_ARADDR;
  wire intf_net_axi_interconnect_M08_AXI_ARREADY;
  wire intf_net_axi_interconnect_M08_AXI_ARVALID;
  wire [8:0]intf_net_axi_interconnect_M08_AXI_AWADDR;
  wire intf_net_axi_interconnect_M08_AXI_AWREADY;
  wire intf_net_axi_interconnect_M08_AXI_AWVALID;
  wire intf_net_axi_interconnect_M08_AXI_BREADY;
  wire [1:0]intf_net_axi_interconnect_M08_AXI_BRESP;
  wire intf_net_axi_interconnect_M08_AXI_BVALID;
  wire [31:0]intf_net_axi_interconnect_M08_AXI_RDATA;
  wire intf_net_axi_interconnect_M08_AXI_RREADY;
  wire [1:0]intf_net_axi_interconnect_M08_AXI_RRESP;
  wire intf_net_axi_interconnect_M08_AXI_RVALID;
  wire [31:0]intf_net_axi_interconnect_M08_AXI_WDATA;
  wire intf_net_axi_interconnect_M08_AXI_WREADY;
  wire [3:0]intf_net_axi_interconnect_M08_AXI_WSTRB;
  wire intf_net_axi_interconnect_M08_AXI_WVALID;
  wire intf_net_axi_uartlite_UART_RxD;
  wire intf_net_axi_uartlite_UART_TxD;
  wire [0:31]intf_net_dlmb_bram_if_cntlr_BRAM_PORT_ADDR;
  wire intf_net_dlmb_bram_if_cntlr_BRAM_PORT_CLK;
  wire [0:31]intf_net_dlmb_bram_if_cntlr_BRAM_PORT_DIN;
  wire [31:0]intf_net_dlmb_bram_if_cntlr_BRAM_PORT_DOUT;
  wire intf_net_dlmb_bram_if_cntlr_BRAM_PORT_EN;
  wire intf_net_dlmb_bram_if_cntlr_BRAM_PORT_RST;
  wire [0:3]intf_net_dlmb_bram_if_cntlr_BRAM_PORT_WE;
  wire [0:31]intf_net_dlmb_v10_LMB_Sl_0_ABUS;
  wire intf_net_dlmb_v10_LMB_Sl_0_ADDRSTROBE;
  wire [0:3]intf_net_dlmb_v10_LMB_Sl_0_BE;
  wire intf_net_dlmb_v10_LMB_Sl_0_CE;
  wire [0:31]intf_net_dlmb_v10_LMB_Sl_0_READDBUS;
  wire intf_net_dlmb_v10_LMB_Sl_0_READSTROBE;
  wire intf_net_dlmb_v10_LMB_Sl_0_READY;
  wire intf_net_dlmb_v10_LMB_Sl_0_UE;
  wire intf_net_dlmb_v10_LMB_Sl_0_WAIT;
  wire [0:31]intf_net_dlmb_v10_LMB_Sl_0_WRITEDBUS;
  wire intf_net_dlmb_v10_LMB_Sl_0_WRITESTROBE;
  wire intf_net_fmch_axi_iic_IIC_SCL_I;
  wire intf_net_fmch_axi_iic_IIC_SCL_O;
  wire intf_net_fmch_axi_iic_IIC_SCL_T;
  wire intf_net_fmch_axi_iic_IIC_SDA_I;
  wire intf_net_fmch_axi_iic_IIC_SDA_O;
  wire intf_net_fmch_axi_iic_IIC_SDA_T;
  wire [0:31]intf_net_ilmb_bram_if_cntlr_BRAM_PORT_ADDR;
  wire intf_net_ilmb_bram_if_cntlr_BRAM_PORT_CLK;
  wire [0:31]intf_net_ilmb_bram_if_cntlr_BRAM_PORT_DIN;
  wire [31:0]intf_net_ilmb_bram_if_cntlr_BRAM_PORT_DOUT;
  wire intf_net_ilmb_bram_if_cntlr_BRAM_PORT_EN;
  wire intf_net_ilmb_bram_if_cntlr_BRAM_PORT_RST;
  wire [0:3]intf_net_ilmb_bram_if_cntlr_BRAM_PORT_WE;
  wire [0:31]intf_net_ilmb_v10_LMB_Sl_0_ABUS;
  wire intf_net_ilmb_v10_LMB_Sl_0_ADDRSTROBE;
  wire [0:3]intf_net_ilmb_v10_LMB_Sl_0_BE;
  wire intf_net_ilmb_v10_LMB_Sl_0_CE;
  wire [0:31]intf_net_ilmb_v10_LMB_Sl_0_READDBUS;
  wire intf_net_ilmb_v10_LMB_Sl_0_READSTROBE;
  wire intf_net_ilmb_v10_LMB_Sl_0_READY;
  wire intf_net_ilmb_v10_LMB_Sl_0_UE;
  wire intf_net_ilmb_v10_LMB_Sl_0_WAIT;
  wire [0:31]intf_net_ilmb_v10_LMB_Sl_0_WRITEDBUS;
  wire intf_net_ilmb_v10_LMB_Sl_0_WRITESTROBE;
  wire [0:31]intf_net_mblaze_DLMB_ABUS;
  wire intf_net_mblaze_DLMB_ADDRSTROBE;
  wire [0:3]intf_net_mblaze_DLMB_BE;
  wire intf_net_mblaze_DLMB_CE;
  wire [0:31]intf_net_mblaze_DLMB_READDBUS;
  wire intf_net_mblaze_DLMB_READSTROBE;
  wire intf_net_mblaze_DLMB_READY;
  wire intf_net_mblaze_DLMB_UE;
  wire intf_net_mblaze_DLMB_WAIT;
  wire [0:31]intf_net_mblaze_DLMB_WRITEDBUS;
  wire intf_net_mblaze_DLMB_WRITESTROBE;
  wire [0:31]intf_net_mblaze_ILMB_ABUS;
  wire intf_net_mblaze_ILMB_ADDRSTROBE;
  wire intf_net_mblaze_ILMB_CE;
  wire [0:31]intf_net_mblaze_ILMB_READDBUS;
  wire intf_net_mblaze_ILMB_READSTROBE;
  wire intf_net_mblaze_ILMB_READY;
  wire intf_net_mblaze_ILMB_UE;
  wire intf_net_mblaze_ILMB_WAIT;
  wire [31:0]intf_net_mblaze_M_AXI_DP_ARADDR;
  wire [2:0]intf_net_mblaze_M_AXI_DP_ARPROT;
  wire intf_net_mblaze_M_AXI_DP_ARREADY;
  wire intf_net_mblaze_M_AXI_DP_ARVALID;
  wire [31:0]intf_net_mblaze_M_AXI_DP_AWADDR;
  wire [2:0]intf_net_mblaze_M_AXI_DP_AWPROT;
  wire intf_net_mblaze_M_AXI_DP_AWREADY;
  wire intf_net_mblaze_M_AXI_DP_AWVALID;
  wire intf_net_mblaze_M_AXI_DP_BREADY;
  wire [1:0]intf_net_mblaze_M_AXI_DP_BRESP;
  wire intf_net_mblaze_M_AXI_DP_BVALID;
  wire [31:0]intf_net_mblaze_M_AXI_DP_RDATA;
  wire intf_net_mblaze_M_AXI_DP_RREADY;
  wire [1:0]intf_net_mblaze_M_AXI_DP_RRESP;
  wire intf_net_mblaze_M_AXI_DP_RVALID;
  wire [31:0]intf_net_mblaze_M_AXI_DP_WDATA;
  wire intf_net_mblaze_M_AXI_DP_WREADY;
  wire [3:0]intf_net_mblaze_M_AXI_DP_WSTRB;
  wire intf_net_mblaze_M_AXI_DP_WVALID;
  wire intf_net_mdm_MBDEBUG_0_CAPTURE;
  wire intf_net_mdm_MBDEBUG_0_CLK;
  wire intf_net_mdm_MBDEBUG_0_DISABLE;
  wire [0:7]intf_net_mdm_MBDEBUG_0_REG_EN;
  wire intf_net_mdm_MBDEBUG_0_RST;
  wire intf_net_mdm_MBDEBUG_0_SHIFT;
  wire intf_net_mdm_MBDEBUG_0_TDI;
  wire intf_net_mdm_MBDEBUG_0_TDO;
  wire intf_net_mdm_MBDEBUG_0_UPDATE;
  wire net_bdry_in_ext_reset_in;
  wire net_bdry_in_hdmi_rx_irq;
  wire net_bdry_in_hdmi_tx_irq;
  wire net_bdry_in_vphy_irq;
  wire net_clk_wiz_clk_out1;
  wire net_clk_wiz_clk_out2;
  wire net_clk_wiz_locked;
  wire net_mdm_Debug_SYS_Rst;
  wire [0:0]net_rst_processor_1_100M_bus_struct_reset;
  wire [0:0]net_rst_processor_1_100M_interconnect_aresetn;
  wire net_rst_processor_1_100M_mb_reset;
  wire [0:0]net_rst_processor_1_100M_peripheral_aresetn;
  wire [0:0]net_rst_processor_1_300M_interconnect_aresetn;
  wire [0:0]net_rst_processor_1_300M_peripheral_aresetn;
  wire [2:0]net_xlconcat_dout;

  assign Conn1_CLK_N = sys_diff_clock_clk_n;
  assign Conn1_CLK_P = sys_diff_clock_clk_p;
  assign IIC_scl_o = intf_net_fmch_axi_iic_IIC_SCL_O;
  assign IIC_scl_t = intf_net_fmch_axi_iic_IIC_SCL_T;
  assign IIC_sda_o = intf_net_fmch_axi_iic_IIC_SDA_O;
  assign IIC_sda_t = intf_net_fmch_axi_iic_IIC_SDA_T;
  assign M00_AXI_araddr[31:0] = intf_net_axi_interconnect_M00_AXI_ARADDR;
  assign M00_AXI_arprot[2:0] = intf_net_axi_interconnect_M00_AXI_ARPROT;
  assign M00_AXI_arvalid[0] = intf_net_axi_interconnect_M00_AXI_ARVALID;
  assign M00_AXI_awaddr[31:0] = intf_net_axi_interconnect_M00_AXI_AWADDR;
  assign M00_AXI_awprot[2:0] = intf_net_axi_interconnect_M00_AXI_AWPROT;
  assign M00_AXI_awvalid[0] = intf_net_axi_interconnect_M00_AXI_AWVALID;
  assign M00_AXI_bready[0] = intf_net_axi_interconnect_M00_AXI_BREADY;
  assign M00_AXI_rready[0] = intf_net_axi_interconnect_M00_AXI_RREADY;
  assign M00_AXI_wdata[31:0] = intf_net_axi_interconnect_M00_AXI_WDATA;
  assign M00_AXI_wstrb[3:0] = intf_net_axi_interconnect_M00_AXI_WSTRB;
  assign M00_AXI_wvalid[0] = intf_net_axi_interconnect_M00_AXI_WVALID;
  assign M01_AXI_araddr[31:0] = intf_net_axi_interconnect_M01_AXI_ARADDR;
  assign M01_AXI_arprot[2:0] = intf_net_axi_interconnect_M01_AXI_ARPROT;
  assign M01_AXI_arvalid[0] = intf_net_axi_interconnect_M01_AXI_ARVALID;
  assign M01_AXI_awaddr[31:0] = intf_net_axi_interconnect_M01_AXI_AWADDR;
  assign M01_AXI_awprot[2:0] = intf_net_axi_interconnect_M01_AXI_AWPROT;
  assign M01_AXI_awvalid[0] = intf_net_axi_interconnect_M01_AXI_AWVALID;
  assign M01_AXI_bready[0] = intf_net_axi_interconnect_M01_AXI_BREADY;
  assign M01_AXI_rready[0] = intf_net_axi_interconnect_M01_AXI_RREADY;
  assign M01_AXI_wdata[31:0] = intf_net_axi_interconnect_M01_AXI_WDATA;
  assign M01_AXI_wstrb[3:0] = intf_net_axi_interconnect_M01_AXI_WSTRB;
  assign M01_AXI_wvalid[0] = intf_net_axi_interconnect_M01_AXI_WVALID;
  assign M02_AXI_araddr[31:0] = intf_net_axi_interconnect_M02_AXI_ARADDR;
  assign M02_AXI_arprot[2:0] = intf_net_axi_interconnect_M02_AXI_ARPROT;
  assign M02_AXI_arvalid[0] = intf_net_axi_interconnect_M02_AXI_ARVALID;
  assign M02_AXI_awaddr[31:0] = intf_net_axi_interconnect_M02_AXI_AWADDR;
  assign M02_AXI_awprot[2:0] = intf_net_axi_interconnect_M02_AXI_AWPROT;
  assign M02_AXI_awvalid[0] = intf_net_axi_interconnect_M02_AXI_AWVALID;
  assign M02_AXI_bready[0] = intf_net_axi_interconnect_M02_AXI_BREADY;
  assign M02_AXI_rready[0] = intf_net_axi_interconnect_M02_AXI_RREADY;
  assign M02_AXI_wdata[31:0] = intf_net_axi_interconnect_M02_AXI_WDATA;
  assign M02_AXI_wstrb[3:0] = intf_net_axi_interconnect_M02_AXI_WSTRB;
  assign M02_AXI_wvalid[0] = intf_net_axi_interconnect_M02_AXI_WVALID;
  assign M05_AXI_araddr[7:0] = intf_net_axi_interconnect_M05_AXI_ARADDR;
  assign M05_AXI_arvalid = intf_net_axi_interconnect_M05_AXI_ARVALID;
  assign M05_AXI_awaddr[7:0] = intf_net_axi_interconnect_M05_AXI_AWADDR;
  assign M05_AXI_awvalid = intf_net_axi_interconnect_M05_AXI_AWVALID;
  assign M05_AXI_bready = intf_net_axi_interconnect_M05_AXI_BREADY;
  assign M05_AXI_rready = intf_net_axi_interconnect_M05_AXI_RREADY;
  assign M05_AXI_wdata[31:0] = intf_net_axi_interconnect_M05_AXI_WDATA;
  assign M05_AXI_wstrb[3:0] = intf_net_axi_interconnect_M05_AXI_WSTRB;
  assign M05_AXI_wvalid = intf_net_axi_interconnect_M05_AXI_WVALID;
  assign M06_AXI_araddr[31:0] = intf_net_axi_interconnect_M06_AXI_ARADDR;
  assign M06_AXI_arprot[2:0] = intf_net_axi_interconnect_M06_AXI_ARPROT;
  assign M06_AXI_arvalid[0] = intf_net_axi_interconnect_M06_AXI_ARVALID;
  assign M06_AXI_awaddr[31:0] = intf_net_axi_interconnect_M06_AXI_AWADDR;
  assign M06_AXI_awprot[2:0] = intf_net_axi_interconnect_M06_AXI_AWPROT;
  assign M06_AXI_awvalid[0] = intf_net_axi_interconnect_M06_AXI_AWVALID;
  assign M06_AXI_bready[0] = intf_net_axi_interconnect_M06_AXI_BREADY;
  assign M06_AXI_rready[0] = intf_net_axi_interconnect_M06_AXI_RREADY;
  assign M06_AXI_wdata[31:0] = intf_net_axi_interconnect_M06_AXI_WDATA;
  assign M06_AXI_wstrb[3:0] = intf_net_axi_interconnect_M06_AXI_WSTRB;
  assign M06_AXI_wvalid[0] = intf_net_axi_interconnect_M06_AXI_WVALID;
  assign M08_AXI_araddr[8:0] = intf_net_axi_interconnect_M08_AXI_ARADDR;
  assign M08_AXI_arvalid = intf_net_axi_interconnect_M08_AXI_ARVALID;
  assign M08_AXI_awaddr[8:0] = intf_net_axi_interconnect_M08_AXI_AWADDR;
  assign M08_AXI_awvalid = intf_net_axi_interconnect_M08_AXI_AWVALID;
  assign M08_AXI_bready = intf_net_axi_interconnect_M08_AXI_BREADY;
  assign M08_AXI_rready = intf_net_axi_interconnect_M08_AXI_RREADY;
  assign M08_AXI_wdata[31:0] = intf_net_axi_interconnect_M08_AXI_WDATA;
  assign M08_AXI_wstrb[3:0] = intf_net_axi_interconnect_M08_AXI_WSTRB;
  assign M08_AXI_wvalid = intf_net_axi_interconnect_M08_AXI_WVALID;
  assign UART_txd = intf_net_axi_uartlite_UART_TxD;
  assign clk_out2 = net_clk_wiz_clk_out2;
  assign dcm_locked[0] = net_rst_processor_1_300M_peripheral_aresetn;
  assign intf_net_axi_interconnect_M00_AXI_ARREADY = M00_AXI_arready[0];
  assign intf_net_axi_interconnect_M00_AXI_AWREADY = M00_AXI_awready[0];
  assign intf_net_axi_interconnect_M00_AXI_BRESP = M00_AXI_bresp[1:0];
  assign intf_net_axi_interconnect_M00_AXI_BVALID = M00_AXI_bvalid[0];
  assign intf_net_axi_interconnect_M00_AXI_RDATA = M00_AXI_rdata[31:0];
  assign intf_net_axi_interconnect_M00_AXI_RRESP = M00_AXI_rresp[1:0];
  assign intf_net_axi_interconnect_M00_AXI_RVALID = M00_AXI_rvalid[0];
  assign intf_net_axi_interconnect_M00_AXI_WREADY = M00_AXI_wready[0];
  assign intf_net_axi_interconnect_M01_AXI_ARREADY = M01_AXI_arready[0];
  assign intf_net_axi_interconnect_M01_AXI_AWREADY = M01_AXI_awready[0];
  assign intf_net_axi_interconnect_M01_AXI_BRESP = M01_AXI_bresp[1:0];
  assign intf_net_axi_interconnect_M01_AXI_BVALID = M01_AXI_bvalid[0];
  assign intf_net_axi_interconnect_M01_AXI_RDATA = M01_AXI_rdata[31:0];
  assign intf_net_axi_interconnect_M01_AXI_RRESP = M01_AXI_rresp[1:0];
  assign intf_net_axi_interconnect_M01_AXI_RVALID = M01_AXI_rvalid[0];
  assign intf_net_axi_interconnect_M01_AXI_WREADY = M01_AXI_wready[0];
  assign intf_net_axi_interconnect_M02_AXI_ARREADY = M02_AXI_arready[0];
  assign intf_net_axi_interconnect_M02_AXI_AWREADY = M02_AXI_awready[0];
  assign intf_net_axi_interconnect_M02_AXI_BRESP = M02_AXI_bresp[1:0];
  assign intf_net_axi_interconnect_M02_AXI_BVALID = M02_AXI_bvalid[0];
  assign intf_net_axi_interconnect_M02_AXI_RDATA = M02_AXI_rdata[31:0];
  assign intf_net_axi_interconnect_M02_AXI_RRESP = M02_AXI_rresp[1:0];
  assign intf_net_axi_interconnect_M02_AXI_RVALID = M02_AXI_rvalid[0];
  assign intf_net_axi_interconnect_M02_AXI_WREADY = M02_AXI_wready[0];
  assign intf_net_axi_interconnect_M05_AXI_ARREADY = M05_AXI_arready;
  assign intf_net_axi_interconnect_M05_AXI_AWREADY = M05_AXI_awready;
  assign intf_net_axi_interconnect_M05_AXI_BRESP = M05_AXI_bresp[1:0];
  assign intf_net_axi_interconnect_M05_AXI_BVALID = M05_AXI_bvalid;
  assign intf_net_axi_interconnect_M05_AXI_RDATA = M05_AXI_rdata[31:0];
  assign intf_net_axi_interconnect_M05_AXI_RRESP = M05_AXI_rresp[1:0];
  assign intf_net_axi_interconnect_M05_AXI_RVALID = M05_AXI_rvalid;
  assign intf_net_axi_interconnect_M05_AXI_WREADY = M05_AXI_wready;
  assign intf_net_axi_interconnect_M06_AXI_ARREADY = M06_AXI_arready[0];
  assign intf_net_axi_interconnect_M06_AXI_AWREADY = M06_AXI_awready[0];
  assign intf_net_axi_interconnect_M06_AXI_BRESP = M06_AXI_bresp[1:0];
  assign intf_net_axi_interconnect_M06_AXI_BVALID = M06_AXI_bvalid[0];
  assign intf_net_axi_interconnect_M06_AXI_RDATA = M06_AXI_rdata[31:0];
  assign intf_net_axi_interconnect_M06_AXI_RRESP = M06_AXI_rresp[1:0];
  assign intf_net_axi_interconnect_M06_AXI_RVALID = M06_AXI_rvalid[0];
  assign intf_net_axi_interconnect_M06_AXI_WREADY = M06_AXI_wready[0];
  assign intf_net_axi_interconnect_M08_AXI_ARREADY = M08_AXI_arready;
  assign intf_net_axi_interconnect_M08_AXI_AWREADY = M08_AXI_awready;
  assign intf_net_axi_interconnect_M08_AXI_BRESP = M08_AXI_bresp[1:0];
  assign intf_net_axi_interconnect_M08_AXI_BVALID = M08_AXI_bvalid;
  assign intf_net_axi_interconnect_M08_AXI_RDATA = M08_AXI_rdata[31:0];
  assign intf_net_axi_interconnect_M08_AXI_RRESP = M08_AXI_rresp[1:0];
  assign intf_net_axi_interconnect_M08_AXI_RVALID = M08_AXI_rvalid;
  assign intf_net_axi_interconnect_M08_AXI_WREADY = M08_AXI_wready;
  assign intf_net_axi_uartlite_UART_RxD = UART_rxd;
  assign intf_net_fmch_axi_iic_IIC_SCL_I = IIC_scl_i;
  assign intf_net_fmch_axi_iic_IIC_SDA_I = IIC_sda_i;
  assign net_bdry_in_ext_reset_in = ext_reset_in;
  assign net_bdry_in_hdmi_rx_irq = hdmi_rx_irq;
  assign net_bdry_in_hdmi_tx_irq = hdmi_tx_irq;
  assign net_bdry_in_vphy_irq = vphy_irq;
  assign peripheral_aresetn[0] = net_rst_processor_1_100M_peripheral_aresetn;
  assign s_axi_aclk = net_clk_wiz_clk_out1;
  exdes_axi_intc_0 axi_intc
       (.intr(net_xlconcat_dout),
        .irq(intf_net_axi_intc_interrupt_INTERRUPT),
        .s_axi_aclk(net_clk_wiz_clk_out1),
        .s_axi_araddr(intf_net_axi_interconnect_M07_AXI_ARADDR[8:0]),
        .s_axi_aresetn(net_rst_processor_1_100M_peripheral_aresetn),
        .s_axi_arready(intf_net_axi_interconnect_M07_AXI_ARREADY),
        .s_axi_arvalid(intf_net_axi_interconnect_M07_AXI_ARVALID),
        .s_axi_awaddr(intf_net_axi_interconnect_M07_AXI_AWADDR[8:0]),
        .s_axi_awready(intf_net_axi_interconnect_M07_AXI_AWREADY),
        .s_axi_awvalid(intf_net_axi_interconnect_M07_AXI_AWVALID),
        .s_axi_bready(intf_net_axi_interconnect_M07_AXI_BREADY),
        .s_axi_bresp(intf_net_axi_interconnect_M07_AXI_BRESP),
        .s_axi_bvalid(intf_net_axi_interconnect_M07_AXI_BVALID),
        .s_axi_rdata(intf_net_axi_interconnect_M07_AXI_RDATA),
        .s_axi_rready(intf_net_axi_interconnect_M07_AXI_RREADY),
        .s_axi_rresp(intf_net_axi_interconnect_M07_AXI_RRESP),
        .s_axi_rvalid(intf_net_axi_interconnect_M07_AXI_RVALID),
        .s_axi_wdata(intf_net_axi_interconnect_M07_AXI_WDATA),
        .s_axi_wready(intf_net_axi_interconnect_M07_AXI_WREADY),
        .s_axi_wstrb(intf_net_axi_interconnect_M07_AXI_WSTRB),
        .s_axi_wvalid(intf_net_axi_interconnect_M07_AXI_WVALID));
  exdes_axi_interconnect_1 axi_interconnect
       (.ACLK(net_clk_wiz_clk_out1),
        .ARESETN(net_rst_processor_1_100M_interconnect_aresetn),
        .M00_ACLK(net_clk_wiz_clk_out1),
        .M00_ARESETN(net_rst_processor_1_100M_peripheral_aresetn),
        .M00_AXI_araddr(intf_net_axi_interconnect_M00_AXI_ARADDR),
        .M00_AXI_arprot(intf_net_axi_interconnect_M00_AXI_ARPROT),
        .M00_AXI_arready(intf_net_axi_interconnect_M00_AXI_ARREADY),
        .M00_AXI_arvalid(intf_net_axi_interconnect_M00_AXI_ARVALID),
        .M00_AXI_awaddr(intf_net_axi_interconnect_M00_AXI_AWADDR),
        .M00_AXI_awprot(intf_net_axi_interconnect_M00_AXI_AWPROT),
        .M00_AXI_awready(intf_net_axi_interconnect_M00_AXI_AWREADY),
        .M00_AXI_awvalid(intf_net_axi_interconnect_M00_AXI_AWVALID),
        .M00_AXI_bready(intf_net_axi_interconnect_M00_AXI_BREADY),
        .M00_AXI_bresp(intf_net_axi_interconnect_M00_AXI_BRESP),
        .M00_AXI_bvalid(intf_net_axi_interconnect_M00_AXI_BVALID),
        .M00_AXI_rdata(intf_net_axi_interconnect_M00_AXI_RDATA),
        .M00_AXI_rready(intf_net_axi_interconnect_M00_AXI_RREADY),
        .M00_AXI_rresp(intf_net_axi_interconnect_M00_AXI_RRESP),
        .M00_AXI_rvalid(intf_net_axi_interconnect_M00_AXI_RVALID),
        .M00_AXI_wdata(intf_net_axi_interconnect_M00_AXI_WDATA),
        .M00_AXI_wready(intf_net_axi_interconnect_M00_AXI_WREADY),
        .M00_AXI_wstrb(intf_net_axi_interconnect_M00_AXI_WSTRB),
        .M00_AXI_wvalid(intf_net_axi_interconnect_M00_AXI_WVALID),
        .M01_ACLK(net_clk_wiz_clk_out1),
        .M01_ARESETN(net_rst_processor_1_100M_peripheral_aresetn),
        .M01_AXI_araddr(intf_net_axi_interconnect_M01_AXI_ARADDR),
        .M01_AXI_arprot(intf_net_axi_interconnect_M01_AXI_ARPROT),
        .M01_AXI_arready(intf_net_axi_interconnect_M01_AXI_ARREADY),
        .M01_AXI_arvalid(intf_net_axi_interconnect_M01_AXI_ARVALID),
        .M01_AXI_awaddr(intf_net_axi_interconnect_M01_AXI_AWADDR),
        .M01_AXI_awprot(intf_net_axi_interconnect_M01_AXI_AWPROT),
        .M01_AXI_awready(intf_net_axi_interconnect_M01_AXI_AWREADY),
        .M01_AXI_awvalid(intf_net_axi_interconnect_M01_AXI_AWVALID),
        .M01_AXI_bready(intf_net_axi_interconnect_M01_AXI_BREADY),
        .M01_AXI_bresp(intf_net_axi_interconnect_M01_AXI_BRESP),
        .M01_AXI_bvalid(intf_net_axi_interconnect_M01_AXI_BVALID),
        .M01_AXI_rdata(intf_net_axi_interconnect_M01_AXI_RDATA),
        .M01_AXI_rready(intf_net_axi_interconnect_M01_AXI_RREADY),
        .M01_AXI_rresp(intf_net_axi_interconnect_M01_AXI_RRESP),
        .M01_AXI_rvalid(intf_net_axi_interconnect_M01_AXI_RVALID),
        .M01_AXI_wdata(intf_net_axi_interconnect_M01_AXI_WDATA),
        .M01_AXI_wready(intf_net_axi_interconnect_M01_AXI_WREADY),
        .M01_AXI_wstrb(intf_net_axi_interconnect_M01_AXI_WSTRB),
        .M01_AXI_wvalid(intf_net_axi_interconnect_M01_AXI_WVALID),
        .M02_ACLK(net_clk_wiz_clk_out1),
        .M02_ARESETN(net_rst_processor_1_100M_peripheral_aresetn),
        .M02_AXI_araddr(intf_net_axi_interconnect_M02_AXI_ARADDR),
        .M02_AXI_arprot(intf_net_axi_interconnect_M02_AXI_ARPROT),
        .M02_AXI_arready(intf_net_axi_interconnect_M02_AXI_ARREADY),
        .M02_AXI_arvalid(intf_net_axi_interconnect_M02_AXI_ARVALID),
        .M02_AXI_awaddr(intf_net_axi_interconnect_M02_AXI_AWADDR),
        .M02_AXI_awprot(intf_net_axi_interconnect_M02_AXI_AWPROT),
        .M02_AXI_awready(intf_net_axi_interconnect_M02_AXI_AWREADY),
        .M02_AXI_awvalid(intf_net_axi_interconnect_M02_AXI_AWVALID),
        .M02_AXI_bready(intf_net_axi_interconnect_M02_AXI_BREADY),
        .M02_AXI_bresp(intf_net_axi_interconnect_M02_AXI_BRESP),
        .M02_AXI_bvalid(intf_net_axi_interconnect_M02_AXI_BVALID),
        .M02_AXI_rdata(intf_net_axi_interconnect_M02_AXI_RDATA),
        .M02_AXI_rready(intf_net_axi_interconnect_M02_AXI_RREADY),
        .M02_AXI_rresp(intf_net_axi_interconnect_M02_AXI_RRESP),
        .M02_AXI_rvalid(intf_net_axi_interconnect_M02_AXI_RVALID),
        .M02_AXI_wdata(intf_net_axi_interconnect_M02_AXI_WDATA),
        .M02_AXI_wready(intf_net_axi_interconnect_M02_AXI_WREADY),
        .M02_AXI_wstrb(intf_net_axi_interconnect_M02_AXI_WSTRB),
        .M02_AXI_wvalid(intf_net_axi_interconnect_M02_AXI_WVALID),
        .M03_ACLK(net_clk_wiz_clk_out1),
        .M03_ARESETN(net_rst_processor_1_100M_peripheral_aresetn),
        .M03_AXI_araddr(intf_net_axi_interconnect_M03_AXI_ARADDR),
        .M03_AXI_arready(intf_net_axi_interconnect_M03_AXI_ARREADY),
        .M03_AXI_arvalid(intf_net_axi_interconnect_M03_AXI_ARVALID),
        .M03_AXI_awaddr(intf_net_axi_interconnect_M03_AXI_AWADDR),
        .M03_AXI_awready(intf_net_axi_interconnect_M03_AXI_AWREADY),
        .M03_AXI_awvalid(intf_net_axi_interconnect_M03_AXI_AWVALID),
        .M03_AXI_bready(intf_net_axi_interconnect_M03_AXI_BREADY),
        .M03_AXI_bresp(intf_net_axi_interconnect_M03_AXI_BRESP),
        .M03_AXI_bvalid(intf_net_axi_interconnect_M03_AXI_BVALID),
        .M03_AXI_rdata(intf_net_axi_interconnect_M03_AXI_RDATA),
        .M03_AXI_rready(intf_net_axi_interconnect_M03_AXI_RREADY),
        .M03_AXI_rresp(intf_net_axi_interconnect_M03_AXI_RRESP),
        .M03_AXI_rvalid(intf_net_axi_interconnect_M03_AXI_RVALID),
        .M03_AXI_wdata(intf_net_axi_interconnect_M03_AXI_WDATA),
        .M03_AXI_wready(intf_net_axi_interconnect_M03_AXI_WREADY),
        .M03_AXI_wstrb(intf_net_axi_interconnect_M03_AXI_WSTRB),
        .M03_AXI_wvalid(intf_net_axi_interconnect_M03_AXI_WVALID),
        .M04_ACLK(net_clk_wiz_clk_out1),
        .M04_ARESETN(net_rst_processor_1_100M_peripheral_aresetn),
        .M04_AXI_araddr(intf_net_axi_interconnect_M04_AXI_ARADDR),
        .M04_AXI_arready(intf_net_axi_interconnect_M04_AXI_ARREADY),
        .M04_AXI_arvalid(intf_net_axi_interconnect_M04_AXI_ARVALID),
        .M04_AXI_awaddr(intf_net_axi_interconnect_M04_AXI_AWADDR),
        .M04_AXI_awready(intf_net_axi_interconnect_M04_AXI_AWREADY),
        .M04_AXI_awvalid(intf_net_axi_interconnect_M04_AXI_AWVALID),
        .M04_AXI_bready(intf_net_axi_interconnect_M04_AXI_BREADY),
        .M04_AXI_bresp(intf_net_axi_interconnect_M04_AXI_BRESP),
        .M04_AXI_bvalid(intf_net_axi_interconnect_M04_AXI_BVALID),
        .M04_AXI_rdata(intf_net_axi_interconnect_M04_AXI_RDATA),
        .M04_AXI_rready(intf_net_axi_interconnect_M04_AXI_RREADY),
        .M04_AXI_rresp(intf_net_axi_interconnect_M04_AXI_RRESP),
        .M04_AXI_rvalid(intf_net_axi_interconnect_M04_AXI_RVALID),
        .M04_AXI_wdata(intf_net_axi_interconnect_M04_AXI_WDATA),
        .M04_AXI_wready(intf_net_axi_interconnect_M04_AXI_WREADY),
        .M04_AXI_wstrb(intf_net_axi_interconnect_M04_AXI_WSTRB),
        .M04_AXI_wvalid(intf_net_axi_interconnect_M04_AXI_WVALID),
        .M05_ACLK(net_clk_wiz_clk_out2),
        .M05_ARESETN(net_rst_processor_1_300M_interconnect_aresetn),
        .M05_AXI_araddr(intf_net_axi_interconnect_M05_AXI_ARADDR),
        .M05_AXI_arready(intf_net_axi_interconnect_M05_AXI_ARREADY),
        .M05_AXI_arvalid(intf_net_axi_interconnect_M05_AXI_ARVALID),
        .M05_AXI_awaddr(intf_net_axi_interconnect_M05_AXI_AWADDR),
        .M05_AXI_awready(intf_net_axi_interconnect_M05_AXI_AWREADY),
        .M05_AXI_awvalid(intf_net_axi_interconnect_M05_AXI_AWVALID),
        .M05_AXI_bready(intf_net_axi_interconnect_M05_AXI_BREADY),
        .M05_AXI_bresp(intf_net_axi_interconnect_M05_AXI_BRESP),
        .M05_AXI_bvalid(intf_net_axi_interconnect_M05_AXI_BVALID),
        .M05_AXI_rdata(intf_net_axi_interconnect_M05_AXI_RDATA),
        .M05_AXI_rready(intf_net_axi_interconnect_M05_AXI_RREADY),
        .M05_AXI_rresp(intf_net_axi_interconnect_M05_AXI_RRESP),
        .M05_AXI_rvalid(intf_net_axi_interconnect_M05_AXI_RVALID),
        .M05_AXI_wdata(intf_net_axi_interconnect_M05_AXI_WDATA),
        .M05_AXI_wready(intf_net_axi_interconnect_M05_AXI_WREADY),
        .M05_AXI_wstrb(intf_net_axi_interconnect_M05_AXI_WSTRB),
        .M05_AXI_wvalid(intf_net_axi_interconnect_M05_AXI_WVALID),
        .M06_ACLK(net_clk_wiz_clk_out1),
        .M06_ARESETN(net_rst_processor_1_100M_peripheral_aresetn),
        .M06_AXI_araddr(intf_net_axi_interconnect_M06_AXI_ARADDR),
        .M06_AXI_arprot(intf_net_axi_interconnect_M06_AXI_ARPROT),
        .M06_AXI_arready(intf_net_axi_interconnect_M06_AXI_ARREADY),
        .M06_AXI_arvalid(intf_net_axi_interconnect_M06_AXI_ARVALID),
        .M06_AXI_awaddr(intf_net_axi_interconnect_M06_AXI_AWADDR),
        .M06_AXI_awprot(intf_net_axi_interconnect_M06_AXI_AWPROT),
        .M06_AXI_awready(intf_net_axi_interconnect_M06_AXI_AWREADY),
        .M06_AXI_awvalid(intf_net_axi_interconnect_M06_AXI_AWVALID),
        .M06_AXI_bready(intf_net_axi_interconnect_M06_AXI_BREADY),
        .M06_AXI_bresp(intf_net_axi_interconnect_M06_AXI_BRESP),
        .M06_AXI_bvalid(intf_net_axi_interconnect_M06_AXI_BVALID),
        .M06_AXI_rdata(intf_net_axi_interconnect_M06_AXI_RDATA),
        .M06_AXI_rready(intf_net_axi_interconnect_M06_AXI_RREADY),
        .M06_AXI_rresp(intf_net_axi_interconnect_M06_AXI_RRESP),
        .M06_AXI_rvalid(intf_net_axi_interconnect_M06_AXI_RVALID),
        .M06_AXI_wdata(intf_net_axi_interconnect_M06_AXI_WDATA),
        .M06_AXI_wready(intf_net_axi_interconnect_M06_AXI_WREADY),
        .M06_AXI_wstrb(intf_net_axi_interconnect_M06_AXI_WSTRB),
        .M06_AXI_wvalid(intf_net_axi_interconnect_M06_AXI_WVALID),
        .M07_ACLK(net_clk_wiz_clk_out1),
        .M07_ARESETN(net_rst_processor_1_100M_peripheral_aresetn),
        .M07_AXI_araddr(intf_net_axi_interconnect_M07_AXI_ARADDR),
        .M07_AXI_arready(intf_net_axi_interconnect_M07_AXI_ARREADY),
        .M07_AXI_arvalid(intf_net_axi_interconnect_M07_AXI_ARVALID),
        .M07_AXI_awaddr(intf_net_axi_interconnect_M07_AXI_AWADDR),
        .M07_AXI_awready(intf_net_axi_interconnect_M07_AXI_AWREADY),
        .M07_AXI_awvalid(intf_net_axi_interconnect_M07_AXI_AWVALID),
        .M07_AXI_bready(intf_net_axi_interconnect_M07_AXI_BREADY),
        .M07_AXI_bresp(intf_net_axi_interconnect_M07_AXI_BRESP),
        .M07_AXI_bvalid(intf_net_axi_interconnect_M07_AXI_BVALID),
        .M07_AXI_rdata(intf_net_axi_interconnect_M07_AXI_RDATA),
        .M07_AXI_rready(intf_net_axi_interconnect_M07_AXI_RREADY),
        .M07_AXI_rresp(intf_net_axi_interconnect_M07_AXI_RRESP),
        .M07_AXI_rvalid(intf_net_axi_interconnect_M07_AXI_RVALID),
        .M07_AXI_wdata(intf_net_axi_interconnect_M07_AXI_WDATA),
        .M07_AXI_wready(intf_net_axi_interconnect_M07_AXI_WREADY),
        .M07_AXI_wstrb(intf_net_axi_interconnect_M07_AXI_WSTRB),
        .M07_AXI_wvalid(intf_net_axi_interconnect_M07_AXI_WVALID),
        .M08_ACLK(net_clk_wiz_clk_out2),
        .M08_ARESETN(net_rst_processor_1_300M_interconnect_aresetn),
        .M08_AXI_araddr(intf_net_axi_interconnect_M08_AXI_ARADDR),
        .M08_AXI_arready(intf_net_axi_interconnect_M08_AXI_ARREADY),
        .M08_AXI_arvalid(intf_net_axi_interconnect_M08_AXI_ARVALID),
        .M08_AXI_awaddr(intf_net_axi_interconnect_M08_AXI_AWADDR),
        .M08_AXI_awready(intf_net_axi_interconnect_M08_AXI_AWREADY),
        .M08_AXI_awvalid(intf_net_axi_interconnect_M08_AXI_AWVALID),
        .M08_AXI_bready(intf_net_axi_interconnect_M08_AXI_BREADY),
        .M08_AXI_bresp(intf_net_axi_interconnect_M08_AXI_BRESP),
        .M08_AXI_bvalid(intf_net_axi_interconnect_M08_AXI_BVALID),
        .M08_AXI_rdata(intf_net_axi_interconnect_M08_AXI_RDATA),
        .M08_AXI_rready(intf_net_axi_interconnect_M08_AXI_RREADY),
        .M08_AXI_rresp(intf_net_axi_interconnect_M08_AXI_RRESP),
        .M08_AXI_rvalid(intf_net_axi_interconnect_M08_AXI_RVALID),
        .M08_AXI_wdata(intf_net_axi_interconnect_M08_AXI_WDATA),
        .M08_AXI_wready(intf_net_axi_interconnect_M08_AXI_WREADY),
        .M08_AXI_wstrb(intf_net_axi_interconnect_M08_AXI_WSTRB),
        .M08_AXI_wvalid(intf_net_axi_interconnect_M08_AXI_WVALID),
        .S00_ACLK(net_clk_wiz_clk_out1),
        .S00_ARESETN(net_rst_processor_1_100M_peripheral_aresetn),
        .S00_AXI_araddr(intf_net_mblaze_M_AXI_DP_ARADDR),
        .S00_AXI_arprot(intf_net_mblaze_M_AXI_DP_ARPROT),
        .S00_AXI_arready(intf_net_mblaze_M_AXI_DP_ARREADY),
        .S00_AXI_arvalid(intf_net_mblaze_M_AXI_DP_ARVALID),
        .S00_AXI_awaddr(intf_net_mblaze_M_AXI_DP_AWADDR),
        .S00_AXI_awprot(intf_net_mblaze_M_AXI_DP_AWPROT),
        .S00_AXI_awready(intf_net_mblaze_M_AXI_DP_AWREADY),
        .S00_AXI_awvalid(intf_net_mblaze_M_AXI_DP_AWVALID),
        .S00_AXI_bready(intf_net_mblaze_M_AXI_DP_BREADY),
        .S00_AXI_bresp(intf_net_mblaze_M_AXI_DP_BRESP),
        .S00_AXI_bvalid(intf_net_mblaze_M_AXI_DP_BVALID),
        .S00_AXI_rdata(intf_net_mblaze_M_AXI_DP_RDATA),
        .S00_AXI_rready(intf_net_mblaze_M_AXI_DP_RREADY),
        .S00_AXI_rresp(intf_net_mblaze_M_AXI_DP_RRESP),
        .S00_AXI_rvalid(intf_net_mblaze_M_AXI_DP_RVALID),
        .S00_AXI_wdata(intf_net_mblaze_M_AXI_DP_WDATA),
        .S00_AXI_wready(intf_net_mblaze_M_AXI_DP_WREADY),
        .S00_AXI_wstrb(intf_net_mblaze_M_AXI_DP_WSTRB),
        .S00_AXI_wvalid(intf_net_mblaze_M_AXI_DP_WVALID));
  exdes_axi_uartlite_0 axi_uartlite
       (.rx(intf_net_axi_uartlite_UART_RxD),
        .s_axi_aclk(net_clk_wiz_clk_out1),
        .s_axi_araddr(intf_net_axi_interconnect_M03_AXI_ARADDR[3:0]),
        .s_axi_aresetn(net_rst_processor_1_100M_peripheral_aresetn),
        .s_axi_arready(intf_net_axi_interconnect_M03_AXI_ARREADY),
        .s_axi_arvalid(intf_net_axi_interconnect_M03_AXI_ARVALID),
        .s_axi_awaddr(intf_net_axi_interconnect_M03_AXI_AWADDR[3:0]),
        .s_axi_awready(intf_net_axi_interconnect_M03_AXI_AWREADY),
        .s_axi_awvalid(intf_net_axi_interconnect_M03_AXI_AWVALID),
        .s_axi_bready(intf_net_axi_interconnect_M03_AXI_BREADY),
        .s_axi_bresp(intf_net_axi_interconnect_M03_AXI_BRESP),
        .s_axi_bvalid(intf_net_axi_interconnect_M03_AXI_BVALID),
        .s_axi_rdata(intf_net_axi_interconnect_M03_AXI_RDATA),
        .s_axi_rready(intf_net_axi_interconnect_M03_AXI_RREADY),
        .s_axi_rresp(intf_net_axi_interconnect_M03_AXI_RRESP),
        .s_axi_rvalid(intf_net_axi_interconnect_M03_AXI_RVALID),
        .s_axi_wdata(intf_net_axi_interconnect_M03_AXI_WDATA),
        .s_axi_wready(intf_net_axi_interconnect_M03_AXI_WREADY),
        .s_axi_wstrb(intf_net_axi_interconnect_M03_AXI_WSTRB),
        .s_axi_wvalid(intf_net_axi_interconnect_M03_AXI_WVALID),
        .tx(intf_net_axi_uartlite_UART_TxD));
  exdes_clk_wiz_1 clk_wiz
       (.clk_in1_n(Conn1_CLK_N),
        .clk_in1_p(Conn1_CLK_P),
        .clk_out1(net_clk_wiz_clk_out1),
        .clk_out2(net_clk_wiz_clk_out2),
        .locked(net_clk_wiz_locked),
        .reset(net_bdry_in_ext_reset_in));
  (* BMM_INFO_ADDRESS_SPACE = "byte  0x00000000 32 > exdes mb_ss_0/lmb_bram" *) 
  (* KEEP_HIERARCHY = "yes" *) 
  exdes_dlmb_bram_if_cntlr_0 dlmb_bram_if_cntlr
       (.BRAM_Addr_A(intf_net_dlmb_bram_if_cntlr_BRAM_PORT_ADDR),
        .BRAM_Clk_A(intf_net_dlmb_bram_if_cntlr_BRAM_PORT_CLK),
        .BRAM_Din_A({intf_net_dlmb_bram_if_cntlr_BRAM_PORT_DOUT[31],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_DOUT[30],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_DOUT[29],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_DOUT[28],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_DOUT[27],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_DOUT[26],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_DOUT[25],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_DOUT[24],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_DOUT[23],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_DOUT[22],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_DOUT[21],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_DOUT[20],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_DOUT[19],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_DOUT[18],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_DOUT[17],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_DOUT[16],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_DOUT[15],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_DOUT[14],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_DOUT[13],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_DOUT[12],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_DOUT[11],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_DOUT[10],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_DOUT[9],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_DOUT[8],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_DOUT[7],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_DOUT[6],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_DOUT[5],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_DOUT[4],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_DOUT[3],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_DOUT[2],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_DOUT[1],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_DOUT[0]}),
        .BRAM_Dout_A(intf_net_dlmb_bram_if_cntlr_BRAM_PORT_DIN),
        .BRAM_EN_A(intf_net_dlmb_bram_if_cntlr_BRAM_PORT_EN),
        .BRAM_Rst_A(intf_net_dlmb_bram_if_cntlr_BRAM_PORT_RST),
        .BRAM_WEN_A(intf_net_dlmb_bram_if_cntlr_BRAM_PORT_WE),
        .LMB_ABus(intf_net_dlmb_v10_LMB_Sl_0_ABUS),
        .LMB_AddrStrobe(intf_net_dlmb_v10_LMB_Sl_0_ADDRSTROBE),
        .LMB_BE(intf_net_dlmb_v10_LMB_Sl_0_BE),
        .LMB_Clk(net_clk_wiz_clk_out1),
        .LMB_ReadStrobe(intf_net_dlmb_v10_LMB_Sl_0_READSTROBE),
        .LMB_Rst(net_rst_processor_1_100M_bus_struct_reset),
        .LMB_WriteDBus(intf_net_dlmb_v10_LMB_Sl_0_WRITEDBUS),
        .LMB_WriteStrobe(intf_net_dlmb_v10_LMB_Sl_0_WRITESTROBE),
        .Sl_CE(intf_net_dlmb_v10_LMB_Sl_0_CE),
        .Sl_DBus(intf_net_dlmb_v10_LMB_Sl_0_READDBUS),
        .Sl_Ready(intf_net_dlmb_v10_LMB_Sl_0_READY),
        .Sl_UE(intf_net_dlmb_v10_LMB_Sl_0_UE),
        .Sl_Wait(intf_net_dlmb_v10_LMB_Sl_0_WAIT));
  exdes_dlmb_v10_0 dlmb_v10
       (.LMB_ABus(intf_net_dlmb_v10_LMB_Sl_0_ABUS),
        .LMB_AddrStrobe(intf_net_dlmb_v10_LMB_Sl_0_ADDRSTROBE),
        .LMB_BE(intf_net_dlmb_v10_LMB_Sl_0_BE),
        .LMB_CE(intf_net_mblaze_DLMB_CE),
        .LMB_Clk(net_clk_wiz_clk_out1),
        .LMB_ReadDBus(intf_net_mblaze_DLMB_READDBUS),
        .LMB_ReadStrobe(intf_net_dlmb_v10_LMB_Sl_0_READSTROBE),
        .LMB_Ready(intf_net_mblaze_DLMB_READY),
        .LMB_UE(intf_net_mblaze_DLMB_UE),
        .LMB_Wait(intf_net_mblaze_DLMB_WAIT),
        .LMB_WriteDBus(intf_net_dlmb_v10_LMB_Sl_0_WRITEDBUS),
        .LMB_WriteStrobe(intf_net_dlmb_v10_LMB_Sl_0_WRITESTROBE),
        .M_ABus(intf_net_mblaze_DLMB_ABUS),
        .M_AddrStrobe(intf_net_mblaze_DLMB_ADDRSTROBE),
        .M_BE(intf_net_mblaze_DLMB_BE),
        .M_DBus(intf_net_mblaze_DLMB_WRITEDBUS),
        .M_ReadStrobe(intf_net_mblaze_DLMB_READSTROBE),
        .M_WriteStrobe(intf_net_mblaze_DLMB_WRITESTROBE),
        .SYS_Rst(net_rst_processor_1_100M_bus_struct_reset),
        .Sl_CE(intf_net_dlmb_v10_LMB_Sl_0_CE),
        .Sl_DBus(intf_net_dlmb_v10_LMB_Sl_0_READDBUS),
        .Sl_Ready(intf_net_dlmb_v10_LMB_Sl_0_READY),
        .Sl_UE(intf_net_dlmb_v10_LMB_Sl_0_UE),
        .Sl_Wait(intf_net_dlmb_v10_LMB_Sl_0_WAIT));
  exdes_fmch_axi_iic_0 fmch_axi_iic
       (.s_axi_aclk(net_clk_wiz_clk_out1),
        .s_axi_araddr(intf_net_axi_interconnect_M04_AXI_ARADDR[8:0]),
        .s_axi_aresetn(net_rst_processor_1_100M_peripheral_aresetn),
        .s_axi_arready(intf_net_axi_interconnect_M04_AXI_ARREADY),
        .s_axi_arvalid(intf_net_axi_interconnect_M04_AXI_ARVALID),
        .s_axi_awaddr(intf_net_axi_interconnect_M04_AXI_AWADDR[8:0]),
        .s_axi_awready(intf_net_axi_interconnect_M04_AXI_AWREADY),
        .s_axi_awvalid(intf_net_axi_interconnect_M04_AXI_AWVALID),
        .s_axi_bready(intf_net_axi_interconnect_M04_AXI_BREADY),
        .s_axi_bresp(intf_net_axi_interconnect_M04_AXI_BRESP),
        .s_axi_bvalid(intf_net_axi_interconnect_M04_AXI_BVALID),
        .s_axi_rdata(intf_net_axi_interconnect_M04_AXI_RDATA),
        .s_axi_rready(intf_net_axi_interconnect_M04_AXI_RREADY),
        .s_axi_rresp(intf_net_axi_interconnect_M04_AXI_RRESP),
        .s_axi_rvalid(intf_net_axi_interconnect_M04_AXI_RVALID),
        .s_axi_wdata(intf_net_axi_interconnect_M04_AXI_WDATA),
        .s_axi_wready(intf_net_axi_interconnect_M04_AXI_WREADY),
        .s_axi_wstrb(intf_net_axi_interconnect_M04_AXI_WSTRB),
        .s_axi_wvalid(intf_net_axi_interconnect_M04_AXI_WVALID),
        .scl_i(intf_net_fmch_axi_iic_IIC_SCL_I),
        .scl_o(intf_net_fmch_axi_iic_IIC_SCL_O),
        .scl_t(intf_net_fmch_axi_iic_IIC_SCL_T),
        .sda_i(intf_net_fmch_axi_iic_IIC_SDA_I),
        .sda_o(intf_net_fmch_axi_iic_IIC_SDA_O),
        .sda_t(intf_net_fmch_axi_iic_IIC_SDA_T));
  exdes_ilmb_bram_if_cntlr_0 ilmb_bram_if_cntlr
       (.BRAM_Addr_A(intf_net_ilmb_bram_if_cntlr_BRAM_PORT_ADDR),
        .BRAM_Clk_A(intf_net_ilmb_bram_if_cntlr_BRAM_PORT_CLK),
        .BRAM_Din_A({intf_net_ilmb_bram_if_cntlr_BRAM_PORT_DOUT[31],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_DOUT[30],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_DOUT[29],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_DOUT[28],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_DOUT[27],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_DOUT[26],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_DOUT[25],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_DOUT[24],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_DOUT[23],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_DOUT[22],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_DOUT[21],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_DOUT[20],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_DOUT[19],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_DOUT[18],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_DOUT[17],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_DOUT[16],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_DOUT[15],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_DOUT[14],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_DOUT[13],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_DOUT[12],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_DOUT[11],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_DOUT[10],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_DOUT[9],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_DOUT[8],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_DOUT[7],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_DOUT[6],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_DOUT[5],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_DOUT[4],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_DOUT[3],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_DOUT[2],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_DOUT[1],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_DOUT[0]}),
        .BRAM_Dout_A(intf_net_ilmb_bram_if_cntlr_BRAM_PORT_DIN),
        .BRAM_EN_A(intf_net_ilmb_bram_if_cntlr_BRAM_PORT_EN),
        .BRAM_Rst_A(intf_net_ilmb_bram_if_cntlr_BRAM_PORT_RST),
        .BRAM_WEN_A(intf_net_ilmb_bram_if_cntlr_BRAM_PORT_WE),
        .LMB_ABus(intf_net_ilmb_v10_LMB_Sl_0_ABUS),
        .LMB_AddrStrobe(intf_net_ilmb_v10_LMB_Sl_0_ADDRSTROBE),
        .LMB_BE(intf_net_ilmb_v10_LMB_Sl_0_BE),
        .LMB_Clk(net_clk_wiz_clk_out1),
        .LMB_ReadStrobe(intf_net_ilmb_v10_LMB_Sl_0_READSTROBE),
        .LMB_Rst(net_rst_processor_1_100M_bus_struct_reset),
        .LMB_WriteDBus(intf_net_ilmb_v10_LMB_Sl_0_WRITEDBUS),
        .LMB_WriteStrobe(intf_net_ilmb_v10_LMB_Sl_0_WRITESTROBE),
        .Sl_CE(intf_net_ilmb_v10_LMB_Sl_0_CE),
        .Sl_DBus(intf_net_ilmb_v10_LMB_Sl_0_READDBUS),
        .Sl_Ready(intf_net_ilmb_v10_LMB_Sl_0_READY),
        .Sl_UE(intf_net_ilmb_v10_LMB_Sl_0_UE),
        .Sl_Wait(intf_net_ilmb_v10_LMB_Sl_0_WAIT));
  exdes_ilmb_v10_0 ilmb_v10
       (.LMB_ABus(intf_net_ilmb_v10_LMB_Sl_0_ABUS),
        .LMB_AddrStrobe(intf_net_ilmb_v10_LMB_Sl_0_ADDRSTROBE),
        .LMB_BE(intf_net_ilmb_v10_LMB_Sl_0_BE),
        .LMB_CE(intf_net_mblaze_ILMB_CE),
        .LMB_Clk(net_clk_wiz_clk_out1),
        .LMB_ReadDBus(intf_net_mblaze_ILMB_READDBUS),
        .LMB_ReadStrobe(intf_net_ilmb_v10_LMB_Sl_0_READSTROBE),
        .LMB_Ready(intf_net_mblaze_ILMB_READY),
        .LMB_UE(intf_net_mblaze_ILMB_UE),
        .LMB_Wait(intf_net_mblaze_ILMB_WAIT),
        .LMB_WriteDBus(intf_net_ilmb_v10_LMB_Sl_0_WRITEDBUS),
        .LMB_WriteStrobe(intf_net_ilmb_v10_LMB_Sl_0_WRITESTROBE),
        .M_ABus(intf_net_mblaze_ILMB_ABUS),
        .M_AddrStrobe(intf_net_mblaze_ILMB_ADDRSTROBE),
        .M_BE({1'b0,1'b0,1'b0,1'b0}),
        .M_DBus({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .M_ReadStrobe(intf_net_mblaze_ILMB_READSTROBE),
        .M_WriteStrobe(1'b0),
        .SYS_Rst(net_rst_processor_1_100M_bus_struct_reset),
        .Sl_CE(intf_net_ilmb_v10_LMB_Sl_0_CE),
        .Sl_DBus(intf_net_ilmb_v10_LMB_Sl_0_READDBUS),
        .Sl_Ready(intf_net_ilmb_v10_LMB_Sl_0_READY),
        .Sl_UE(intf_net_ilmb_v10_LMB_Sl_0_UE),
        .Sl_Wait(intf_net_ilmb_v10_LMB_Sl_0_WAIT));
  exdes_lmb_bram_0 lmb_bram
       (.addra({intf_net_dlmb_bram_if_cntlr_BRAM_PORT_ADDR[0],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_ADDR[1],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_ADDR[2],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_ADDR[3],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_ADDR[4],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_ADDR[5],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_ADDR[6],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_ADDR[7],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_ADDR[8],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_ADDR[9],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_ADDR[10],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_ADDR[11],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_ADDR[12],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_ADDR[13],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_ADDR[14],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_ADDR[15],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_ADDR[16],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_ADDR[17],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_ADDR[18],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_ADDR[19],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_ADDR[20],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_ADDR[21],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_ADDR[22],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_ADDR[23],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_ADDR[24],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_ADDR[25],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_ADDR[26],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_ADDR[27],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_ADDR[28],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_ADDR[29],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_ADDR[30],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_ADDR[31]}),
        .addrb({intf_net_ilmb_bram_if_cntlr_BRAM_PORT_ADDR[0],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_ADDR[1],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_ADDR[2],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_ADDR[3],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_ADDR[4],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_ADDR[5],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_ADDR[6],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_ADDR[7],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_ADDR[8],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_ADDR[9],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_ADDR[10],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_ADDR[11],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_ADDR[12],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_ADDR[13],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_ADDR[14],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_ADDR[15],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_ADDR[16],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_ADDR[17],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_ADDR[18],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_ADDR[19],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_ADDR[20],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_ADDR[21],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_ADDR[22],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_ADDR[23],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_ADDR[24],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_ADDR[25],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_ADDR[26],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_ADDR[27],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_ADDR[28],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_ADDR[29],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_ADDR[30],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_ADDR[31]}),
        .clka(intf_net_dlmb_bram_if_cntlr_BRAM_PORT_CLK),
        .clkb(intf_net_ilmb_bram_if_cntlr_BRAM_PORT_CLK),
        .dina({intf_net_dlmb_bram_if_cntlr_BRAM_PORT_DIN[0],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_DIN[1],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_DIN[2],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_DIN[3],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_DIN[4],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_DIN[5],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_DIN[6],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_DIN[7],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_DIN[8],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_DIN[9],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_DIN[10],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_DIN[11],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_DIN[12],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_DIN[13],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_DIN[14],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_DIN[15],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_DIN[16],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_DIN[17],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_DIN[18],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_DIN[19],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_DIN[20],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_DIN[21],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_DIN[22],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_DIN[23],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_DIN[24],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_DIN[25],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_DIN[26],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_DIN[27],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_DIN[28],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_DIN[29],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_DIN[30],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_DIN[31]}),
        .dinb({intf_net_ilmb_bram_if_cntlr_BRAM_PORT_DIN[0],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_DIN[1],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_DIN[2],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_DIN[3],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_DIN[4],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_DIN[5],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_DIN[6],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_DIN[7],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_DIN[8],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_DIN[9],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_DIN[10],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_DIN[11],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_DIN[12],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_DIN[13],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_DIN[14],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_DIN[15],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_DIN[16],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_DIN[17],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_DIN[18],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_DIN[19],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_DIN[20],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_DIN[21],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_DIN[22],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_DIN[23],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_DIN[24],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_DIN[25],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_DIN[26],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_DIN[27],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_DIN[28],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_DIN[29],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_DIN[30],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_DIN[31]}),
        .douta(intf_net_dlmb_bram_if_cntlr_BRAM_PORT_DOUT),
        .doutb(intf_net_ilmb_bram_if_cntlr_BRAM_PORT_DOUT),
        .ena(intf_net_dlmb_bram_if_cntlr_BRAM_PORT_EN),
        .enb(intf_net_ilmb_bram_if_cntlr_BRAM_PORT_EN),
        .rsta(intf_net_dlmb_bram_if_cntlr_BRAM_PORT_RST),
        .rstb(intf_net_ilmb_bram_if_cntlr_BRAM_PORT_RST),
        .wea({intf_net_dlmb_bram_if_cntlr_BRAM_PORT_WE[0],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_WE[1],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_WE[2],intf_net_dlmb_bram_if_cntlr_BRAM_PORT_WE[3]}),
        .web({intf_net_ilmb_bram_if_cntlr_BRAM_PORT_WE[0],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_WE[1],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_WE[2],intf_net_ilmb_bram_if_cntlr_BRAM_PORT_WE[3]}));
  (* BMM_INFO_PROCESSOR = "microblaze-le > exdes mb_ss_0/dlmb_bram_if_cntlr" *) 
  (* KEEP_HIERARCHY = "yes" *) 
  exdes_mblaze_0 mblaze
       (.Byte_Enable(intf_net_mblaze_DLMB_BE),
        .Clk(net_clk_wiz_clk_out1),
        .DCE(intf_net_mblaze_DLMB_CE),
        .DReady(intf_net_mblaze_DLMB_READY),
        .DUE(intf_net_mblaze_DLMB_UE),
        .DWait(intf_net_mblaze_DLMB_WAIT),
        .D_AS(intf_net_mblaze_DLMB_ADDRSTROBE),
        .Data_Addr(intf_net_mblaze_DLMB_ABUS),
        .Data_Read(intf_net_mblaze_DLMB_READDBUS),
        .Data_Write(intf_net_mblaze_DLMB_WRITEDBUS),
        .Dbg_Capture(intf_net_mdm_MBDEBUG_0_CAPTURE),
        .Dbg_Clk(intf_net_mdm_MBDEBUG_0_CLK),
        .Dbg_Disable(intf_net_mdm_MBDEBUG_0_DISABLE),
        .Dbg_Reg_En(intf_net_mdm_MBDEBUG_0_REG_EN),
        .Dbg_Shift(intf_net_mdm_MBDEBUG_0_SHIFT),
        .Dbg_TDI(intf_net_mdm_MBDEBUG_0_TDI),
        .Dbg_TDO(intf_net_mdm_MBDEBUG_0_TDO),
        .Dbg_Update(intf_net_mdm_MBDEBUG_0_UPDATE),
        .Debug_Rst(intf_net_mdm_MBDEBUG_0_RST),
        .ICE(intf_net_mblaze_ILMB_CE),
        .IFetch(intf_net_mblaze_ILMB_READSTROBE),
        .IReady(intf_net_mblaze_ILMB_READY),
        .IUE(intf_net_mblaze_ILMB_UE),
        .IWAIT(intf_net_mblaze_ILMB_WAIT),
        .I_AS(intf_net_mblaze_ILMB_ADDRSTROBE),
        .Instr(intf_net_mblaze_ILMB_READDBUS),
        .Instr_Addr(intf_net_mblaze_ILMB_ABUS),
        .Interrupt(intf_net_axi_intc_interrupt_INTERRUPT),
        .Interrupt_Address({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .M_AXI_DP_ARADDR(intf_net_mblaze_M_AXI_DP_ARADDR),
        .M_AXI_DP_ARPROT(intf_net_mblaze_M_AXI_DP_ARPROT),
        .M_AXI_DP_ARREADY(intf_net_mblaze_M_AXI_DP_ARREADY),
        .M_AXI_DP_ARVALID(intf_net_mblaze_M_AXI_DP_ARVALID),
        .M_AXI_DP_AWADDR(intf_net_mblaze_M_AXI_DP_AWADDR),
        .M_AXI_DP_AWPROT(intf_net_mblaze_M_AXI_DP_AWPROT),
        .M_AXI_DP_AWREADY(intf_net_mblaze_M_AXI_DP_AWREADY),
        .M_AXI_DP_AWVALID(intf_net_mblaze_M_AXI_DP_AWVALID),
        .M_AXI_DP_BREADY(intf_net_mblaze_M_AXI_DP_BREADY),
        .M_AXI_DP_BRESP(intf_net_mblaze_M_AXI_DP_BRESP),
        .M_AXI_DP_BVALID(intf_net_mblaze_M_AXI_DP_BVALID),
        .M_AXI_DP_RDATA(intf_net_mblaze_M_AXI_DP_RDATA),
        .M_AXI_DP_RREADY(intf_net_mblaze_M_AXI_DP_RREADY),
        .M_AXI_DP_RRESP(intf_net_mblaze_M_AXI_DP_RRESP),
        .M_AXI_DP_RVALID(intf_net_mblaze_M_AXI_DP_RVALID),
        .M_AXI_DP_WDATA(intf_net_mblaze_M_AXI_DP_WDATA),
        .M_AXI_DP_WREADY(intf_net_mblaze_M_AXI_DP_WREADY),
        .M_AXI_DP_WSTRB(intf_net_mblaze_M_AXI_DP_WSTRB),
        .M_AXI_DP_WVALID(intf_net_mblaze_M_AXI_DP_WVALID),
        .Read_Strobe(intf_net_mblaze_DLMB_READSTROBE),
        .Reset(net_rst_processor_1_100M_mb_reset),
        .Write_Strobe(intf_net_mblaze_DLMB_WRITESTROBE));
  exdes_mdm_0 mdm
       (.Dbg_Capture_0(intf_net_mdm_MBDEBUG_0_CAPTURE),
        .Dbg_Clk_0(intf_net_mdm_MBDEBUG_0_CLK),
        .Dbg_Disable_0(intf_net_mdm_MBDEBUG_0_DISABLE),
        .Dbg_Reg_En_0(intf_net_mdm_MBDEBUG_0_REG_EN),
        .Dbg_Rst_0(intf_net_mdm_MBDEBUG_0_RST),
        .Dbg_Shift_0(intf_net_mdm_MBDEBUG_0_SHIFT),
        .Dbg_TDI_0(intf_net_mdm_MBDEBUG_0_TDI),
        .Dbg_TDO_0(intf_net_mdm_MBDEBUG_0_TDO),
        .Dbg_Update_0(intf_net_mdm_MBDEBUG_0_UPDATE),
        .Debug_SYS_Rst(net_mdm_Debug_SYS_Rst));
  exdes_rst_processor_1_100M_0 rst_processor_1_100M
       (.aux_reset_in(net_clk_wiz_locked),
        .bus_struct_reset(net_rst_processor_1_100M_bus_struct_reset),
        .dcm_locked(net_clk_wiz_locked),
        .ext_reset_in(net_bdry_in_ext_reset_in),
        .interconnect_aresetn(net_rst_processor_1_100M_interconnect_aresetn),
        .mb_debug_sys_rst(net_mdm_Debug_SYS_Rst),
        .mb_reset(net_rst_processor_1_100M_mb_reset),
        .peripheral_aresetn(net_rst_processor_1_100M_peripheral_aresetn),
        .slowest_sync_clk(net_clk_wiz_clk_out1));
  exdes_rst_processor_1_300M_0 rst_processor_1_300M
       (.aux_reset_in(net_clk_wiz_locked),
        .dcm_locked(net_clk_wiz_locked),
        .ext_reset_in(net_bdry_in_ext_reset_in),
        .interconnect_aresetn(net_rst_processor_1_300M_interconnect_aresetn),
        .mb_debug_sys_rst(1'b0),
        .peripheral_aresetn(net_rst_processor_1_300M_peripheral_aresetn),
        .slowest_sync_clk(net_clk_wiz_clk_out2));
  exdes_xlconcat_0 xlconcat
       (.In0(net_bdry_in_vphy_irq),
        .In1(net_bdry_in_hdmi_rx_irq),
        .In2(net_bdry_in_hdmi_tx_irq),
        .dout(net_xlconcat_dout));
endmodule

module s00_couplers_imp_O40D8P
   (M_ACLK,
    M_ARESETN,
    M_AXI_araddr,
    M_AXI_arprot,
    M_AXI_arready,
    M_AXI_arvalid,
    M_AXI_awaddr,
    M_AXI_awprot,
    M_AXI_awready,
    M_AXI_awvalid,
    M_AXI_bready,
    M_AXI_bresp,
    M_AXI_bvalid,
    M_AXI_rdata,
    M_AXI_rready,
    M_AXI_rresp,
    M_AXI_rvalid,
    M_AXI_wdata,
    M_AXI_wready,
    M_AXI_wstrb,
    M_AXI_wvalid,
    S_ACLK,
    S_ARESETN,
    S_AXI_araddr,
    S_AXI_arprot,
    S_AXI_arready,
    S_AXI_arvalid,
    S_AXI_awaddr,
    S_AXI_awprot,
    S_AXI_awready,
    S_AXI_awvalid,
    S_AXI_bready,
    S_AXI_bresp,
    S_AXI_bvalid,
    S_AXI_rdata,
    S_AXI_rready,
    S_AXI_rresp,
    S_AXI_rvalid,
    S_AXI_wdata,
    S_AXI_wready,
    S_AXI_wstrb,
    S_AXI_wvalid);
  input M_ACLK;
  input M_ARESETN;
  output [31:0]M_AXI_araddr;
  output [2:0]M_AXI_arprot;
  input [0:0]M_AXI_arready;
  output [0:0]M_AXI_arvalid;
  output [31:0]M_AXI_awaddr;
  output [2:0]M_AXI_awprot;
  input [0:0]M_AXI_awready;
  output [0:0]M_AXI_awvalid;
  output [0:0]M_AXI_bready;
  input [1:0]M_AXI_bresp;
  input [0:0]M_AXI_bvalid;
  input [31:0]M_AXI_rdata;
  output [0:0]M_AXI_rready;
  input [1:0]M_AXI_rresp;
  input [0:0]M_AXI_rvalid;
  output [31:0]M_AXI_wdata;
  input [0:0]M_AXI_wready;
  output [3:0]M_AXI_wstrb;
  output [0:0]M_AXI_wvalid;
  input S_ACLK;
  input S_ARESETN;
  input [31:0]S_AXI_araddr;
  input [2:0]S_AXI_arprot;
  output [0:0]S_AXI_arready;
  input [0:0]S_AXI_arvalid;
  input [31:0]S_AXI_awaddr;
  input [2:0]S_AXI_awprot;
  output [0:0]S_AXI_awready;
  input [0:0]S_AXI_awvalid;
  input [0:0]S_AXI_bready;
  output [1:0]S_AXI_bresp;
  output [0:0]S_AXI_bvalid;
  output [31:0]S_AXI_rdata;
  input [0:0]S_AXI_rready;
  output [1:0]S_AXI_rresp;
  output [0:0]S_AXI_rvalid;
  input [31:0]S_AXI_wdata;
  output [0:0]S_AXI_wready;
  input [3:0]S_AXI_wstrb;
  input [0:0]S_AXI_wvalid;

  wire [31:0]s00_couplers_to_s00_couplers_ARADDR;
  wire [2:0]s00_couplers_to_s00_couplers_ARPROT;
  wire [0:0]s00_couplers_to_s00_couplers_ARREADY;
  wire [0:0]s00_couplers_to_s00_couplers_ARVALID;
  wire [31:0]s00_couplers_to_s00_couplers_AWADDR;
  wire [2:0]s00_couplers_to_s00_couplers_AWPROT;
  wire [0:0]s00_couplers_to_s00_couplers_AWREADY;
  wire [0:0]s00_couplers_to_s00_couplers_AWVALID;
  wire [0:0]s00_couplers_to_s00_couplers_BREADY;
  wire [1:0]s00_couplers_to_s00_couplers_BRESP;
  wire [0:0]s00_couplers_to_s00_couplers_BVALID;
  wire [31:0]s00_couplers_to_s00_couplers_RDATA;
  wire [0:0]s00_couplers_to_s00_couplers_RREADY;
  wire [1:0]s00_couplers_to_s00_couplers_RRESP;
  wire [0:0]s00_couplers_to_s00_couplers_RVALID;
  wire [31:0]s00_couplers_to_s00_couplers_WDATA;
  wire [0:0]s00_couplers_to_s00_couplers_WREADY;
  wire [3:0]s00_couplers_to_s00_couplers_WSTRB;
  wire [0:0]s00_couplers_to_s00_couplers_WVALID;

  assign M_AXI_araddr[31:0] = s00_couplers_to_s00_couplers_ARADDR;
  assign M_AXI_arprot[2:0] = s00_couplers_to_s00_couplers_ARPROT;
  assign M_AXI_arvalid[0] = s00_couplers_to_s00_couplers_ARVALID;
  assign M_AXI_awaddr[31:0] = s00_couplers_to_s00_couplers_AWADDR;
  assign M_AXI_awprot[2:0] = s00_couplers_to_s00_couplers_AWPROT;
  assign M_AXI_awvalid[0] = s00_couplers_to_s00_couplers_AWVALID;
  assign M_AXI_bready[0] = s00_couplers_to_s00_couplers_BREADY;
  assign M_AXI_rready[0] = s00_couplers_to_s00_couplers_RREADY;
  assign M_AXI_wdata[31:0] = s00_couplers_to_s00_couplers_WDATA;
  assign M_AXI_wstrb[3:0] = s00_couplers_to_s00_couplers_WSTRB;
  assign M_AXI_wvalid[0] = s00_couplers_to_s00_couplers_WVALID;
  assign S_AXI_arready[0] = s00_couplers_to_s00_couplers_ARREADY;
  assign S_AXI_awready[0] = s00_couplers_to_s00_couplers_AWREADY;
  assign S_AXI_bresp[1:0] = s00_couplers_to_s00_couplers_BRESP;
  assign S_AXI_bvalid[0] = s00_couplers_to_s00_couplers_BVALID;
  assign S_AXI_rdata[31:0] = s00_couplers_to_s00_couplers_RDATA;
  assign S_AXI_rresp[1:0] = s00_couplers_to_s00_couplers_RRESP;
  assign S_AXI_rvalid[0] = s00_couplers_to_s00_couplers_RVALID;
  assign S_AXI_wready[0] = s00_couplers_to_s00_couplers_WREADY;
  assign s00_couplers_to_s00_couplers_ARADDR = S_AXI_araddr[31:0];
  assign s00_couplers_to_s00_couplers_ARPROT = S_AXI_arprot[2:0];
  assign s00_couplers_to_s00_couplers_ARREADY = M_AXI_arready[0];
  assign s00_couplers_to_s00_couplers_ARVALID = S_AXI_arvalid[0];
  assign s00_couplers_to_s00_couplers_AWADDR = S_AXI_awaddr[31:0];
  assign s00_couplers_to_s00_couplers_AWPROT = S_AXI_awprot[2:0];
  assign s00_couplers_to_s00_couplers_AWREADY = M_AXI_awready[0];
  assign s00_couplers_to_s00_couplers_AWVALID = S_AXI_awvalid[0];
  assign s00_couplers_to_s00_couplers_BREADY = S_AXI_bready[0];
  assign s00_couplers_to_s00_couplers_BRESP = M_AXI_bresp[1:0];
  assign s00_couplers_to_s00_couplers_BVALID = M_AXI_bvalid[0];
  assign s00_couplers_to_s00_couplers_RDATA = M_AXI_rdata[31:0];
  assign s00_couplers_to_s00_couplers_RREADY = S_AXI_rready[0];
  assign s00_couplers_to_s00_couplers_RRESP = M_AXI_rresp[1:0];
  assign s00_couplers_to_s00_couplers_RVALID = M_AXI_rvalid[0];
  assign s00_couplers_to_s00_couplers_WDATA = S_AXI_wdata[31:0];
  assign s00_couplers_to_s00_couplers_WREADY = M_AXI_wready[0];
  assign s00_couplers_to_s00_couplers_WSTRB = S_AXI_wstrb[3:0];
  assign s00_couplers_to_s00_couplers_WVALID = S_AXI_wvalid[0];
endmodule

module s00_couplers_imp_ULFDNX
   (M_ACLK,
    M_ARESETN,
    M_AXI_araddr,
    M_AXI_arprot,
    M_AXI_arready,
    M_AXI_arvalid,
    M_AXI_awaddr,
    M_AXI_awprot,
    M_AXI_awready,
    M_AXI_awvalid,
    M_AXI_bready,
    M_AXI_bresp,
    M_AXI_bvalid,
    M_AXI_rdata,
    M_AXI_rready,
    M_AXI_rresp,
    M_AXI_rvalid,
    M_AXI_wdata,
    M_AXI_wready,
    M_AXI_wstrb,
    M_AXI_wvalid,
    S_ACLK,
    S_ARESETN,
    S_AXI_araddr,
    S_AXI_arprot,
    S_AXI_arready,
    S_AXI_arvalid,
    S_AXI_awaddr,
    S_AXI_awprot,
    S_AXI_awready,
    S_AXI_awvalid,
    S_AXI_bready,
    S_AXI_bresp,
    S_AXI_bvalid,
    S_AXI_rdata,
    S_AXI_rready,
    S_AXI_rresp,
    S_AXI_rvalid,
    S_AXI_wdata,
    S_AXI_wready,
    S_AXI_wstrb,
    S_AXI_wvalid);
  input M_ACLK;
  input M_ARESETN;
  output [31:0]M_AXI_araddr;
  output [2:0]M_AXI_arprot;
  input M_AXI_arready;
  output M_AXI_arvalid;
  output [31:0]M_AXI_awaddr;
  output [2:0]M_AXI_awprot;
  input M_AXI_awready;
  output M_AXI_awvalid;
  output M_AXI_bready;
  input [1:0]M_AXI_bresp;
  input M_AXI_bvalid;
  input [31:0]M_AXI_rdata;
  output M_AXI_rready;
  input [1:0]M_AXI_rresp;
  input M_AXI_rvalid;
  output [31:0]M_AXI_wdata;
  input M_AXI_wready;
  output [3:0]M_AXI_wstrb;
  output M_AXI_wvalid;
  input S_ACLK;
  input S_ARESETN;
  input [31:0]S_AXI_araddr;
  input [2:0]S_AXI_arprot;
  output S_AXI_arready;
  input S_AXI_arvalid;
  input [31:0]S_AXI_awaddr;
  input [2:0]S_AXI_awprot;
  output S_AXI_awready;
  input S_AXI_awvalid;
  input S_AXI_bready;
  output [1:0]S_AXI_bresp;
  output S_AXI_bvalid;
  output [31:0]S_AXI_rdata;
  input S_AXI_rready;
  output [1:0]S_AXI_rresp;
  output S_AXI_rvalid;
  input [31:0]S_AXI_wdata;
  output S_AXI_wready;
  input [3:0]S_AXI_wstrb;
  input S_AXI_wvalid;

  wire [31:0]s00_couplers_to_s00_couplers_ARADDR;
  wire [2:0]s00_couplers_to_s00_couplers_ARPROT;
  wire s00_couplers_to_s00_couplers_ARREADY;
  wire s00_couplers_to_s00_couplers_ARVALID;
  wire [31:0]s00_couplers_to_s00_couplers_AWADDR;
  wire [2:0]s00_couplers_to_s00_couplers_AWPROT;
  wire s00_couplers_to_s00_couplers_AWREADY;
  wire s00_couplers_to_s00_couplers_AWVALID;
  wire s00_couplers_to_s00_couplers_BREADY;
  wire [1:0]s00_couplers_to_s00_couplers_BRESP;
  wire s00_couplers_to_s00_couplers_BVALID;
  wire [31:0]s00_couplers_to_s00_couplers_RDATA;
  wire s00_couplers_to_s00_couplers_RREADY;
  wire [1:0]s00_couplers_to_s00_couplers_RRESP;
  wire s00_couplers_to_s00_couplers_RVALID;
  wire [31:0]s00_couplers_to_s00_couplers_WDATA;
  wire s00_couplers_to_s00_couplers_WREADY;
  wire [3:0]s00_couplers_to_s00_couplers_WSTRB;
  wire s00_couplers_to_s00_couplers_WVALID;

  assign M_AXI_araddr[31:0] = s00_couplers_to_s00_couplers_ARADDR;
  assign M_AXI_arprot[2:0] = s00_couplers_to_s00_couplers_ARPROT;
  assign M_AXI_arvalid = s00_couplers_to_s00_couplers_ARVALID;
  assign M_AXI_awaddr[31:0] = s00_couplers_to_s00_couplers_AWADDR;
  assign M_AXI_awprot[2:0] = s00_couplers_to_s00_couplers_AWPROT;
  assign M_AXI_awvalid = s00_couplers_to_s00_couplers_AWVALID;
  assign M_AXI_bready = s00_couplers_to_s00_couplers_BREADY;
  assign M_AXI_rready = s00_couplers_to_s00_couplers_RREADY;
  assign M_AXI_wdata[31:0] = s00_couplers_to_s00_couplers_WDATA;
  assign M_AXI_wstrb[3:0] = s00_couplers_to_s00_couplers_WSTRB;
  assign M_AXI_wvalid = s00_couplers_to_s00_couplers_WVALID;
  assign S_AXI_arready = s00_couplers_to_s00_couplers_ARREADY;
  assign S_AXI_awready = s00_couplers_to_s00_couplers_AWREADY;
  assign S_AXI_bresp[1:0] = s00_couplers_to_s00_couplers_BRESP;
  assign S_AXI_bvalid = s00_couplers_to_s00_couplers_BVALID;
  assign S_AXI_rdata[31:0] = s00_couplers_to_s00_couplers_RDATA;
  assign S_AXI_rresp[1:0] = s00_couplers_to_s00_couplers_RRESP;
  assign S_AXI_rvalid = s00_couplers_to_s00_couplers_RVALID;
  assign S_AXI_wready = s00_couplers_to_s00_couplers_WREADY;
  assign s00_couplers_to_s00_couplers_ARADDR = S_AXI_araddr[31:0];
  assign s00_couplers_to_s00_couplers_ARPROT = S_AXI_arprot[2:0];
  assign s00_couplers_to_s00_couplers_ARREADY = M_AXI_arready;
  assign s00_couplers_to_s00_couplers_ARVALID = S_AXI_arvalid;
  assign s00_couplers_to_s00_couplers_AWADDR = S_AXI_awaddr[31:0];
  assign s00_couplers_to_s00_couplers_AWPROT = S_AXI_awprot[2:0];
  assign s00_couplers_to_s00_couplers_AWREADY = M_AXI_awready;
  assign s00_couplers_to_s00_couplers_AWVALID = S_AXI_awvalid;
  assign s00_couplers_to_s00_couplers_BREADY = S_AXI_bready;
  assign s00_couplers_to_s00_couplers_BRESP = M_AXI_bresp[1:0];
  assign s00_couplers_to_s00_couplers_BVALID = M_AXI_bvalid;
  assign s00_couplers_to_s00_couplers_RDATA = M_AXI_rdata[31:0];
  assign s00_couplers_to_s00_couplers_RREADY = S_AXI_rready;
  assign s00_couplers_to_s00_couplers_RRESP = M_AXI_rresp[1:0];
  assign s00_couplers_to_s00_couplers_RVALID = M_AXI_rvalid;
  assign s00_couplers_to_s00_couplers_WDATA = S_AXI_wdata[31:0];
  assign s00_couplers_to_s00_couplers_WREADY = M_AXI_wready;
  assign s00_couplers_to_s00_couplers_WSTRB = S_AXI_wstrb[3:0];
  assign s00_couplers_to_s00_couplers_WVALID = S_AXI_wvalid;
endmodule

module v_tpg_ss_0_imp_5QXXBT
   (S_AXI_GPIO_araddr,
    S_AXI_GPIO_arready,
    S_AXI_GPIO_arvalid,
    S_AXI_GPIO_awaddr,
    S_AXI_GPIO_awready,
    S_AXI_GPIO_awvalid,
    S_AXI_GPIO_bready,
    S_AXI_GPIO_bresp,
    S_AXI_GPIO_bvalid,
    S_AXI_GPIO_rdata,
    S_AXI_GPIO_rready,
    S_AXI_GPIO_rresp,
    S_AXI_GPIO_rvalid,
    S_AXI_GPIO_wdata,
    S_AXI_GPIO_wready,
    S_AXI_GPIO_wstrb,
    S_AXI_GPIO_wvalid,
    S_AXI_TPG_araddr,
    S_AXI_TPG_arready,
    S_AXI_TPG_arvalid,
    S_AXI_TPG_awaddr,
    S_AXI_TPG_awready,
    S_AXI_TPG_awvalid,
    S_AXI_TPG_bready,
    S_AXI_TPG_bresp,
    S_AXI_TPG_bvalid,
    S_AXI_TPG_rdata,
    S_AXI_TPG_rready,
    S_AXI_TPG_rresp,
    S_AXI_TPG_rvalid,
    S_AXI_TPG_wdata,
    S_AXI_TPG_wready,
    S_AXI_TPG_wstrb,
    S_AXI_TPG_wvalid,
    ap_clk,
    m_axi_aresetn,
    m_axis_video_tdata,
    m_axis_video_tdest,
    m_axis_video_tid,
    m_axis_video_tkeep,
    m_axis_video_tlast,
    m_axis_video_tready,
    m_axis_video_tstrb,
    m_axis_video_tuser,
    m_axis_video_tvalid,
    s_axis_video_tdata,
    s_axis_video_tlast,
    s_axis_video_tready,
    s_axis_video_tuser,
    s_axis_video_tvalid);
  input [8:0]S_AXI_GPIO_araddr;
  output S_AXI_GPIO_arready;
  input S_AXI_GPIO_arvalid;
  input [8:0]S_AXI_GPIO_awaddr;
  output S_AXI_GPIO_awready;
  input S_AXI_GPIO_awvalid;
  input S_AXI_GPIO_bready;
  output [1:0]S_AXI_GPIO_bresp;
  output S_AXI_GPIO_bvalid;
  output [31:0]S_AXI_GPIO_rdata;
  input S_AXI_GPIO_rready;
  output [1:0]S_AXI_GPIO_rresp;
  output S_AXI_GPIO_rvalid;
  input [31:0]S_AXI_GPIO_wdata;
  output S_AXI_GPIO_wready;
  input [3:0]S_AXI_GPIO_wstrb;
  input S_AXI_GPIO_wvalid;
  input [7:0]S_AXI_TPG_araddr;
  output S_AXI_TPG_arready;
  input S_AXI_TPG_arvalid;
  input [7:0]S_AXI_TPG_awaddr;
  output S_AXI_TPG_awready;
  input S_AXI_TPG_awvalid;
  input S_AXI_TPG_bready;
  output [1:0]S_AXI_TPG_bresp;
  output S_AXI_TPG_bvalid;
  output [31:0]S_AXI_TPG_rdata;
  input S_AXI_TPG_rready;
  output [1:0]S_AXI_TPG_rresp;
  output S_AXI_TPG_rvalid;
  input [31:0]S_AXI_TPG_wdata;
  output S_AXI_TPG_wready;
  input [3:0]S_AXI_TPG_wstrb;
  input S_AXI_TPG_wvalid;
  input ap_clk;
  input m_axi_aresetn;
  output [47:0]m_axis_video_tdata;
  output [0:0]m_axis_video_tdest;
  output [0:0]m_axis_video_tid;
  output [5:0]m_axis_video_tkeep;
  output [0:0]m_axis_video_tlast;
  input m_axis_video_tready;
  output [5:0]m_axis_video_tstrb;
  output [0:0]m_axis_video_tuser;
  output m_axis_video_tvalid;
  input [47:0]s_axis_video_tdata;
  input [0:0]s_axis_video_tlast;
  output s_axis_video_tready;
  input [0:0]s_axis_video_tuser;
  input s_axis_video_tvalid;

  wire [8:0]intf_net_bdry_in_S_AXI_GPIO_ARADDR;
  wire intf_net_bdry_in_S_AXI_GPIO_ARREADY;
  wire intf_net_bdry_in_S_AXI_GPIO_ARVALID;
  wire [8:0]intf_net_bdry_in_S_AXI_GPIO_AWADDR;
  wire intf_net_bdry_in_S_AXI_GPIO_AWREADY;
  wire intf_net_bdry_in_S_AXI_GPIO_AWVALID;
  wire intf_net_bdry_in_S_AXI_GPIO_BREADY;
  wire [1:0]intf_net_bdry_in_S_AXI_GPIO_BRESP;
  wire intf_net_bdry_in_S_AXI_GPIO_BVALID;
  wire [31:0]intf_net_bdry_in_S_AXI_GPIO_RDATA;
  wire intf_net_bdry_in_S_AXI_GPIO_RREADY;
  wire [1:0]intf_net_bdry_in_S_AXI_GPIO_RRESP;
  wire intf_net_bdry_in_S_AXI_GPIO_RVALID;
  wire [31:0]intf_net_bdry_in_S_AXI_GPIO_WDATA;
  wire intf_net_bdry_in_S_AXI_GPIO_WREADY;
  wire [3:0]intf_net_bdry_in_S_AXI_GPIO_WSTRB;
  wire intf_net_bdry_in_S_AXI_GPIO_WVALID;
  wire [7:0]intf_net_bdry_in_S_AXI_TPG_ARADDR;
  wire intf_net_bdry_in_S_AXI_TPG_ARREADY;
  wire intf_net_bdry_in_S_AXI_TPG_ARVALID;
  wire [7:0]intf_net_bdry_in_S_AXI_TPG_AWADDR;
  wire intf_net_bdry_in_S_AXI_TPG_AWREADY;
  wire intf_net_bdry_in_S_AXI_TPG_AWVALID;
  wire intf_net_bdry_in_S_AXI_TPG_BREADY;
  wire [1:0]intf_net_bdry_in_S_AXI_TPG_BRESP;
  wire intf_net_bdry_in_S_AXI_TPG_BVALID;
  wire [31:0]intf_net_bdry_in_S_AXI_TPG_RDATA;
  wire intf_net_bdry_in_S_AXI_TPG_RREADY;
  wire [1:0]intf_net_bdry_in_S_AXI_TPG_RRESP;
  wire intf_net_bdry_in_S_AXI_TPG_RVALID;
  wire [31:0]intf_net_bdry_in_S_AXI_TPG_WDATA;
  wire intf_net_bdry_in_S_AXI_TPG_WREADY;
  wire [3:0]intf_net_bdry_in_S_AXI_TPG_WSTRB;
  wire intf_net_bdry_in_S_AXI_TPG_WVALID;
  wire [47:0]intf_net_bdry_in_s_axis_video_TDATA;
  wire [0:0]intf_net_bdry_in_s_axis_video_TLAST;
  wire intf_net_bdry_in_s_axis_video_TREADY;
  wire [0:0]intf_net_bdry_in_s_axis_video_TUSER;
  wire intf_net_bdry_in_s_axis_video_TVALID;
  wire [47:0]intf_net_v_tpg_m_axis_video_TDATA;
  wire [0:0]intf_net_v_tpg_m_axis_video_TDEST;
  wire [0:0]intf_net_v_tpg_m_axis_video_TID;
  wire [5:0]intf_net_v_tpg_m_axis_video_TKEEP;
  wire [0:0]intf_net_v_tpg_m_axis_video_TLAST;
  wire intf_net_v_tpg_m_axis_video_TREADY;
  wire [5:0]intf_net_v_tpg_m_axis_video_TSTRB;
  wire [0:0]intf_net_v_tpg_m_axis_video_TUSER;
  wire intf_net_v_tpg_m_axis_video_TVALID;
  wire [0:0]net_axi_gpio_gpio_io_o;
  wire net_bdry_in_ap_clk;
  wire net_bdry_in_m_axi_aresetn;

  assign S_AXI_GPIO_arready = intf_net_bdry_in_S_AXI_GPIO_ARREADY;
  assign S_AXI_GPIO_awready = intf_net_bdry_in_S_AXI_GPIO_AWREADY;
  assign S_AXI_GPIO_bresp[1:0] = intf_net_bdry_in_S_AXI_GPIO_BRESP;
  assign S_AXI_GPIO_bvalid = intf_net_bdry_in_S_AXI_GPIO_BVALID;
  assign S_AXI_GPIO_rdata[31:0] = intf_net_bdry_in_S_AXI_GPIO_RDATA;
  assign S_AXI_GPIO_rresp[1:0] = intf_net_bdry_in_S_AXI_GPIO_RRESP;
  assign S_AXI_GPIO_rvalid = intf_net_bdry_in_S_AXI_GPIO_RVALID;
  assign S_AXI_GPIO_wready = intf_net_bdry_in_S_AXI_GPIO_WREADY;
  assign S_AXI_TPG_arready = intf_net_bdry_in_S_AXI_TPG_ARREADY;
  assign S_AXI_TPG_awready = intf_net_bdry_in_S_AXI_TPG_AWREADY;
  assign S_AXI_TPG_bresp[1:0] = intf_net_bdry_in_S_AXI_TPG_BRESP;
  assign S_AXI_TPG_bvalid = intf_net_bdry_in_S_AXI_TPG_BVALID;
  assign S_AXI_TPG_rdata[31:0] = intf_net_bdry_in_S_AXI_TPG_RDATA;
  assign S_AXI_TPG_rresp[1:0] = intf_net_bdry_in_S_AXI_TPG_RRESP;
  assign S_AXI_TPG_rvalid = intf_net_bdry_in_S_AXI_TPG_RVALID;
  assign S_AXI_TPG_wready = intf_net_bdry_in_S_AXI_TPG_WREADY;
  assign intf_net_bdry_in_S_AXI_GPIO_ARADDR = S_AXI_GPIO_araddr[8:0];
  assign intf_net_bdry_in_S_AXI_GPIO_ARVALID = S_AXI_GPIO_arvalid;
  assign intf_net_bdry_in_S_AXI_GPIO_AWADDR = S_AXI_GPIO_awaddr[8:0];
  assign intf_net_bdry_in_S_AXI_GPIO_AWVALID = S_AXI_GPIO_awvalid;
  assign intf_net_bdry_in_S_AXI_GPIO_BREADY = S_AXI_GPIO_bready;
  assign intf_net_bdry_in_S_AXI_GPIO_RREADY = S_AXI_GPIO_rready;
  assign intf_net_bdry_in_S_AXI_GPIO_WDATA = S_AXI_GPIO_wdata[31:0];
  assign intf_net_bdry_in_S_AXI_GPIO_WSTRB = S_AXI_GPIO_wstrb[3:0];
  assign intf_net_bdry_in_S_AXI_GPIO_WVALID = S_AXI_GPIO_wvalid;
  assign intf_net_bdry_in_S_AXI_TPG_ARADDR = S_AXI_TPG_araddr[7:0];
  assign intf_net_bdry_in_S_AXI_TPG_ARVALID = S_AXI_TPG_arvalid;
  assign intf_net_bdry_in_S_AXI_TPG_AWADDR = S_AXI_TPG_awaddr[7:0];
  assign intf_net_bdry_in_S_AXI_TPG_AWVALID = S_AXI_TPG_awvalid;
  assign intf_net_bdry_in_S_AXI_TPG_BREADY = S_AXI_TPG_bready;
  assign intf_net_bdry_in_S_AXI_TPG_RREADY = S_AXI_TPG_rready;
  assign intf_net_bdry_in_S_AXI_TPG_WDATA = S_AXI_TPG_wdata[31:0];
  assign intf_net_bdry_in_S_AXI_TPG_WSTRB = S_AXI_TPG_wstrb[3:0];
  assign intf_net_bdry_in_S_AXI_TPG_WVALID = S_AXI_TPG_wvalid;
  assign intf_net_bdry_in_s_axis_video_TDATA = s_axis_video_tdata[47:0];
  assign intf_net_bdry_in_s_axis_video_TLAST = s_axis_video_tlast[0];
  assign intf_net_bdry_in_s_axis_video_TUSER = s_axis_video_tuser[0];
  assign intf_net_bdry_in_s_axis_video_TVALID = s_axis_video_tvalid;
  assign intf_net_v_tpg_m_axis_video_TREADY = m_axis_video_tready;
  assign m_axis_video_tdata[47:0] = intf_net_v_tpg_m_axis_video_TDATA;
  assign m_axis_video_tdest[0] = intf_net_v_tpg_m_axis_video_TDEST;
  assign m_axis_video_tid[0] = intf_net_v_tpg_m_axis_video_TID;
  assign m_axis_video_tkeep[5:0] = intf_net_v_tpg_m_axis_video_TKEEP;
  assign m_axis_video_tlast[0] = intf_net_v_tpg_m_axis_video_TLAST;
  assign m_axis_video_tstrb[5:0] = intf_net_v_tpg_m_axis_video_TSTRB;
  assign m_axis_video_tuser[0] = intf_net_v_tpg_m_axis_video_TUSER;
  assign m_axis_video_tvalid = intf_net_v_tpg_m_axis_video_TVALID;
  assign net_bdry_in_ap_clk = ap_clk;
  assign net_bdry_in_m_axi_aresetn = m_axi_aresetn;
  assign s_axis_video_tready = intf_net_bdry_in_s_axis_video_TREADY;
  exdes_axi_gpio_0 axi_gpio
       (.gpio_io_o(net_axi_gpio_gpio_io_o),
        .s_axi_aclk(net_bdry_in_ap_clk),
        .s_axi_araddr(intf_net_bdry_in_S_AXI_GPIO_ARADDR),
        .s_axi_aresetn(net_bdry_in_m_axi_aresetn),
        .s_axi_arready(intf_net_bdry_in_S_AXI_GPIO_ARREADY),
        .s_axi_arvalid(intf_net_bdry_in_S_AXI_GPIO_ARVALID),
        .s_axi_awaddr(intf_net_bdry_in_S_AXI_GPIO_AWADDR),
        .s_axi_awready(intf_net_bdry_in_S_AXI_GPIO_AWREADY),
        .s_axi_awvalid(intf_net_bdry_in_S_AXI_GPIO_AWVALID),
        .s_axi_bready(intf_net_bdry_in_S_AXI_GPIO_BREADY),
        .s_axi_bresp(intf_net_bdry_in_S_AXI_GPIO_BRESP),
        .s_axi_bvalid(intf_net_bdry_in_S_AXI_GPIO_BVALID),
        .s_axi_rdata(intf_net_bdry_in_S_AXI_GPIO_RDATA),
        .s_axi_rready(intf_net_bdry_in_S_AXI_GPIO_RREADY),
        .s_axi_rresp(intf_net_bdry_in_S_AXI_GPIO_RRESP),
        .s_axi_rvalid(intf_net_bdry_in_S_AXI_GPIO_RVALID),
        .s_axi_wdata(intf_net_bdry_in_S_AXI_GPIO_WDATA),
        .s_axi_wready(intf_net_bdry_in_S_AXI_GPIO_WREADY),
        .s_axi_wstrb(intf_net_bdry_in_S_AXI_GPIO_WSTRB),
        .s_axi_wvalid(intf_net_bdry_in_S_AXI_GPIO_WVALID));
  exdes_v_tpg_0 v_tpg
       (.ap_clk(net_bdry_in_ap_clk),
        .ap_rst_n(net_axi_gpio_gpio_io_o),
        .fid_in(1'b1),
        .m_axis_video_TDATA(intf_net_v_tpg_m_axis_video_TDATA),
        .m_axis_video_TDEST(intf_net_v_tpg_m_axis_video_TDEST),
        .m_axis_video_TID(intf_net_v_tpg_m_axis_video_TID),
        .m_axis_video_TKEEP(intf_net_v_tpg_m_axis_video_TKEEP),
        .m_axis_video_TLAST(intf_net_v_tpg_m_axis_video_TLAST),
        .m_axis_video_TREADY(intf_net_v_tpg_m_axis_video_TREADY),
        .m_axis_video_TSTRB(intf_net_v_tpg_m_axis_video_TSTRB),
        .m_axis_video_TUSER(intf_net_v_tpg_m_axis_video_TUSER),
        .m_axis_video_TVALID(intf_net_v_tpg_m_axis_video_TVALID),
        .s_axi_CTRL_ARADDR(intf_net_bdry_in_S_AXI_TPG_ARADDR),
        .s_axi_CTRL_ARREADY(intf_net_bdry_in_S_AXI_TPG_ARREADY),
        .s_axi_CTRL_ARVALID(intf_net_bdry_in_S_AXI_TPG_ARVALID),
        .s_axi_CTRL_AWADDR(intf_net_bdry_in_S_AXI_TPG_AWADDR),
        .s_axi_CTRL_AWREADY(intf_net_bdry_in_S_AXI_TPG_AWREADY),
        .s_axi_CTRL_AWVALID(intf_net_bdry_in_S_AXI_TPG_AWVALID),
        .s_axi_CTRL_BREADY(intf_net_bdry_in_S_AXI_TPG_BREADY),
        .s_axi_CTRL_BRESP(intf_net_bdry_in_S_AXI_TPG_BRESP),
        .s_axi_CTRL_BVALID(intf_net_bdry_in_S_AXI_TPG_BVALID),
        .s_axi_CTRL_RDATA(intf_net_bdry_in_S_AXI_TPG_RDATA),
        .s_axi_CTRL_RREADY(intf_net_bdry_in_S_AXI_TPG_RREADY),
        .s_axi_CTRL_RRESP(intf_net_bdry_in_S_AXI_TPG_RRESP),
        .s_axi_CTRL_RVALID(intf_net_bdry_in_S_AXI_TPG_RVALID),
        .s_axi_CTRL_WDATA(intf_net_bdry_in_S_AXI_TPG_WDATA),
        .s_axi_CTRL_WREADY(intf_net_bdry_in_S_AXI_TPG_WREADY),
        .s_axi_CTRL_WSTRB(intf_net_bdry_in_S_AXI_TPG_WSTRB),
        .s_axi_CTRL_WVALID(intf_net_bdry_in_S_AXI_TPG_WVALID),
        .s_axis_video_TDATA(intf_net_bdry_in_s_axis_video_TDATA),
        .s_axis_video_TDEST(1'b0),
        .s_axis_video_TID(1'b0),
        .s_axis_video_TKEEP({1'b1,1'b1,1'b1,1'b1,1'b1,1'b1}),
        .s_axis_video_TLAST(intf_net_bdry_in_s_axis_video_TLAST),
        .s_axis_video_TREADY(intf_net_bdry_in_s_axis_video_TREADY),
        .s_axis_video_TSTRB({1'b1,1'b1,1'b1,1'b1,1'b1,1'b1}),
        .s_axis_video_TUSER(intf_net_bdry_in_s_axis_video_TUSER),
        .s_axis_video_TVALID(intf_net_bdry_in_s_axis_video_TVALID));
endmodule
