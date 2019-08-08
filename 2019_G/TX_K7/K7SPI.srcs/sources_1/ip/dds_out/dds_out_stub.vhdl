-- Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
-- Date        : Wed Aug  7 23:43:31 2019
-- Host        : Shane-OMEN running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               e:/ryush/Documents/Project/Verilog/2019_NUEDC/K7SPI/K7SPI.srcs/sources_1/ip/dds_out/dds_out_stub.vhdl
-- Design      : dds_out
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7k70tfbg484-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity dds_out is
  Port ( 
    aclk : in STD_LOGIC;
    s_axis_phase_tvalid : in STD_LOGIC;
    s_axis_phase_tdata : in STD_LOGIC_VECTOR ( 47 downto 0 );
    m_axis_data_tvalid : out STD_LOGIC;
    m_axis_data_tdata : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axis_phase_tvalid : out STD_LOGIC;
    m_axis_phase_tdata : out STD_LOGIC_VECTOR ( 47 downto 0 )
  );

end dds_out;

architecture stub of dds_out is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "aclk,s_axis_phase_tvalid,s_axis_phase_tdata[47:0],m_axis_data_tvalid,m_axis_data_tdata[7:0],m_axis_phase_tvalid,m_axis_phase_tdata[47:0]";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "dds_compiler_v6_0_15,Vivado 2017.4";
begin
end;
