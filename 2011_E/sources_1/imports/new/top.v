`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/08/01 21:33:13
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


module top#(
    parameter DATA_WIDTH = 12,
    parameter SAMPLE_RATE = 0
)
(
    input CLK_IN,
    input RESET,
    
    output AD_SDATA,
    output AD_RESET,
    output AD_SEN,
    output AD_SCLK,
    input AD_SDOUT,
    output [2:0]AD_CTRL,
    input [5:0]AD_DA_P,
    input [5:0]AD_DA_N,
    input [5:0]AD_DB_P,
    input [5:0]AD_DB_N,
    input AD_CLKOUT_P,
    input AD_CLKOUT_N,
    output Local_CLKOUT_P,
    output Local_CLKOUT_N,

    output DATAOUT,
    output PLLCLKOUT,
    output LED
);

wire AD_Local_CLK;

clk_wiz_0 Local_CLK_DCM(
    .clk_out1(AD_Local_CLK),    // output clk_out1
    .resetn(RESET),        // input resetn
    .locked(clklocked),
    .clk_in1(CLK_IN)       // input clk_in1
);      


// assign rst = RESET;
rstpulse rstpulse_0(
    .clk_in(CLK_IN),
    .clk_sys(ds_clk),
    .rst_in(RESET),
    .rst(rst)
);

wire AD_CLKOUT;
(*mark_debug ="true"*)wire signed[11:0]AD_Data_A;
wire signed[11:0]AD_Data_B;

ADS4226_Top #(
    .AD_SAMPLE_RATE(100))
ADS4226(
    .Local_CLKIN(AD_Local_CLK),
    .RESET(!rst),
    .AD_CLKOUT(AD_CLKOUT),
    .AD_Data_A(AD_Data_A),
    .AD_Data_B(AD_Data_B),
    
    .AD_SDATA(AD_SDATA),
    .AD_RESET(AD_RESET),
    .AD_SEN(AD_SEN),
    .AD_SCLK(AD_SCLK),
    .AD_SDOUT(AD_SDOUT),
    .AD_CTRL(AD_CTRL),
    .AD_DA_P(AD_DA_P),
    .AD_DA_N(AD_DA_N),
    .AD_DB_P(AD_DB_P),
    .AD_DB_N(AD_DB_N),
    .AD_CLKOUT_P(AD_CLKOUT_P),
    .AD_CLKOUT_N(AD_CLKOUT_N),
    .Local_CLKOUT_P(Local_CLKOUT_P),
    .Local_CLKOUT_N(Local_CLKOUT_N)
);

// SAMPLING MODULE
    (*mark_debug ="true"*)wire signed [11:0]dsoutdata;
    wire out_en;
    wire outbusy;
    DOWNSAMP_MAX dsm(
        .clk(AD_CLKOUT),
        .rst(rst),
        .ena(1'b1),
        .dataIn(AD_Data_A),
        .dsoutdata(dsoutdata),
        .out_en(out_en),
        .outbusy(inwr_rst_busy)
    );


clk_wiz_ds Ds_FIFO_CLK(
    .clk_out1(ds_clk),
    .reset(!RESET),
    .locked(fifoclklocked),
    .clk_in1(CLK_IN)
);

wire signed[DATA_WIDTH-1+SAMPLE_RATE:0] inrd_data;
assign dsp_en = !((infifo_empty) || inrd_rst_busy);
fifo_generator_in_ns infifo(
    .rst(rst),
    .wr_clk(AD_CLKOUT),
    .wr_en(out_en),
    .din(dsoutdata),
    
    .rd_clk(ds_clk),
    .dout(inrd_data),
    .rd_en(dsp_en),
    .empty(infifo_empty),       
    .full(infifo_full),


    .wr_rst_busy(inwr_rst_busy),
    .rd_rst_busy(inrd_rst_busy)
);

wire nrout;
NOISE_REDUCTION nr(
    .clk(ds_clk),
    .rst(rst),
    .datin(inrd_data),
    .out(nrout)
);


// (*mark_debug ="true"*)wire signed outrd_data;

wire[7:0] centerFreq;
GETPERIOD getperiod(
    .clk(ds_clk),
    .rst(rst),
    .sigin(nrout),
    .freq(centerFreq)
);

wire pll_out;
assign PLLCLKOUT = pll_out;
ME_PLL me_pll(
    .clk(ds_clk),
    .rst(rst),
    .sig(nrout),
    .fc(centerFreq),
    .clkoutstab(pll_out)
);

// fifo_generator_out_ns outfifo(
//     .srst(rst),
//     .clk(ds_clk),
//     .wr_en(dsp_en),
//     .din(nrout),

//     .dout(outrd_data),
//     .rd_en(outrd_en),

//     .empty(outfifo_empty),
//     .full(outfifo_full)

// );


// wire signed inter_data;

// NO_INTERPOLATION no_interpolation(
//     .ena                             ( 1 ),
//     .rd_en                           ( outrd_en   ),
//     .dataIn                          ( outrd_data ),
//     .inter_data                      ( inter_data )
// );

assign DATAOUT = nrout;
assign LED = 1;

endmodule
