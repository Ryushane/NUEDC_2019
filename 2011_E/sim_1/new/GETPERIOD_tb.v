`timescale 1ns / 1ps
`define NULL 0
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/08/01 12:54:41
// Design Name: 
// Module Name: GETPERIOD_tb
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


module GETPERIOD_tb(

    );
reg clk;
reg rst;
reg sigin;
wire[7:0] freq;

integer f_testdata;

initial begin
    rst = 1;
    clk = 0;
    f_testdata = $fopen("out.txt","r");
    if(f_testdata == `NULL)
        $display("Fail to open out.txt!");
    #50;
    rst = 0;
    $fscanf(f_testdata, "%b", sigin);
end

always #5 clk <= ~clk; //100MHz

always @(posedge clk) begin
    if(!$feof(f_testdata))
        $fscanf(f_testdata, "%b", sigin);
    else begin
        $fclose(f_testdata);
        $finish;
    end
end
        

GETPERIOD GETPERIOD(
    .clk(clk),
    .rst(rst),
    .sigin(sigin),
    .freq(freq)
);

endmodule
