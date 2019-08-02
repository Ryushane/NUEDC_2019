`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/08/01 16:20:28
// Design Name: 
// Module Name: tb_all
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


module tb_all(

    );
    
    reg clk=1'b0;
    reg clkds=1'b0;
    reg rst=1'b1;
    
    reg signed [11:0]dataIn=12'sd0;
    
    initial begin
        #100 rst<=1'b0;
    end
    
    integer data_file; // file handler
    integer scan_file; // file handler
    reg signed [11:0] captured_data;
    initial begin
        data_file=$fopen("D:\\simdat.txt", "r");
        if(data_file==0)begin
            $display("data_file handle was NULL");
            $finish;
        end
    end
    
    always@(posedge clk)begin
        if(~rst)begin
            scan_file=$fscanf(data_file, "%d\n", captured_data);
            if (!$feof(data_file)) begin
                dataIn<=captured_data;
            end else begin
                $finish;
            end
        end
    end
    
    always begin
        #5 clk<=~clk;
    end
    
    always begin
        #50 clkds<=~clkds;
    end
    
    wire signed [11:0]dsoutdata;
    wire out_en;
    wire outbusy;
    DOWNSAMP_MAX dsm(
        .clk(clk),
        .ena(1'b1),
        .dataIn(dataIn),
        .dsoutdata(dsoutdata),
        .out_en(out_en),
        .outbusy(outbusy)
    );
    
    reg rd_en=1'b1;
    wire signed [11:0]dout;
    wire full;
    wire empty;
    wire rd_rst_busy;
    fifo_generator_0 fifo_ad (
      .rst(rst),                  // input wire rst
      .wr_clk(clk),            // input wire wr_clk
      .rd_clk(clkds),            // input wire rd_clk
      .din(dsoutdata),                  // input wire [11 : 0] din
      .wr_en(out_en),              // input wire wr_en
      .rd_en(rd_en),              // input wire rd_en
      .dout(dout),                // output wire [11 : 0] dout
      .full(full),                // output wire full
      .empty(empty),              // output wire empty
      .wr_rst_busy(outbusy),  // output wire wr_rst_busy
      .rd_rst_busy(rd_rst_busy)  // output wire rd_rst_busy
    );
    
    wire nrout;
    NOISE_REDUCTION nr(
        .clk(clkds),
        .rst(rst),
        .datin(dout),
        .out(nrout)
    );
    
endmodule
