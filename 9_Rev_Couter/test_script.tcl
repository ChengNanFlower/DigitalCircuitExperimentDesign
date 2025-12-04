# 实验9 可逆计数器设计测试脚本

# 打开现有工程
open_project ./9_Rev_Couter/9_Rev_Couter.xpr

# 设置顶层模块
set_property top Top_Rev_Counter [current_fileset]

# 添加源文件
add_files -norecurse ./9_Rev_Couter/9_Rev_Couter.srcs/sources_1/new/Rev_Counter_4bit.v
add_files -norecurse ./9_Rev_Couter/9_Rev_Couter.srcs/sources_1/new/Top_Rev_Counter.v

# 添加约束文件
add_files -fileset constrs_1 -norecurse ./9_Rev_Couter/9_Rev_Couter.srcs/constrs_1/new/Rev_Counter_Constraint.xdc

# 更新编译顺序
update_compile_order -fileset sources_1
update_compile_order -fileset sim_1

# 综合设计
reset_run synth_1
launch_runs synth_1 -jobs 2
wait_on_run synth_1

# 实现设计
reset_run impl_1
launch_runs impl_1 -to_step write_bitstream -jobs 2
wait_on_run impl_1

puts "实验9 可逆计数器设计综合和实现完成!"