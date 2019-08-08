// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
// Date        : Thu Jul 25 21:24:47 2019
// Host        : Shane-OMEN running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               E:/ryush/Documents/Project/Verilog/K7/K7SPI/K7SPI.srcs/sources_1/ip/ila_spi/ila_spi_stub.v
// Design      : ila_spi
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7k70tfbg484-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "ila,Vivado 2017.4" *)
module ila_spi(clk, probe0, probe1, probe2, probe3, probe4, probe5, 
  probe6, probe7, probe8)
/* synthesis syn_black_box black_box_pad_pin="clk,probe0[0:0],probe1[0:0],probe2[0:0],probe3[0:0],probe4[7:0],probe5[7:0],probe6[7:0],probe7[6:0],probe8[6:0]" */;
  input clk;
  input [0:0]probe0;
  input [0:0]probe1;
  input [0:0]probe2;
  input [0:0]probe3;
  input [7:0]probe4;
  input [7:0]probe5;
  input [7:0]probe6;
  input [6:0]probe7;
  input [6:0]probe8;
endmodule
