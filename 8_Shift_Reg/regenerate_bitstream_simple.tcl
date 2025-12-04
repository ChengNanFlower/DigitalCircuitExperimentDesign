# 实验8 移位寄存器设计重新生成比特流脚本 (简化版)

# 打开现有工程
open_project ./8_Shift_Reg/8_Shift_Reg.xpr

# 重新设置顶层模块
set_property top Top_Shift_Reg [current_fileset]

# 重新添加源文件
add_files -norecurse ./8_Shift_Reg/8_Shift_Reg.srcs/sources_1/new/Shift_Reg_8bit.v
add_files -norecurse ./8_Shift_Reg/8_Shift_Reg.srcs/sources_1/new/Top_Shift_Reg.v

# 重新添加约束文件
add_files -fileset constrs_1 -norecurse ./8_Shift_Reg/8_Shift_Reg.srcs/constrs_1/new/Shift_Reg_Constraint_simple.xdc

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
set_property PROGRAM.FILE ./8_Shift_Reg/8_Shift_Reg.runs/impl_1/Top_Shift_Reg.bit [get_hw_devices xc7a100t_0]
program_hw_devices [get_hw_devices xc7a100t_0]
refresh_hw_device [lindex [get_hw_devices xc7a100t_0] 0]

puts "实验8 移位寄存器设计比特流重新生成完成!"