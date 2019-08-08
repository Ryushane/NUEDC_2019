#constraints

set_property -dict {PACKAGE_PIN N18 IOSTANDARD LVCMOS25} [get_ports CLK_IN]
set_property -dict {PACKAGE_PIN P19 IOSTANDARD LVCMOS25} [get_ports RESET]

set_property -dict {PACKAGE_PIN P2 IOSTANDARD LVCMOS18} [get_ports AD_SDATA]
set_property -dict {PACKAGE_PIN R2 IOSTANDARD LVCMOS18} [get_ports AD_RESET]
set_property -dict {PACKAGE_PIN P1 IOSTANDARD LVCMOS18} [get_ports AD_SEN]
set_property -dict {PACKAGE_PIN R1 IOSTANDARD LVCMOS18} [get_ports AD_SCLK]
set_property -dict {PACKAGE_PIN AA1 IOSTANDARD LVCMOS18} [get_ports AD_SDOUT]
set_property -dict {PACKAGE_PIN Y11 IOSTANDARD LVCMOS18} [get_ports {AD_CTRL[0]}]
set_property -dict {PACKAGE_PIN AB10 IOSTANDARD LVCMOS18} [get_ports {AD_CTRL[1]}]
set_property -dict {PACKAGE_PIN AA10 IOSTANDARD LVCMOS18} [get_ports {AD_CTRL[2]}]

set_property -dict {PACKAGE_PIN AA9 IOSTANDARD LVDS DIFF_TERM 1} [get_ports {AD_DA_P[0]}]
set_property -dict {PACKAGE_PIN AA8 IOSTANDARD LVDS DIFF_TERM 1} [get_ports {AD_DA_N[0]}]
set_property -dict {PACKAGE_PIN T5 IOSTANDARD LVDS DIFF_TERM 1} [get_ports {AD_DA_P[1]}]
set_property -dict {PACKAGE_PIN U5 IOSTANDARD LVDS DIFF_TERM 1} [get_ports {AD_DA_N[1]}]
set_property -dict {PACKAGE_PIN W6 IOSTANDARD LVDS DIFF_TERM 1} [get_ports {AD_DA_P[2]}]
set_property -dict {PACKAGE_PIN Y6 IOSTANDARD LVDS DIFF_TERM 1} [get_ports {AD_DA_N[2]}]
set_property -dict {PACKAGE_PIN AA6 IOSTANDARD LVDS DIFF_TERM 1} [get_ports {AD_DA_P[3]}]
set_property -dict {PACKAGE_PIN AB6 IOSTANDARD LVDS DIFF_TERM 1} [get_ports {AD_DA_N[3]}]
set_property -dict {PACKAGE_PIN AA5 IOSTANDARD LVDS DIFF_TERM 1} [get_ports {AD_DA_P[4]}]
set_property -dict {PACKAGE_PIN AB5 IOSTANDARD LVDS DIFF_TERM 1} [get_ports {AD_DA_N[4]}]
set_property -dict {PACKAGE_PIN W5 IOSTANDARD LVDS DIFF_TERM 1} [get_ports {AD_DA_P[5]}]
set_property -dict {PACKAGE_PIN Y4 IOSTANDARD LVDS DIFF_TERM 1} [get_ports {AD_DA_N[5]}]

set_property -dict {PACKAGE_PIN AA3 IOSTANDARD LVDS DIFF_TERM 1} [get_ports {AD_DB_P[0]}]
set_property -dict {PACKAGE_PIN AB2 IOSTANDARD LVDS DIFF_TERM 1} [get_ports {AD_DB_N[0]}]
set_property -dict {PACKAGE_PIN Y3 IOSTANDARD LVDS DIFF_TERM 1} [get_ports {AD_DB_P[1]}]
set_property -dict {PACKAGE_PIN Y2 IOSTANDARD LVDS DIFF_TERM 1} [get_ports {AD_DB_N[1]}]
set_property -dict {PACKAGE_PIN W1 IOSTANDARD LVDS DIFF_TERM 1} [get_ports {AD_DB_P[2]}]
set_property -dict {PACKAGE_PIN Y1 IOSTANDARD LVDS DIFF_TERM 1} [get_ports {AD_DB_N[2]}]
set_property -dict {PACKAGE_PIN V3 IOSTANDARD LVDS DIFF_TERM 1} [get_ports {AD_DB_P[3]}]
set_property -dict {PACKAGE_PIN W2 IOSTANDARD LVDS DIFF_TERM 1} [get_ports {AD_DB_N[3]}]
set_property -dict {PACKAGE_PIN U2 IOSTANDARD LVDS DIFF_TERM 1} [get_ports {AD_DB_P[4]}]
set_property -dict {PACKAGE_PIN V2 IOSTANDARD LVDS DIFF_TERM 1} [get_ports {AD_DB_N[4]}]
set_property -dict {PACKAGE_PIN T1 IOSTANDARD LVDS DIFF_TERM 1} [get_ports {AD_DB_P[5]}]
set_property -dict {PACKAGE_PIN U1 IOSTANDARD LVDS DIFF_TERM 1} [get_ports {AD_DB_N[5]}]

