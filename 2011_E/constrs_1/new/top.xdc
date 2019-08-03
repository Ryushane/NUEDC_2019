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
set_property -dict {PACKAGE_PIN B18 IOSTANDARD LVCMOS33} [get_ports DATAOUT]
set_property -dict {PACKAGE_PIN C19 IOSTANDARD LVCMOS33} [get_ports PLLCLKOUT]

#set_property  -dict {PACKAGE_PIN  A20  IOSTANDARD LVCMOS33} [get_ports MISO];

#set_property  -dict {PACKAGE_PIN  B20  IOSTANDARD LVCMOS33} [get_ports DRDY];

set_property -dict {PACKAGE_PIN D20 IOSTANDARD LVCMOS33} [get_ports LED]





connect_debug_port u_ila_1/probe1 [get_nets [list outrd_data]]

connect_debug_port u_ila_1/probe0 [get_nets [list {pd_out[0]} {pd_out[1]} {pd_out[2]} {pd_out[3]} {pd_out[4]} {pd_out[5]} {pd_out[6]} {pd_out[7]}]]

create_debug_core u_ila_0 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 4 [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER true [get_debug_cores u_ila_0]
set_property C_DATA_DEPTH 8192 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL true [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 3 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
set_property port_width 1 [get_debug_ports u_ila_0/clk]
connect_debug_port u_ila_0/clk [get_nets [list ADS4226/AD_CLK/AD_CLKOUT]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
set_property port_width 12 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list {AD_Data_A[0]} {AD_Data_A[1]} {AD_Data_A[2]} {AD_Data_A[3]} {AD_Data_A[4]} {AD_Data_A[5]} {AD_Data_A[6]} {AD_Data_A[7]} {AD_Data_A[8]} {AD_Data_A[9]} {AD_Data_A[10]} {AD_Data_A[11]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
set_property port_width 12 [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list {dsoutdata[0]} {dsoutdata[1]} {dsoutdata[2]} {dsoutdata[3]} {dsoutdata[4]} {dsoutdata[5]} {dsoutdata[6]} {dsoutdata[7]} {dsoutdata[8]} {dsoutdata[9]} {dsoutdata[10]} {dsoutdata[11]}]]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets AD_CLKOUT]
