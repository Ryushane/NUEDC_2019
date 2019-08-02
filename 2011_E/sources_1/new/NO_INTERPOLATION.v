`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/7/12 10:01:06
// Design Name: 
// Module Name: interpolation
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

module NO_INTERPOLATION
    (
    input ena, // 接上一级fifo的above half, above half 就算 rst_done，然后一直传输
    output rd_en,
    input signed dataIn, 
    output signed inter_data 
    );

    assign rd_en = ena;
    assign inter_data = dataIn;
    
endmodule