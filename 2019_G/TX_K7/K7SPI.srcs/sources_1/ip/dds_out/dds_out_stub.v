// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
// Date        : Wed Aug  7 23:43:31 2019
// Host        : Shane-OMEN running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               e:/ryush/Documents/Project/Verilog/2019_NUEDC/K7SPI/K7SPI.srcs/sources_1/ip/dds_out/dds_out_stub.v
// Design      : dds_out
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7k70tfbg484-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "dds_compiler_v6_0_15,Vivado 2017.4" *)
module dds_out(aclk, s_axis_phase_tvalid, 
  s_axis_phase_tdata, m_axis_data_tvalid, m_axis_data_tdata, m_axis_phase_tvalid, 
  m_axis_phase_tdata)
/* synthesis syn_black_box black_box_pad_pin="aclk,s_axis_phase_tvalid,s_axis_phase_tdata[47:0],m_axis_data_tvalid,m_axis_data_tdata[7:0],m_axis_phase_tvalid,m_axis_phase_tdata[47:0]" */;
  input aclk;
  input s_axis_phase_tvalid;
  input [47:0]s_axis_phase_tdata;
  output m_axis_data_tvalid;
  output [7:0]m_axis_data_tdata;
  output m_axis_phase_tvalid;
  output [47:0]m_axis_phase_tdata;
endmodule
