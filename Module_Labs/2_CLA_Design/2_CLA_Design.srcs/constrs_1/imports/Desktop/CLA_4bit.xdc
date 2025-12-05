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
# CLA_4bit (4位超前进位加法器) 模块引脚约束文件
#
# ----------------------------------------------------
# 输入端口约束 (Inputs)
# ----------------------------------------------------
# 将4位输入 A[3:0] 映射到拨码开关 SW0 ~ SW3
# Port A[0] -> Switch SW0
# Port A[1] -> Switch SW1
# Port A[2] -> Switch SW2
# Port A[3] -> Switch SW3

# 将4位输入 B[3:0] 映射到拨码开关 SW4 ~ SW7
# Port B[0] -> Switch SW4
# Port B[1] -> Switch SW5
# Port B[2] -> Switch SW6
# Port B[3] -> Switch SW7

# 将1位输入 C_in (初始进位) 映射到拨码开关 SW8
# Port C_in -> Switch SW8


# ----------------------------------------------------
# 输出端口约束 (Outputs)
# ----------------------------------------------------
# 将4位输出 F[3:0] (和) 映射到LED灯 LED0 ~ LED3
# Port F[0] -> LED0
# Port F[1] -> LED1
# Port F[2] -> LED2
# Port F[3] -> LED3

# 将1位输出 C_out (最终进位) 映射到LED灯 LED4
# Port C_out -> LED4


set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
