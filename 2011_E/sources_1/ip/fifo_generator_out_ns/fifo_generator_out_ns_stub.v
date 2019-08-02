// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
// Date        : Thu Aug  1 20:28:27 2019
// Host        : Shane-OMEN running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               E:/ryush/Documents/Project/Verilog/K7/2011-E/K7_AD_DA_17.4.xpr/K7_AD_DA_17.4/K7_AD_DA_17.4.srcs/sources_1/ip/fifo_generator_out_ns/fifo_generator_out_ns_stub.v
// Design      : fifo_generator_out_ns
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7k70tfbg484-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "fifo_generator_v13_2_1,Vivado 2017.4" *)
module fifo_generator_out_ns(clk, srst, din, wr_en, rd_en, dout, full, empty, 
  prog_full)
/* synthesis syn_black_box black_box_pad_pin="clk,srst,din[0:0],wr_en,rd_en,dout[0:0],full,empty,prog_full" */;
  input clk;
  input srst;
  input [0:0]din;
  input wr_en;
  input rd_en;
  output [0:0]dout;
  output full;
  output empty;
  output prog_full;
endmodule
