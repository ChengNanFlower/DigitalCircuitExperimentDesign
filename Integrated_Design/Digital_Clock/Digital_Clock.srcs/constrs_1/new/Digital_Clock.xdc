# 时钟信号 Pin E3
set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN E3} [get_ports clk_100M]

# 复位按键 (rst) -> 映射到 BT[0] (D15)
set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN D15} [get_ports rst]

# 模式开关 (mode_sw) -> 映射到 SW[0] (P17)
set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN P17} [get_ports mode_sw]

# 时间设置按键
# BT[1] -> 秒 (btn_s)
set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN C10} [get_ports btn_s]
# BT[2] -> 分 (btn_m)
set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN C11} [get_ports btn_m]
# BT[3] -> 时 (btn_h)
set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN H16} [get_ports btn_h]

# 数码管段选 (SEG[0]-SEG[7]) -> 对应 C1, B3, D2, F1, E1, B1, A3, E2
set_property IOSTANDARD LVCMOS33 [get_ports {SEG[*]}]
set_property PACKAGE_PIN C1 [get_ports {SEG[0]}]
set_property PACKAGE_PIN B3 [get_ports {SEG[1]}]
set_property PACKAGE_PIN D2 [get_ports {SEG[2]}]
set_property PACKAGE_PIN F1 [get_ports {SEG[3]}]
set_property PACKAGE_PIN E1 [get_ports {SEG[4]}]
set_property PACKAGE_PIN B1 [get_ports {SEG[5]}]
set_property PACKAGE_PIN A3 [get_ports {SEG[6]}]
set_property PACKAGE_PIN E2 [get_ports {SEG[7]}]

# 数码管位选 (AN[0]-AN[7]) -> 对应 A6, B6, A5, A4, B4, A1, B2, G1
set_property IOSTANDARD LVCMOS33 [get_ports {AN[*]}]
set_property PACKAGE_PIN A6 [get_ports {AN[0]}]
set_property PACKAGE_PIN B6 [get_ports {AN[1]}]
set_property PACKAGE_PIN A5 [get_ports {AN[2]}]
set_property PACKAGE_PIN A4 [get_ports {AN[3]}]
set_property PACKAGE_PIN B4 [get_ports {AN[4]}]
set_property PACKAGE_PIN A1 [get_ports {AN[5]}]
set_property PACKAGE_PIN B2 [get_ports {AN[6]}]
set_property PACKAGE_PIN G1 [get_ports {AN[7]}]
