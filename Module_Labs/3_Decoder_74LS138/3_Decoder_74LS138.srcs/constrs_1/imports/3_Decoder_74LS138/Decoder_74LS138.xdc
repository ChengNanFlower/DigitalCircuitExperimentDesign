set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN U13} [get_ports G1]
set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN V14} [get_ports G2A_bar]
set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN U16} [get_ports G2B_bar]
set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN U17} [get_ports {A_in[2]}]
set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN T18} [get_ports {A_in[1]}]
set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN P17} [get_ports {A_in[0]}]
set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN N15} [get_ports {Y_out_bar[7]}]
set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN N16} [get_ports {Y_out_bar[6]}]
set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN M16} [get_ports {Y_out_bar[5]}]
set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN R16} [get_ports {Y_out_bar[4]}]
set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN T16} [get_ports {Y_out_bar[3]}]
set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN R15} [get_ports {Y_out_bar[2]}]
set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN T15} [get_ports {Y_out_bar[1]}]
set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN T14} [get_ports {Y_out_bar[0]}]
# === 3-8译码器 输入管脚约束 (连接到开关 SW) ===
# 使能信号 G1 连接到 SW5
# 使能信号 G2A_bar 连接到 SW4
# 使能信号 G2B_bar 连接到 SW3

# 地址信号 A_in[2] (C) 连接到 SW2
# 地址信号 A_in[1] (B) 连接到 SW1
# 地址信号 A_in[0] (A) 连接到 SW0


# === 3-8译码器 输出管脚约束 (连接到LED灯) ===
# 输出信号 Y_out_bar[7] (Y7) 连接到 LED7
# 输出信号 Y_out_bar[6] (Y6) 连接到 LED6
# 输出信号 Y_out_bar[5] (Y5) 连接到 LED5
# 输出信号 Y_out_bar[4] (Y4) 连接到 LED4
# 输出信号 Y_out_bar[3] (Y3) 连接到 LED3
# 输出信号 Y_out_bar[2] (Y2) 连接到 LED2
# 输出信号 Y_out_bar[1] (Y1) 连接到 LED1
# 输出信号 Y_out_bar[0] (Y0) 连接到 LED0

set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
