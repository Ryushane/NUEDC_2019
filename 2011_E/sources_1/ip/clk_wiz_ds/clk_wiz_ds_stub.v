// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
// Date        : Thu Aug  1 20:23:49 2019
// Host        : Shane-OMEN running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               e:/ryush/Documents/Project/Verilog/K7/2011-E/K7_AD_DA_17.4.xpr/K7_AD_DA_17.4/K7_AD_DA_17.4.srcs/sources_1/ip/clk_wiz_ds/clk_wiz_ds_stub.v
// Design      : clk_wiz_ds
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7k70tfbg484-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module clk_wiz_ds(clk_out1, reset, locked, clk_in1)
/* synthesis syn_black_box black_box_pad_pin="clk_out1,reset,locked,clk_in1" */;
  output clk_out1;
  input reset;
  output locked;
  input clk_in1;
endmodule
