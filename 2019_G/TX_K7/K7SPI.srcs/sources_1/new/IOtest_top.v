`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/07/24 14:23:06
// Design Name: 
// Module Name: IOtest_top
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


module IOtest_top(
    input CLK_IN,
    input RESET,
    input INSIG,
    output CLKSIG,
    output PLUSSIG
    );

    reg testsig;
    reg[7:0] clkcounter;

    always @(posedge CLK_IN) begin
        if(!RESET)
            clkcounter <= 0;
        else clkcounter <= clkcounter + 1;
    end

    always @(posedge CLK_IN) begin
        if(!RESET)
            testsig <= 0;
        else if(clkcounter == 0)
            testsig <= ~testsig;
    end

    assign CLKSIG = testsig;
    assign PLUSSIG = ~INSIG;

endmodule
