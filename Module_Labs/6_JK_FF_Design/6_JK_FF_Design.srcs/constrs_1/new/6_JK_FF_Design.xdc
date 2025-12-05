# 开关映射 SW[0]-SW[7] 用于 J, K, SD, RD
set_property PACKAGE_PIN P17 [get_ports {SW[0]}]
set_property PACKAGE_PIN T18 [get_ports {SW[1]}]
set_property PACKAGE_PIN U17 [get_ports {SW[2]}]
set_property PACKAGE_PIN U16 [get_ports {SW[3]}]
set_property PACKAGE_PIN V14 [get_ports {SW[4]}]
set_property PACKAGE_PIN U13 [get_ports {SW[5]}]
set_property PACKAGE_PIN U12 [get_ports {SW[6]}]
set_property PACKAGE_PIN U11 [get_ports {SW[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SW[*]}]

# LED映射 LED[0]-LED[3] 用于观察 Q 和 Q_n
set_property PACKAGE_PIN T14 [get_ports {LED[0]}]
set_property PACKAGE_PIN T15 [get_ports {LED[1]}]
set_property PACKAGE_PIN R15 [get_ports {LED[2]}]
set_property PACKAGE_PIN T16 [get_ports {LED[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[*]}]

# 按键映射 BT[0] 用于 CP 脉冲输入
set_property PACKAGE_PIN D15 [get_ports {BT[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {BT[*]}]

# ！！！关键修正！！！
# 允许将普通IO (BT[0]) 直接路由到时钟网络
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets -hierarchical -filter {NAME =~ *BT*IBUF*}]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets -hierarchical -filter {NAME =~ *SW*IBUF*}]
