`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/08/07 20:34:20
// Design Name: 
// Module Name: FDM_OUT
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


module FDM_OUT(
        input clk,
        input rst,
        input signed [24:0]sigin,
        input signed [15:0]foffset,
        output signed [7:0]out
    );
    reg signed [24:0]sigin_r1=25'sd0;
    reg signed [24:0]sigin_r2=25'sd0;
    reg signed [47:0]ddsfreqsigmod=48'sd0;
    reg signed [47:0]ddsfoffset=48'sd0;
    reg signed [47:0]ddsfreq=48'sd2814749767106;
    always@(posedge clk)begin
        sigin_r1<=sigin;
        sigin_r2<=sigin_r1;
        ddsfreqsigmod<=sigin*48'sd16+sigin*48'sd8;
        ddsfoffset<=foffset*48'sd524288;
        ddsfreq<=48'sd2814749767106+ddsfreqsigmod+ddsfoffset;
    end
    
    dds_out dds_inst (
      .aclk(clk),                                // input wire aclk
      .s_axis_phase_tvalid(1'b1),  // input wire s_axis_phase_tvalid
      .s_axis_phase_tdata(ddsfreq),    // input wire [47 : 0] s_axis_phase_tdata
      .m_axis_data_tvalid(),    // output wire m_axis_data_tvalid
      .m_axis_data_tdata(out),      // output wire [7 : 0] m_axis_data_tdata
      .m_axis_phase_tvalid(),  // output wire m_axis_phase_tvalid
      .m_axis_phase_tdata()    // output wire [47 : 0] m_axis_phase_tdata
    );
endmodule
