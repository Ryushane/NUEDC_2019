`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: rotom407
// 
// Create Date: 2019/08/01 16:44:29
// Design Name: 
// Module Name: NOISE_REDUCTION
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


module NOISE_REDUCTION(
        input clk,
        input rst,
        input signed [11:0]datin,
        output out
    );
    
    wire signed [11:0]mfout;
    MAX_FILTER mf(
        .clk(clk),
        .rst(rst),
        .in(datin),
        .out(mfout)
    );
    reg signed [23:0]dc=24'sd7024640;
    wire signed [23:0]mfoutexp;
    assign mfoutexp={mfout,12'sd0};
    wire signed [11:0]dccut;
    assign dccut=dc[23:12];
    reg signed [11:0]mfdetrend;
    wire mfcmp;
    assign mfcmp=~mfdetrend[11];
    
    reg [15:0]mfcmpsr=16'd0;
    reg cmpdebounce=1'b0;
    reg [7:0]mfshrinksr=8'd0;
    assign out=(mfshrinksr==8'b11111111);
    always@(posedge clk)begin
        if(rst)begin
            dc<=24'sd7024640;
            mfdetrend<=12'sd0;
            mfcmpsr<=16'd0;
            cmpdebounce<=1'b0;
        end else begin
            dc<=dc-dc/32'sd32768+mfoutexp/32'sd32768;
            mfdetrend<=mfout-dccut;
            
            mfcmpsr<={mfcmpsr[14:0],mfcmp};
            if(mfcmpsr==16'b1111111111111111 && cmpdebounce==1'b0)begin
                cmpdebounce<=1'b1;
            end else begin
                if(mfcmpsr==16'd0 && cmpdebounce==1'b1)begin
                    cmpdebounce<=1'b0;
                end
            end
            
            mfshrinksr<={mfshrinksr[6:0],cmpdebounce};
        end
    end
endmodule
