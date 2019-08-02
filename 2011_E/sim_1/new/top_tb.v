`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/07/26 19:55:45
// Design Name: 
// Module Name: top_tb
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


`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/07/16 18:10:15
// Design Name: 
// Module Name: tb_costasloop
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


module top_tb(

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
        data_file=$fopen("simdat.txt", "r");
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
    

    top_sim top_sim(
        .CLK_IN(clk),
        .RESET(!rst),
        .sigin(dataIn)
    );
endmodule
