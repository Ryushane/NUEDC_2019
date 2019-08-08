`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/08/07 22:06:46
// Design Name: 
// Module Name: top_0807_16bit
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


module top_0808_16bit#
(
    parameter SAMPLE_RATE = 3, // sampling per 2^n data
    parameter DATA_WIDTH = 12    
)
(
    input CLK_IN,
    input RESET, //low enable
    (*mark_debug = "true"*)input SCK,
    (*mark_debug = "true"*)input CS,

    (*mark_debug = "true"*)input MOSI,
    (*mark_debug = "true"*)output wire MISO,
    (*mark_debug = "true"*)output wire DRDY,

    // ADDA
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
    
    output DA_CLKA,
    output DA_CLKB,
    output DA_WRTA,
    output DA_WRTB,
    output [7:0]DA_DBPA,
    output [7:0]DA_DBPB
);

    wire AD_Local_CLK;

    // 100MHz AD
    clk_wiz_0 Local_CLK_DCM(
    .clk_out1(AD_Local_CLK),    // output clk_out1 100MHz
    .clk_out2(DS_CLK),  // 12.5MHz
    .resetn(RESET),        // input resetn
    .locked(clklocked),
    .clk_in1(CLK_IN)       // input clk_in1
);     



    // assign rst = RESET;
    rstpulse rstpulse_0(
        .clk_in(CLK_IN),
        .clk_sys(AD_Local_CLK),
        .rst_in(RESET),
        .rst(rst)
    );



    wire AD_CLKOUT;
    (*mark_debug = "true"*)wire signed[11:0]AD_Data_A;
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


    (*mark_debug ="true"*)wire signed[DATA_WIDTH-1:0] dsoutdata0;
    DOWNSAMP #(
        .SAMPLE_RATE(SAMPLE_RATE),
        .DATA_WIDTH(DATA_WIDTH)
    )
    downsamp_inst0
    (
        .clk                             ( AD_CLKOUT ),
        .rst                             ( rst ),
        .ena                             ( 1 ),
        .dataIn                          ( AD_Data_A ),
        .dsoutdata                       ( dsoutdata0 ),
        .out_en                          ( out_en0    ),
        .outbusy                         (inwr_rst_busy0)
    ); 

    wire signed[DATA_WIDTH-1:0] inrd_data0;
    fifo_generator_in_ns infifo0(
        .rst(rst),
        .wr_clk(AD_CLKOUT),
        .wr_en(out_en0),
        .din(dsoutdata0),
        
        .rd_clk(DS_CLK),
        .dout(inrd_data0),
        .rd_en(fdm_en),
        .empty(infifo_empty0),       
        .full(infifo_full0),


        .wr_rst_busy(inwr_rst_busy0),
        .rd_rst_busy(inrd_rst_busy0)
    );


    (*mark_debug ="true"*)wire signed[DATA_WIDTH-1:0] dsoutdata1;
    DOWNSAMP #(
        .SAMPLE_RATE(SAMPLE_RATE),
        .DATA_WIDTH(DATA_WIDTH)
    )
    downsamp_inst1
    (
        .clk                             ( AD_CLKOUT ),
        .rst                             ( rst ),
        .ena                             ( 1 ),
        .dataIn                          ( AD_Data_B ),
        .dsoutdata                       ( dsoutdata1 ),
        .out_en                          ( out_en1    ),
        .outbusy                         (inwr_rst_busy1)
    ); 

    wire signed[DATA_WIDTH-1:0] inrd_data1;
    fifo_generator_in_ns1 infifo1(
        .rst(rst),
        .wr_clk(AD_CLKOUT),
        .wr_en(out_en1),
        .din(dsoutdata1),
        
        .rd_clk(DS_CLK),
        .dout(inrd_data1),
        .rd_en(fdm_en),
        .empty(infifo_empty1),       
        .full(infifo_full1),


        .wr_rst_busy(inwr_rst_busy1),
        .rd_rst_busy(inrd_rst_busy1)
    );


    // SPI 
    wire byteReceived; // 在第八个SCK_risingEdge置为1
    wire [7:0] receivedData; // shift register

    // RAM0
    wire[7:0] doutb0;
    wire[6:0] addra0;
    wire[6:0] addrb0;
    wire finisha0;
    wire finishb0;

    // reg[7:0] data_counter;

    // RAM1
    wire[7:0] doutb1;
    wire[6:0] addra1;
    wire[6:0] addrb1;
    wire finisha1;
    wire finishb1;
    wire[15:0] dina1;
    wire wea1;
    wire readya0;

    assign DRDY = readya0 && readyb1;
    
    wire CS_debounced;
    
    DEBOUNCE #(4)u_DEBOUNCE
    (
        .clk(AD_Local_CLK),
        .rst(rst),
        .sig(CS),
        .debounce_sig(CS_debounced)
    );


    SPI_slave  u_SPI_slave (
        .clk                     ( AD_Local_CLK                  ),
        .sck                     ( SCK                     ),
        .rst_n                   ( !rst                   ),
        .mosi                    ( MOSI                    ),
        .miso                    ( MISO                    ),
        .ssel                    ( CS_debounced                    ),
        .receivedData            ( receivedData  [7:0]  ),
        .dataToSend              ( doutb1 [7:0]   ),
        .byteReceived            ( byteReceived),

        // 可选项
        .readya0                 (readya0),
        .readyb1                 (readyb1),
        
        .addra0                  (addra0 [6:0]),
        .addrb1                  (addrb1 [6:0]),
        .finisha0                (finisha0),
        .finishb1                (finishb1)
        );


    // MOSI RAM
    PINGPONG_RAM  u0_PINGPONG_RAM (
        .clka                    ( AD_Local_CLK            ),
        .rsta                    ( rst            ),
        .addra                   ( addra0    [6:0]  ),
        .wea                     ( byteReceived    ), //
        .dina                    ( receivedData [7:0] ),
        .finisha                 ( finisha0         ),
        .readya                  ( readya0          ),

        .clkb                    ( AD_Local_CLK            ),
        .rstb                    ( !RESET            ),
        .addrb                   ( addrb0    [6:0]  ),
        .finishb                 ( finishb0         ),
        .doutb                   ( doutb0    [7:0] ),
        .readyb                  ( readyb0          )
        );

    // input double byte output 16byte
    BYTE_COMB BYTE_COMB(
        .clk(AD_Local_CLK), 
        .rst_n(!rst),
        .datain(doutb0),
        .combbyte(dina1),
        .readyb0(readyb0),
        .addrb0(addrb0), 
        .finishb0(finishb0)
    );

    // downsamp 12.5M
    (*mark_debug = "true"*)wire signed[24:0] fdm_modout;
    assign fdm_en = (!infifo_empty0 && !infifo_empty1);
    FDM_MOD fdm_mod_inst(
        .clk(DS_CLK),
        .rst(rst),
        .inpta(inrd_data0),
        .inptb(inrd_data1),
        .out(fdm_modout)
    );

    // 100M sysclk
    wire signed[7:0] fdm_out;
    FDM_OUT fdm_inst(
        .clk(AD_Local_CLK),
        .rst(rst),
        .sigin(fdm_modout),
        .foffset(dina1),
        .out(fdm_out)
    );


    // DAC
    (*mark_debug = "true"*)wire [7:0]DA_Data_A;
    wire [7:0]DA_Data_B;

    // assign DA_Data_A = AD_Data_A[11:4] + 8'h80;
    // assign DA_Data_B = AD_Data_B[11:4] + 8'h80;
    assign DA_Data_A = fdm_out + 8'h80;
    assign DA_Data_B = fdm_out + 8'h80;

    AD9709_Top AD9709(
        .CLK_IN_A(AD_Local_CLK),
        .CLK_IN_B(AD_Local_CLK),
        .RESET(!rst),
        .DA_Data_A(DA_Data_A),
        .DA_Data_B(DA_Data_B),
        
        .DA_CLKA(DA_CLKA),
        .DA_CLKB(DA_CLKB),
        .DA_WRTA(DA_WRTA),
        .DA_WRTB(DA_WRTB),
        .DA_DBPA(DA_DBPA),
        .DA_DBPB(DA_DBPB)
    );

endmodule
