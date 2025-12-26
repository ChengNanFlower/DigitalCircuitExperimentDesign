# =============================================================================
# Digital Clock XDC Constraints
# Based on User Image & Added Alarm Features
# =============================================================================

# 1. 系统时钟 (System Clock) - 100MHz
set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN E3} [get_ports clk_100M]
create_clock -period 10.000 -name sys_clk_pin -waveform {0.000 5.000} -add [get_ports clk_100M]

# 2. 复位按键 (Reset) - 对应板上的 BT[0] (D15)
set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN D15} [get_ports rst]

# 3. 功能开关 (Switches)
# sw_set_time  -> 对应 SW[0] (P17)
# sw_set_alarm -> 对应 SW[1] (T18)
set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN P17} [get_ports sw_set_time]
set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN T18} [get_ports sw_set_alarm]

# 4. 时间设置按键 (Buttons)
# btn_s (秒+) -> 对应 BT[1] (C10)
# btn_m (分+) -> 对应 BT[2] (C11)
# btn_h (时+) -> 对应 BT[3] (H16)
set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN C10} [get_ports btn_s]
set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN C11} [get_ports btn_m]
set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN H16} [get_ports btn_h]

# 5. 数码管段选 (Segments) - 对应 SEG[7:0]
# 物理引脚参考图片定义: E2, A3, B1, E1, F1, D2, B3, C1
# 注意: Verilog中已经修正了位序，这里直接对应物理引脚即可
set_property IOSTANDARD LVCMOS33 [get_ports {SEG[*]}]
set_property PACKAGE_PIN E2 [get_ports {SEG[7]}]
set_property PACKAGE_PIN A3 [get_ports {SEG[6]}]
set_property PACKAGE_PIN B1 [get_ports {SEG[5]}]
set_property PACKAGE_PIN E1 [get_ports {SEG[4]}]
set_property PACKAGE_PIN F1 [get_ports {SEG[3]}]
set_property PACKAGE_PIN D2 [get_ports {SEG[2]}]
set_property PACKAGE_PIN B3 [get_ports {SEG[1]}]
set_property PACKAGE_PIN C1 [get_ports {SEG[0]}]

# 6. 数码管位选 (Anodes) - 对应 AN[7:0]
# 物理引脚: G1, B2, A1, B4, A4, A5, B6, A6
set_property IOSTANDARD LVCMOS33 [get_ports {AN[*]}]
set_property PACKAGE_PIN G1 [get_ports {AN[7]}]
set_property PACKAGE_PIN B2 [get_ports {AN[6]}]
set_property PACKAGE_PIN A1 [get_ports {AN[5]}]
set_property PACKAGE_PIN B4 [get_ports {AN[4]}]
set_property PACKAGE_PIN A4 [get_ports {AN[3]}]
set_property PACKAGE_PIN A5 [get_ports {AN[2]}]
set_property PACKAGE_PIN B6 [get_ports {AN[1]}]
set_property PACKAGE_PIN A6 [get_ports {AN[0]}]

# 7. LED指示灯 (LEDs) - 用于闹钟报警
# 物理引脚参考图片中 LED[0]-LED[15] 的顺序
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
