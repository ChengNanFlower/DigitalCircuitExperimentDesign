#=============================================================================
# XDC 约束文件 for: 8输入4位宽数据选择器实验
# Target Board:   (Based on HCS_A02_ALL.xdc)
# Design:         top.v (mux8_to_1_4bit)
#
# 说明:
#   - SW[34:32]: 用作3位选择信号 (sel)
#   - SW[31:0]:  用作8组4位宽数据输入 (d0-d7)
#   - LED[3:0]:  用作4位数据输出 (y)
#=============================================================================

#-----------------------------------------------------------------------------
# 时钟源 (在此设计中未使用，但保留是良好习惯)
#-----------------------------------------------------------------------------
# set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN E3} [get_ports clk_100M] 
# create_clock -period 10.000 -name sys_clk_pin -waveform {0.000 5.000} [get_ports clk_100M]


#-----------------------------------------------------------------------------
# 拨码开关 (SW) 输入
#-----------------------------------------------------------------------------
# 为整个 SW 总线设置电平标准
set_property IOSTANDARD LVCMOS33 [get_ports {SW[*]}]

# --- MUX 选择信号 (sel) ---
set_property PACKAGE_PIN R11 [get_ports {SW[32]}]  ; # sel[0]
set_property PACKAGE_PIN T11 [get_ports {SW[33]}]  ; # sel[1]
set_property PACKAGE_PIN R10 [get_ports {SW[34]}]  ; # sel[2]

# --- MUX 数据输入 (d7 ~ d0) ---
# d7: SW[31:28]
set_property PACKAGE_PIN U3 [get_ports {SW[28]}]
set_property PACKAGE_PIN U2 [get_ports {SW[29]}]
set_property PACKAGE_PIN U1 [get_ports {SW[30]}]
set_property PACKAGE_PIN T8 [get_ports {SW[31]}]
# d6: SW[27:24]
set_property PACKAGE_PIN V9 [get_ports {SW[24]}]
set_property PACKAGE_PIN V7 [get_ports {SW[25]}]
set_property PACKAGE_PIN V6 [get_ports {SW[26]}]
set_property PACKAGE_PIN V5 [get_ports {SW[27]}]
# d5: SW[23:20]
set_property PACKAGE_PIN V15 [get_ports {SW[20]}]
set_property PACKAGE_PIN U14 [get_ports {SW[21]}]
set_property PACKAGE_PIN V12 [get_ports {SW[22]}]
set_property PACKAGE_PIN V11 [get_ports {SW[23]}]
# d4: SW[19:16]
set_property PACKAGE_PIN P18 [get_ports {SW[16]}]
set_property PACKAGE_PIN R18 [get_ports {SW[17]}]
set_property PACKAGE_PIN V17 [get_ports {SW[18]}]
set_property PACKAGE_PIN V16 [get_ports {SW[19]}]
# d3: SW[15:12]
set_property PACKAGE_PIN V2 [get_ports {SW[12]}]
set_property PACKAGE_PIN V1 [get_ports {SW[13]}]
set_property PACKAGE_PIN T9 [get_ports {SW[14]}]
set_property PACKAGE_PIN R8 [get_ports {SW[15]}]
# d2: SW[11:8]
set_property PACKAGE_PIN U9 [get_ports {SW[8]}]
set_property PACKAGE_PIN U7 [get_ports {SW[9]}]
set_property PACKAGE_PIN U6 [get_ports {SW[10]}]
set_property PACKAGE_PIN V4 [get_ports {SW[11]}]
# d1: SW[7:4]
set_property PACKAGE_PIN V14 [get_ports {SW[4]}]
set_property PACKAGE_PIN U13 [get_ports {SW[5]}]
set_property PACKAGE_PIN U12 [get_ports {SW[6]}]
set_property PACKAGE_PIN U11 [get_ports {SW[7]}]
# d0: SW[3:0]
set_property PACKAGE_PIN P17 [get_ports {SW[0]}]
set_property PACKAGE_PIN T18 [get_ports {SW[1]}]
set_property PACKAGE_PIN U17 [get_ports {SW[2]}]
set_property PACKAGE_PIN U16 [get_ports {SW[3]}]

# 未使用的 SW[35] 引脚，由于顶层端口定义为 SW[35:0]，也需要约束
set_property PACKAGE_PIN T10 [get_ports {SW[35]}]


#-----------------------------------------------------------------------------
# LED 输出
#-----------------------------------------------------------------------------
# 为用到的 LED 总线设置电平标准
set_property IOSTANDARD LVCMOS33 [get_ports {LED[*]}]

# --- MUX 输出 (y) ---
set_property PACKAGE_PIN T14 [get_ports {LED[0]}]  ; # y[0]
set_property PACKAGE_PIN T15 [get_ports {LED[1]}]  ; # y[1]
set_property PACKAGE_PIN R15 [get_ports {LED[2]}]  ; # y[2]
set_property PACKAGE_PIN T16 [get_ports {LED[3]}]  ; # y[3]
