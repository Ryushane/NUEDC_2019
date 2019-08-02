`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/08/02 12:24:26
// Design Name: 
// Module Name: ME_PLL
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


module ME_PLL(
        input clk,
        input rst,
        input sig,
        input [7:0]fc,
        output clkout
    );
    wire [31:0] vcophaseincr;
    reg [31:0] crcenter=32'd8589934;   //~10kHz @ 10MHz
    reg signed [31:0] crmod=32'd0;
    assign vcophaseincr=crcenter+crmod;
    wire vcoout;
    assign clkout=vcoout;
    
    reg [9:0]windowlen=10'd32;
    reg siglast=1'b0;
    reg [9:0] sigedgecnt=10'd0;
    wire sigedge;
    assign sigedge=sigedgecnt>10'd0;
    reg clklast=1'b0;
    reg [9:0] clkedgecnt=10'd0;
    wire clkedge;
    assign clkedge=clkedgecnt>10'd0;
    
    reg signed [15:0]pd=16'sd0;
    
    always@(posedge clk)begin
        if(rst)begin
            crcenter<=32'd8589934;
            crmod<=32'sd0;
            siglast<=1'b0;
            clklast<=1'b0;
            sigedgecnt<=10'd0;
            clkedgecnt<=10'd0;
            pd<=16'sd0;
            windowlen<=10'd32;
        end else begin
            siglast<=sig;
            if(sig==1'b1 && siglast==1'b0)begin
                sigedgecnt<=windowlen;
            end else begin
                if(sigedgecnt>10'd0)begin
                    sigedgecnt<=sigedgecnt-10'd1;
                end
            end
            clklast<=vcoout;
            if(vcoout^clklast)begin
                clkedgecnt<=windowlen;
            end else begin
                if(clkedgecnt>10'd0)begin
                    clkedgecnt<=clkedgecnt-10'd1;
                end
            end
            
            if(sigedge)begin
                if(sigedgecnt<(windowlen/10'd2))begin
                    if(fc>=8'd3)begin
                        if(clkedge)begin
                            pd<=pd-pd/16'sd512+16'sd32;
                        end else begin
                            pd<=pd-pd/16'sd512-16'sd32;
                        end
                    end else begin
                        if(clkedge)begin
                            pd<=pd-pd/16'sd256+16'sd64;
                        end else begin
                            pd<=pd-pd/16'sd256-16'sd64;
                        end
                    end
                end else begin
                    if(fc>=8'd3)begin
                        if(clkedge)begin
                            pd<=pd-pd/16'sd512-16'sd32;
                        end else begin
                            pd<=pd-pd/16'sd512+16'sd32;
                        end
                    end else begin
                        if(clkedge)begin
                            pd<=pd-pd/16'sd256-16'sd64;
                        end else begin
                            pd<=pd-pd/16'sd256+16'sd64;
                        end
                    end
                end
            end else begin
                //crmod<=32'sd128*pd;
                if(fc>=8'd3)begin
                    crmod<=32'sd128*pd;
                end else begin
                    crmod<=32'sd32*pd;
                end
            end
            
            crcenter<=32'd8589934*fc;
            if(fc>=8'd8)begin
                windowlen<=10'd32;
            end else if(fc>=8'd5)begin
                windowlen<=10'd48;
            end else if(fc>=8'd3)begin
                windowlen<=10'd64;
            end else if(fc>=8'd2)begin
                windowlen<=10'd96;
            end else begin
                windowlen<=10'd160;
            end
        end
    end
    
    
    DDS_SQUARE vco_inst(
        .clk(clk), //input clk
        .rst(rst), //input rst
        .phaseincr(vcophaseincr), //input phase increment
        .outs(vcoout), //output outs
        .outc() //output outc
    );
endmodule
