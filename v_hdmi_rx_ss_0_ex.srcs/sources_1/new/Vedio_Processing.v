`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/04/20 23:37:13
// Design Name: 
// Module Name: Vedio_Processing
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Vedio_Processing(
    // 连接rx
    input [47:0] axis_IN_tdata,
    input axis_IN_tlast,
    input axis_IN_tuser,
    input axis_IN_tvalid,
    output axis_IN_tready,
    // 连接tx
    output [47:0] axis_OUT_tdata,
    output axis_OUT_tlast,
    output axis_OUT_tuser,
    output axis_OUT_tvalid,
    input axis_OUT_tready
    );
endmodule