set_property -dict {PACKAGE_PIN T4 IOSTANDARD LVDS DIFF_TERM 1} [get_ports AD_CLKOUT_P]
set_property -dict {PACKAGE_PIN U3 IOSTANDARD LVDS DIFF_TERM 1} [get_ports AD_CLKOUT_N]

set_property -dict {PACKAGE_PIN AA11 IOSTANDARD LVDS} [get_ports Local_CLKOUT_P]
set_property -dict {PACKAGE_PIN AB11 IOSTANDARD LVDS} [get_ports Local_CLKOUT_N]

set_property -dict {PACKAGE_PIN W15 IOSTANDARD LVCMOS33} [get_ports DA_CLKA]
set_property -dict {PACKAGE_PIN Y16 IOSTANDARD LVCMOS33} [get_ports DA_CLKB]
set_property -dict {PACKAGE_PIN AA18 IOSTANDARD LVCMOS33} [get_ports DA_WRTA]
set_property -dict {PACKAGE_PIN AB18 IOSTANDARD LVCMOS33} [get_ports DA_WRTB]

set_property -dict {PACKAGE_PIN W16 IOSTANDARD LVCMOS33} [get_ports {DA_DBPA[0]}]
set_property -dict {PACKAGE_PIN V15 IOSTANDARD LVCMOS33} [get_ports {DA_DBPA[1]}]
set_property -dict {PACKAGE_PIN U15 IOSTANDARD LVCMOS33} [get_ports {DA_DBPA[2]}]
set_property -dict {PACKAGE_PIN U16 IOSTANDARD LVCMOS33} [get_ports {DA_DBPA[3]}]
set_property -dict {PACKAGE_PIN V17 IOSTANDARD LVCMOS33} [get_ports {DA_DBPA[4]}]
set_property -dict {PACKAGE_PIN T15 IOSTANDARD LVCMOS33} [get_ports {DA_DBPA[5]}]
set_property -dict {PACKAGE_PIN T16 IOSTANDARD LVCMOS33} [get_ports {DA_DBPA[6]}]
set_property -dict {PACKAGE_PIN R16 IOSTANDARD LVCMOS33} [get_ports {DA_DBPA[7]}]

set_property -dict {PACKAGE_PIN AA14 IOSTANDARD LVCMOS33} [get_ports {DA_DBPB[0]}]
set_property -dict {PACKAGE_PIN AB15 IOSTANDARD LVCMOS33} [get_ports {DA_DBPB[1]}]
set_property -dict {PACKAGE_PIN AA15 IOSTANDARD LVCMOS33} [get_ports {DA_DBPB[2]}]
set_property -dict {PACKAGE_PIN AB16 IOSTANDARD LVCMOS33} [get_ports {DA_DBPB[3]}]
set_property -dict {PACKAGE_PIN Y14 IOSTANDARD LVCMOS33} [get_ports {DA_DBPB[4]}]
set_property -dict {PACKAGE_PIN AA16 IOSTANDARD LVCMOS33} [get_ports {DA_DBPB[5]}]
set_property -dict {PACKAGE_PIN AB17 IOSTANDARD LVCMOS33} [get_ports {DA_DBPB[6]}]
set_property -dict {PACKAGE_PIN W14 IOSTANDARD LVCMOS33} [get_ports {DA_DBPB[7]}]


#IO bank
set_property -dict {PACKAGE_PIN B18 IOSTANDARD LVCMOS33} [get_ports SCK]
set_property -dict {PACKAGE_PIN A19 IOSTANDARD LVCMOS33} [get_ports CS]
set_property -dict {PACKAGE_PIN C19 IOSTANDARD LVCMOS33} [get_ports MOSI]
set_property -dict {PACKAGE_PIN A20 IOSTANDARD LVCMOS33} [get_ports MISO]
set_property -dict {PACKAGE_PIN B20 IOSTANDARD LVCMOS33} [get_ports DRDY]


#set_property  -dict {PACKAGE_PIN  A21  IOSTANDARD LVCMOS33} [get_ports IO_BANK0[5]];
#set_property  -dict {PACKAGE_PIN  D19  IOSTANDARD LVCMOS33} [get_ports IO_BANK0[6]];
#set_property  -dict {PACKAGE_PIN  B21  IOSTANDARD LVCMOS33} [get_ports IO_BANK0[7]];
#set_property  -dict {PACKAGE_PIN  B22  IOSTANDARD LVCMOS33} [get_ports IO_BANK0[8]];
#set_property  -dict {PACKAGE_PIN  C20  IOSTANDARD LVCMOS33} [get_ports IO_BANK0[9]];
#set_property  -dict {PACKAGE_PIN  C22  IOSTANDARD LVCMOS33} [get_ports IO_BANK0[10]];
#set_property  -dict {PACKAGE_PIN  D22  IOSTANDARD LVCMOS33} [get_ports IO_BANK0[11]];
#set_property  -dict {PACKAGE_PIN  D21  IOSTANDARD LVCMOS33} [get_ports IO_BANK0[12]];
#set_property  -dict {PACKAGE_PIN  D20  IOSTANDARD LVCMOS33} [get_ports IO_BANK0[13]];


