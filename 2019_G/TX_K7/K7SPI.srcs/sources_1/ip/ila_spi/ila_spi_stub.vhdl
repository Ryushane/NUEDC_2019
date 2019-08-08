-- Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
-- Date        : Thu Jul 25 21:24:47 2019
-- Host        : Shane-OMEN running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               E:/ryush/Documents/Project/Verilog/K7/K7SPI/K7SPI.srcs/sources_1/ip/ila_spi/ila_spi_stub.vhdl
-- Design      : ila_spi
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7k70tfbg484-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ila_spi is
  Port ( 
    clk : in STD_LOGIC;
    probe0 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe1 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe2 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe3 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe4 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    probe5 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    probe6 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    probe7 : in STD_LOGIC_VECTOR ( 6 downto 0 );
    probe8 : in STD_LOGIC_VECTOR ( 6 downto 0 )
  );

end ila_spi;

architecture stub of ila_spi is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk,probe0[0:0],probe1[0:0],probe2[0:0],probe3[0:0],probe4[7:0],probe5[7:0],probe6[7:0],probe7[6:0],probe8[6:0]";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "ila,Vivado 2017.4";
begin
end;
