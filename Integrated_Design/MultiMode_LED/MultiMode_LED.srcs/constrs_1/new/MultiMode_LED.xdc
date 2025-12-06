# 时钟信号 E3
set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN E3} [get_ports clk_100M]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk_100M]

# 复位信号 (使用 BT[0] 即 D15)
set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN D15} [get_ports BT_RST]

# 开关 SW[1:0]
set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN T18} [get_ports {SW[1]}]
set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN P17} [get_ports {SW[0]}]

# 16位 LED 输出
set_property IOSTANDARD LVCMOS33 [get_ports {LED[*]}]
set_property PACKAGE_PIN T14 [get_ports {LED[0]}]
set_property PACKAGE_PIN T15 [get_ports {LED[1]}]
set_property PACKAGE_PIN R15 [get_ports {LED[2]}]
set_property PACKAGE_PIN T16 [get_ports {LED[3]}]
set_property PACKAGE_PIN R16 [get_ports {LED[4]}]
set_property PACKAGE_PIN M16 [get_ports {LED[5]}]
set_property PACKAGE_PIN N16 [get_ports {LED[6]}]
set_property PACKAGE_PIN N15 [get_ports {LED[7]}]
set_property PACKAGE_PIN P15 [get_ports {LED[8]}]
set_property PACKAGE_PIN K16 [get_ports {LED[9]}]
set_property PACKAGE_PIN L18 [get_ports {LED[10]}]
set_property PACKAGE_PIN N17 [get_ports {LED[11]}]
set_property PACKAGE_PIN M17 [get_ports {LED[12]}]
set_property PACKAGE_PIN M18 [get_ports {LED[13]}]
set_property PACKAGE_PIN R17 [get_ports {LED[14]}]
set_property PACKAGE_PIN U18 [get_ports {LED[15]}]