create_debug_core u_ila_0 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 4 [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER true [get_debug_cores u_ila_0]
set_property C_DATA_DEPTH 16384 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL true [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 3 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
set_property port_width 1 [get_debug_ports u_ila_0/clk]
connect_debug_port u_ila_0/clk [get_nets [list ADS4226/AD_CLK/AD_CLKOUT]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
set_property port_width 12 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list {AD_Data_A[0]} {AD_Data_A[1]} {AD_Data_A[2]} {AD_Data_A[3]} {AD_Data_A[4]} {AD_Data_A[5]} {AD_Data_A[6]} {AD_Data_A[7]} {AD_Data_A[8]} {AD_Data_A[9]} {AD_Data_A[10]} {AD_Data_A[11]}]]
create_debug_core u_ila_1 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_1]
set_property ALL_PROBE_SAME_MU_CNT 4 [get_debug_cores u_ila_1]
set_property C_ADV_TRIGGER true [get_debug_cores u_ila_1]
set_property C_DATA_DEPTH 16384 [get_debug_cores u_ila_1]
set_property C_EN_STRG_QUAL true [get_debug_cores u_ila_1]
set_property C_INPUT_PIPE_STAGES 3 [get_debug_cores u_ila_1]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_1]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_1]
set_property port_width 1 [get_debug_ports u_ila_1/clk]
connect_debug_port u_ila_1/clk [get_nets [list Local_CLK_DCM/inst/clk_out1]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe0]
set_property port_width 8 [get_debug_ports u_ila_1/probe0]
connect_debug_port u_ila_1/probe0 [get_nets [list {DA_Data_A[0]} {DA_Data_A[1]} {DA_Data_A[2]} {DA_Data_A[3]} {DA_Data_A[4]} {DA_Data_A[5]} {DA_Data_A[6]} {DA_Data_A[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
set_property port_width 12 [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list {dsoutdata1[0]} {dsoutdata1[1]} {dsoutdata1[2]} {dsoutdata1[3]} {dsoutdata1[4]} {dsoutdata1[5]} {dsoutdata1[6]} {dsoutdata1[7]} {dsoutdata1[8]} {dsoutdata1[9]} {dsoutdata1[10]} {dsoutdata1[11]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
set_property port_width 12 [get_debug_ports u_ila_0/probe2]
connect_debug_port u_ila_0/probe2 [get_nets [list {dsoutdata0[0]} {dsoutdata0[1]} {dsoutdata0[2]} {dsoutdata0[3]} {dsoutdata0[4]} {dsoutdata0[5]} {dsoutdata0[6]} {dsoutdata0[7]} {dsoutdata0[8]} {dsoutdata0[9]} {dsoutdata0[10]} {dsoutdata0[11]}]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe1]
set_property port_width 25 [get_debug_ports u_ila_1/probe1]
connect_debug_port u_ila_1/probe1 [get_nets [list {fdm_modout[0]} {fdm_modout[1]} {fdm_modout[2]} {fdm_modout[3]} {fdm_modout[4]} {fdm_modout[5]} {fdm_modout[6]} {fdm_modout[7]} {fdm_modout[8]} {fdm_modout[9]} {fdm_modout[10]} {fdm_modout[11]} {fdm_modout[12]} {fdm_modout[13]} {fdm_modout[14]} {fdm_modout[15]} {fdm_modout[16]} {fdm_modout[17]} {fdm_modout[18]} {fdm_modout[19]} {fdm_modout[20]} {fdm_modout[21]} {fdm_modout[22]} {fdm_modout[23]} {fdm_modout[24]}]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe2]
set_property port_width 1 [get_debug_ports u_ila_1/probe2]
connect_debug_port u_ila_1/probe2 [get_nets [list CS_IBUF]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe3]
set_property port_width 1 [get_debug_ports u_ila_1/probe3]
connect_debug_port u_ila_1/probe3 [get_nets [list MISO_OBUF]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe4]
set_property port_width 1 [get_debug_ports u_ila_1/probe4]
connect_debug_port u_ila_1/probe4 [get_nets [list MOSI_IBUF]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe5]
set_property port_width 1 [get_debug_ports u_ila_1/probe5]
connect_debug_port u_ila_1/probe5 [get_nets [list SCK_IBUF]]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets AD_Local_CLK]
