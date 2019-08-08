`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/7/12 10:01:06
// Design Name: 
// Module Name: DOWNSAMP
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

module DOWNSAMP#(
    parameter SAMPLE_RATE = 3, // sampling per 2^n data
    parameter DATA_WIDTH = 12
)
(
    input clk,
    input rst,
    input ena, 
    input signed[DATA_WIDTH-1:0] dataIn,
    output signed [DATA_WIDTH-1:0] dsoutdata,
    output out_en,
    
    input outbusy
);
    assign out_en = (ds_counter == 0)&&(!outbusy);
    reg[SAMPLE_RATE-1:0] ds_counter;

    // wire hbit; 
    // wire[DATA_WIDTH-1:0] us_dataIn;
    // assign hbit = (dataIn[DATA_WIDTH-1] == 1) ? 1'b0 : 1'b1;
    // assign us_dataIn = { hbit, dataIn[DATA_WIDTH-2:0]};

    always @(posedge clk) begin
        if(rst)
            ds_counter <= 0;
        else if(ena)
            ds_counter <= ds_counter + 1; 
    end

    reg signed [DATA_WIDTH+SAMPLE_RATE-1:0] dsoutdata_r;
    assign dsoutdata = dsoutdata_r[DATA_WIDTH+SAMPLE_RATE-1:SAMPLE_RATE];
    always @(posedge clk) begin
        if(rst)
            dsoutdata_r <= 0;
        else if(!ena)
            dsoutdata_r <= 0;
        else if(ds_counter == 0)
            dsoutdata_r <= dataIn;
        else 
            dsoutdata_r <= dsoutdata_r + dataIn;
    end

endmodule