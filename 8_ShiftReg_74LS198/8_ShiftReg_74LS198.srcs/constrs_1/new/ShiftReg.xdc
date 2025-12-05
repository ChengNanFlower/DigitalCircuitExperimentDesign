# 时钟信号 100MHz
set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN E3} [get_ports clk_100M]

# 按键 BT[0] 用作 CP 脉冲
set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN D15} [get_ports {BT[0]}]

# LED[7:0] 作为 Q[7:0] 输出
set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN N15} [get_ports {LED[7]}]
set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN N16} [get_ports {LED[6]}]
set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN M16} [get_ports {LED[5]}]
set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN R16} [get_ports {LED[4]}]
set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN T16} [get_ports {LED[3]}]
set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN R15} [get_ports {LED[2]}]
set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN T15} [get_ports {LED[1]}]
set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN T14} [get_ports {LED[0]}]

# SW[15] -> nCR (Reset)
set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN R8} [get_ports {SW[15]}]

# SW[14:13] -> S1, S0 (Mode Select)
set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN T9} [get_ports {SW[14]}]
set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN V1} [get_ports {SW[13]}]

# SW[12] -> SR (Shift Right In)
set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN V2} [get_ports {SW[12]}]

# SW[11] -> SL (Shift Left In)
set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN V4} [get_ports {SW[11]}]

# SW[7:0] -> D[7:0] (Parallel Data In)
set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN U11} [get_ports {SW[7]}]
set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN U12} [get_ports {SW[6]}]
set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN U13} [get_ports {SW[5]}]
set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN V14} [get_ports {SW[4]}]
set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN U16} [get_ports {SW[3]}]
set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN U17} [get_ports {SW[2]}]
set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN T18} [get_ports {SW[1]}]
set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN P17} [get_ports {SW[0]}]
