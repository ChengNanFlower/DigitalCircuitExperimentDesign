# 实验7 基本寄存器设计测试脚本

# 创建工程
create_project -force 7_Basic_Reg ./7_Basic_Reg -part xc7a100tcsg324-2L

# 添加源文件
add_files ./7_Basic_Reg/7_Basic_Reg.srcs/sources_1/new/Register_8bit.v
add_files ./7_Basic_Reg/7_Basic_Reg.srcs/sources_1/new/Top_Register.v

# 添加约束文件
add_files -fileset constrs_1 ./7_Basic_Reg/7_Basic_Reg.srcs/constrs_1/new/Register_Constraint.xdc

# 设置顶层模块
set_property top Top_Register [current_fileset]

# 更新编译顺序
update_compile_order -fileset sources_1
update_compile_order -fileset sim_1

# 综合设计
synth_design -top Top_Register -part xc7a100tcsg324-2L

# 实现设计
opt_design
place_design
route_design

# 生成比特流
write_bitstream -force ./7_Basic_Reg/Top_Register.bit

# 报告利用率和时序
report_utilization -file ./7_Basic_Reg/utilization_report.txt
report_timing -file ./7_Basic_Reg/timing_report.txt

puts "实验7 基本寄存器设计完成!"