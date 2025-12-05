set_property -dict {PACKAGE_PIN P17 IOSTANDARD LVCMOS33} [get_ports {A[0]}]
set_property -dict {PACKAGE_PIN T18 IOSTANDARD LVCMOS33} [get_ports {A[1]}]
set_property -dict {PACKAGE_PIN U17 IOSTANDARD LVCMOS33} [get_ports {A[2]}]
set_property -dict {PACKAGE_PIN U16 IOSTANDARD LVCMOS33} [get_ports {A[3]}]
set_property -dict {PACKAGE_PIN V14 IOSTANDARD LVCMOS33} [get_ports {B[0]}]
set_property -dict {PACKAGE_PIN U13 IOSTANDARD LVCMOS33} [get_ports {B[1]}]
set_property -dict {PACKAGE_PIN U12 IOSTANDARD LVCMOS33} [get_ports {B[2]}]
set_property -dict {PACKAGE_PIN U11 IOSTANDARD LVCMOS33} [get_ports {B[3]}]
set_property -dict {PACKAGE_PIN U9 IOSTANDARD LVCMOS33} [get_ports C_in]
set_property -dict {PACKAGE_PIN T14 IOSTANDARD LVCMOS33} [get_ports {F[0]}]
set_property -dict {PACKAGE_PIN T15 IOSTANDARD LVCMOS33} [get_ports {F[1]}]
set_property -dict {PACKAGE_PIN R15 IOSTANDARD LVCMOS33} [get_ports {F[2]}]
set_property -dict {PACKAGE_PIN T16 IOSTANDARD LVCMOS33} [get_ports {F[3]}]
set_property -dict {PACKAGE_PIN R16 IOSTANDARD LVCMOS33} [get_ports C_out]
# Adder_4bit 模块引脚约束文件
#
# 输入端口约束
#----------------------------------------------------
# 将4位输入 A[3:0] 映射到拨码开关 SW0 ~ SW3

# 将4位输入 B[3:0] 映射到拨码开关 SW4 ~ SW7

# 将1位输入 C_in 映射到拨码开关 SW8


# 输出端口约束
#----------------------------------------------------
# 将4位输出 F[3:0] 映射到LED灯 LED0 ~ LED3

# 将1位输出 C_out 映射到LED灯 LED4


set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
