`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/08/07 22:10:37
// Design Name: 
// Module Name: BYTE_COMB
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


module BYTE_COMB(
    input wire clk,
    input wire rst_n,
    input wire[7:0] datain,
    output wire[15:0]combbyte,

    // 与RAM交互的线
    input readyb0,
    output [6:0] addrb0,
    output reg finishb0
);

    // wire dataout_w;
    // assign dataout = datain + 1;

    reg[1:0] statecounter;

    always @(posedge clk) begin
        if(!rst_n) begin
            statecounter <= 0;
        end
        else if(readyb0 && statecounter == 0)begin
            statecounter <= 1;
        end
        else if(readyb0 && statecounter == 1)begin
            statecounter <= 2;
        end
        else if(readyb0 && statecounter == 2)begin
            statecounter <= 3;
        end
        else if(readyb0 && statecounter == 3)begin
            statecounter <= 0;
        end
    end

    reg[7:0] lowbyte;
    reg[7:0] highbyte;
    reg[15:0] combbyte_r;
    assign combbyte = combbyte_r;

    always @(posedge clk) begin
        if(!rst_n) begin
            lowbyte <= 0;
            highbyte <= 0;
        end
        else if(statecounter == 2) begin
            highbyte <= datain;
        end
        else if(statecounter == 3) begin
            lowbyte <= datain;
        end
        else if(statecounter == 0) begin
            combbyte_r <= { highbyte, lowbyte };
        end
    end

    assign addrb0 = statecounter;
    // always @(posedge clk) begin
    //     if(!rst_n) begin
    //         addrb0 <= 0;
    //     end
    //     else if(statecounter == 3) begin
    //         addrb0 <= 0;
    //     end
    //     else if(statecounter == 0) begin
    //         addrb0 <= 1;
    //     end
    // end


    always @(posedge clk) begin
        if(!rst_n) begin
            finishb0 <= 0;
        end
        else if(statecounter == 2) begin
            finishb0 <= 1;
        end
        else if(statecounter == 3) begin
            finishb0 <= 0;
        end
    end
endmodule
    