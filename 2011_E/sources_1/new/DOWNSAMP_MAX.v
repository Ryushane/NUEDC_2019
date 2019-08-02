`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/08/01 16:07:27
// Design Name: 
// Module Name: DOWNSAMP_MAX
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


module DOWNSAMP_MAX(
        input clk,
        input rst,
        input ena,
        input signed [11:0] dataIn,
        output signed [11:0] dsoutdata,
        output out_en,
        input outbusy
    );
    reg [7:0]ds_counter=8'd0;
    reg out_en_r0=1'b0;
    assign out_en=out_en_r0&&(~outbusy);
    reg signed [11:0]dsoutdata_r0=12'sd0;
    assign dsoutdata=dsoutdata_r0;
    wire signed [11:0]dsoutdatamax;
    assign dsoutdatamax=(dataIn>dsoutdata_r0)?dataIn:dsoutdata_r0;
    
    always@(posedge clk)begin
        if(rst)begin
            ds_counter<=8'd0;
            out_en_r0<=1'b0;
            dsoutdata_r0<=12'sd0;
        end else begin
            if(ena)begin
                if(ds_counter<8'd9)begin
                    ds_counter<=ds_counter+8'd1;
                    dsoutdata_r0<=dsoutdatamax;
                end else begin
                    ds_counter<=8'd0;
                    dsoutdata_r0<=dataIn;
                end
                if(ds_counter==8'd8)begin
                    out_en_r0<=1'b1;
                end else begin
                    out_en_r0<=1'b0;
                end
            end
        end
    end
endmodule
