`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: rotom407
// 
// Create Date: 2019/08/07 11:41:42
// Design Name: 
// Module Name: FDM_MOD
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


module FDM_MOD(
    input clk,
    input rst,
    input signed [11:0] inpta,
    input signed [11:0] inptb,
    output signed [24:0] out
    );
    
    wire ddsvalid;
    wire signed [11:0]ddsout;
    
    reg signed [23:0]inptbmul=24'sd0;
    reg signed [24:0]out_r0=25'sd0;
    assign out=out_r0;
    
    always@(posedge clk)begin
        if(rst)begin
            inptbmul<=24'sd0;
            out_r0<=25'sd0;
        end else begin
            inptbmul<=ddsout*inptb;
            out_r0<=inptbmul+inpta*25'sd4096;
        end
    end
    
    dds_fdmlo dds_inst (
      .aclk(clk),                                // input wire aclk
      .m_axis_data_tvalid(ddsvalid),    // output wire m_axis_data_tvalid
      .m_axis_data_tdata(ddsout),      // output wire [31 : 0] m_axis_data_tdata
      .m_axis_phase_tvalid(),  // output wire m_axis_phase_tvalid
      .m_axis_phase_tdata()    // output wire [15 : 0] m_axis_phase_tdata
    );
endmodule
