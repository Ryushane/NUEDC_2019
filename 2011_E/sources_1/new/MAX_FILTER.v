`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/08/01 16:47:00
// Design Name: 
// Module Name: MAX_FILTER
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


module MAX_FILTER(
        input clk,
        input rst,
        input signed [11:0]in,
        output signed [11:0]out
    );
    reg signed [11:0]dat_r1=12'sd0;
    reg signed [11:0]dat_r2=12'sd0;
    reg signed [11:0]dat_r3=12'sd0;
    reg signed [11:0]dat_r4=12'sd0;
    reg signed [11:0]dat_r5=12'sd0;
    reg signed [11:0]dat_r6=12'sd0;
    reg signed [11:0]dat_r7=12'sd0;
    reg signed [11:0]dat_r8=12'sd0;
    reg signed [11:0]dat_r9=12'sd0;
    reg signed [11:0]dat_r10=12'sd0;
    reg signed [11:0]dat_r11=12'sd0;
    reg signed [11:0]dat_r12=12'sd0;
    reg signed [11:0]dat_r13=12'sd0;
    reg signed [11:0]dat_r14=12'sd0;
    reg signed [11:0]dat_r15=12'sd0;
    reg signed [11:0]dat_r16=12'sd0;
    
    reg signed [11:0]max11=12'sd0;
    reg signed [11:0]max12=12'sd0;
    reg signed [11:0]max13=12'sd0;
    reg signed [11:0]max14=12'sd0;
    reg signed [11:0]max15=12'sd0;
    reg signed [11:0]max16=12'sd0;
    reg signed [11:0]max17=12'sd0;
    reg signed [11:0]max18=12'sd0;
    
    reg signed [11:0]max21=12'sd0;
    reg signed [11:0]max22=12'sd0;
    reg signed [11:0]max23=12'sd0;
    reg signed [11:0]max24=12'sd0;
    
    reg signed [11:0]max31=12'sd0;
    reg signed [11:0]max32=12'sd0;
    
    reg signed [11:0]out_r0;
    assign out=out_r0;
    
    always@(posedge clk)begin
        //no reset logic but whatever
        dat_r1<=in;
        dat_r2<=dat_r1;
        dat_r3<=dat_r2;
        dat_r4<=dat_r3;
        dat_r5<=dat_r4;
        dat_r6<=dat_r5;
        dat_r7<=dat_r6;
        dat_r8<=dat_r7;
        dat_r9<=dat_r8;
        dat_r10<=dat_r9;
        dat_r11<=dat_r10;
        dat_r12<=dat_r11;
        dat_r13<=dat_r12;
        dat_r14<=dat_r13;
        dat_r15<=dat_r14;
        dat_r16<=dat_r15;
        
        max11<=(dat_r1>dat_r2)?dat_r1:dat_r2;
        max12<=(dat_r3>dat_r4)?dat_r3:dat_r4;
        max13<=(dat_r5>dat_r6)?dat_r5:dat_r6;
        max14<=(dat_r7>dat_r8)?dat_r7:dat_r8;
        max15<=(dat_r9>dat_r10)?dat_r9:dat_r10;
        max16<=(dat_r11>dat_r12)?dat_r11:dat_r12;
        max17<=(dat_r13>dat_r14)?dat_r13:dat_r14;
        max18<=(dat_r15>dat_r16)?dat_r15:dat_r16;
        
        max21<=(max11>max12)?max11:max12;
        max22<=(max13>max14)?max13:max14;
        max23<=(max15>max16)?max15:max16;
        max24<=(max17>max18)?max17:max18;
        
        max31<=(max21>max22)?max21:max22;
        max32<=(max23>max24)?max23:max24;
        
        out_r0<=(max31>max32)?max31:max32;
    end
endmodule
