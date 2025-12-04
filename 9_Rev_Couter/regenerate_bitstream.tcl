# 实验9 可逆计数器设计重新生成比特流脚本

# 打开现有工程
open_project ./9_Rev_Couter/9_Rev_Couter.xpr

# 重新设置顶层模块
set_property top Top_Rev_Counter [current_fileset]

# 重新添加源文件
add_files -norecurse ./9_Rev_Couter/9_Rev_Couter.srcs/sources_1/new/Rev_Counter_4bit.v
add_files -norecurse ./9_Rev_Couter/9_Rev_Couter.srcs/sources_1/new/Top_Rev_Counter.v

# 重新添加约束文件
add_files -fileset constrs_1 -norecurse ./9_Rev_Couter/9_Rev_Couter.srcs/constrs_1/new/Rev_Counter_Constraint.xdc

# 更新编译顺序
update_compile_order -fileset sources_1
update_compile_order -fileset sim_1

# 重新综合设计
reset_run synth_1
launch_runs synth_1 -jobs 2
wait_on_run synth_1

# 重新实现设计
reset_run impl_1
launch_runs impl_1 -to_step write_bitstream -jobs 2
wait_on_run impl_1

# 打开硬件管理器并连接设备
open_hw_manager
connect_hw_server
open_hw_target

# 下载比特流到设备
current_hw_device [get_hw_devices xc7a100t_0]
refresh_hw_device -update_hw_probes false [lindex [get_hw_devices xc7a100t_0] 0]
set_property PROGRAM.FILE ./9_Rev_Couter/9_Rev_Couter.runs/impl_1/Top_Rev_Counter.bit [get_hw_devices xc7a100t_0]
program_hw_devices [get_hw_devices xc7a100t_0]
refresh_hw_device [lindex [get_hw_devices xc7a100t_0] 0]

puts "实验9 可逆计数器设计比特流重新生成完成!"