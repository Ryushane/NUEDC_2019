`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/08/01 11:52:37
// Design Name: 
// Module Name: GETPERIOD
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

// Downsampling freq 10MHz, Datarate 10kHz 1000k, 1000 data per period

module GETPERIOD(
    input clk,
    input rst,
    input sigin,
    output reg[7:0] freq
    );


// 在两个上升沿之间计算
reg[15:0] data_width;
reg[1:0] sigin_r;
reg[15:0] width_counter; // calculate the date width
reg[19:0] samp_counter; //sample data num


// Sampling period
always @(posedge clk) begin
    if(rst) begin
        samp_counter <= 0;
    end
    else begin
        samp_counter <= samp_counter + 1;
    end
end


wire sig_risingEdge = (sigin_r == 2'b01);
wire sig_fallingEdge = (sigin_r == 2'b10);
// find the posedge of sigin
always @(posedge clk) begin
    if(rst) begin
        sigin_r = 2'b11;
    end
    else
        sigin_r = {sigin_r[0], sigin};
end

// sampling begin at posedge of signal
reg counter_flag;

always @(posedge clk) begin
    if(rst || (samp_counter==0)) begin
        width_counter <= 0;
        counter_flag <= 0;
    end
    else if(sig_risingEdge) begin
        width_counter <= 0;
        counter_flag <= 1;
    end
    else if(counter_flag) begin
        width_counter <= width_counter + 1;
    end
end

always @(posedge clk) begin
    if(rst|| (samp_counter==0)) begin
        data_width <= 0;
    end
    else if(data_width < width_counter) begin
        data_width <= width_counter;
    end
end


// output the central frequency of input signal
always @(posedge clk) begin
    if(rst) begin
        freq <=0;
    end
    else if(samp_counter == 20'b11111111111111111111) begin
        if(data_width > 16'd1500) // 1200
            freq <= 1;
        else if(data_width > 16'd700)
            freq <= 2;
        else if(data_width > 16'd580) // 520
            freq <= 3;
        else if(data_width > 16'd430)
            freq <= 4;
        else if(data_width > 16'd360)
            freq <= 5;
        else if(data_width > 16'd300)
            freq <= 6;
        else if(data_width > 16'd265)
            freq <= 7;
        else if(data_width > 16'd235)
            freq <= 8;
        else if(data_width > 16'd210)
            freq <= 9;
        else if(data_width > 16'd190)
            freq <= 10;
    end
end

endmodule