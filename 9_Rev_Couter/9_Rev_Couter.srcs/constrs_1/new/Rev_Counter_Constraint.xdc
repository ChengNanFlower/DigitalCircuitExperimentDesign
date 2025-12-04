# 实验9 可逆计数器设计 管脚约束文件

# 时钟输入CLK：配置到BT按钮上 (D15)
set_property PACKAGE_PIN D15 [get_ports BT]

# 控制信号CLR：配置到SW[0]开关上 (P17)
set_property PACKAGE_PIN P17 [get_ports {SW[0]}]

# 控制信号LD：配置到SW[1]开关上 (T18)
set_property PACKAGE_PIN T18 [get_ports {SW[1]}]

# 控制信号U_D：配置到SW[2]开关上 (U17)
set_property PACKAGE_PIN U17 [get_ports {SW[2]}]

# 数据输入D[3:0]：配置到SW[6:3]开关上
set_property PACKAGE_PIN U13 [get_ports {SW[6]}]
set_property PACKAGE_PIN V14 [get_ports {SW[5]}]
set_property PACKAGE_PIN U16 [get_ports {SW[4]}]
set_property PACKAGE_PIN U12 [get_ports {SW[3]}]

# 为未使用的SW引脚分配默认位置（防止DRC错误）
set_property PACKAGE_PIN R10 [get_ports {SW[7]}]
set_property PACKAGE_PIN T11 [get_ports {SW[8]}]
set_property PACKAGE_PIN R11 [get_ports {SW[9]}]
set_property PACKAGE_PIN T8 [get_ports {SW[10]}]
set_property PACKAGE_PIN R8 [get_ports {SW[11]}]
set_property PACKAGE_PIN T9 [get_ports {SW[12]}]
set_property PACKAGE_PIN V1 [get_ports {SW[13]}]
set_property PACKAGE_PIN V2 [get_ports {SW[14]}]
set_property PACKAGE_PIN V4 [get_ports {SW[15]}]

# 输出Q[3:0]：接到LED[3:0]上
set_property PACKAGE_PIN T16 [get_ports {LED[3]}]
set_property PACKAGE_PIN R15 [get_ports {LED[2]}]
set_property PACKAGE_PIN T15 [get_ports {LED[1]}]
set_property PACKAGE_PIN T14 [get_ports {LED[0]}]

# MAX/MIN指示：接到LED[4]上
set_property PACKAGE_PIN R16 [get_ports {LED[4]}]

# RCO指示：接到LED[5]上
set_property PACKAGE_PIN M16 [get_ports {LED[5]}]

# LED[7:6]未使用但需要定义管脚和IO标准
set_property PACKAGE_PIN N15 [get_ports {LED[7]}]
set_property PACKAGE_PIN N16 [get_ports {LED[6]}]

# 设置IO标准
set_property IOSTANDARD LVCMOS33 [get_ports BT]
set_property IOSTANDARD LVCMOS33 [get_ports {SW[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SW[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SW[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SW[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SW[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SW[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SW[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SW[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SW[8]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SW[9]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SW[10]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SW[11]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SW[12]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SW[13]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SW[14]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SW[15]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[7]}]

# 允许将普通IO直接路由到时钟网络
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets -hierarchical -filter {NAME =~ */BT_IBUF}]