`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/08/01 15:35:24
// Design Name: 
// Module Name: top
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


module clkrectop(
        input clkin,
        input rst,
        input signed [11:0] dataIn,
        output out
    );
    
    wire clk_ss;
    wire clk_ds;
    clk_wiz_0 clkwiz
       (
        // Clock out ports
        .clk_ss(clk_ss),     // output clk_ss
        .clk_ds(clk_ds),     // output clk_ds
        // Status and control signals
        .reset(rst), // input reset
        .locked(),       // output locked
       // Clock in ports
        .clk_in1(clkin));      // input clk_in1
     
    wire signed [11:0]dsoutdata;
    wire out_en;
    wire outbusy;
    DOWNSAMP_MAX dsm(
        .clk(clk_ss),
        .ena(1'b1),
        .dataIn(dataIn),
        .dsoutdata(dsoutdata),
        .out_en(out_en),
        .outbusy(outbusy)
    );
    
    reg rd_en=1'b1;
    wire signed [11:0]dout;
    wire full;
    wire empty;
    wire rd_rst_busy;
    fifo_generator_0 fifo_ad (
      .rst(rst),                  // input wire rst
      .wr_clk(clk_ss),            // input wire wr_clk
      .rd_clk(clk_ds),            // input wire rd_clk
      .din(dsoutdata),                  // input wire [11 : 0] din
      .wr_en(out_en),              // input wire wr_en
      .rd_en(rd_en),              // input wire rd_en
      .dout(dout),                // output wire [11 : 0] dout
      .full(full),                // output wire full
      .empty(empty),              // output wire empty
      .wr_rst_busy(outbusy),  // output wire wr_rst_busy
      .rd_rst_busy(rd_rst_busy)  // output wire rd_rst_busy
    );
    
    NOISE_REDUCTION nr(
        .clk(clk_ds),
        .rst(rst),
        .datin(dout),
        .out(out)
    );
endmodule
