# 实验7 基本寄存器设计

## 文件说明

### 源文件 (sources_1/new/)

- `Register_8bit.v` - 8位寄存器模块，包含异步清零和三态输出功能
- `Top_Register.v` - 顶层设计文件，连接所有输入输出

### 仿真文件 (sim_1/new/)

- `tb_Register_8bit.v` - 测试平台文件，用于验证寄存器功能

### 约束文件 (constrs_1/new/)

- `Register_Constraint.xdc` - 完整版约束文件（可能存在兼容性问题）
- `Register_Constraint_simple.xdc` - 简化版约束文件（推荐使用）

### 脚本文件

- `test_script.tcl` - 自动化测试脚本
- `regenerate_bitstream.tcl` - 重新生成比特流脚本（使用完整约束文件）
- `regenerate_bitstream_simple.tcl` - 重新生成比特流脚本（使用简化约束文件，推荐使用）
- `USAGE_INSTRUCTIONS.md` - TCL脚本详细使用说明

## 功能说明

### Register_8bit 模块

实现一个8位带异步清零和输出使能的寄存器：

- CLK: 时钟输入（上升沿触发）
- CLR: 异步清零输入（高电平有效）
- OE_N: 输出使能输入（低电平有效）
- D[7:0]: 8位数据输入
- Q[7:0]: 8位数据输出（三态）

### 功能表

| OE_N | CLR | CLK        | D    | Q^(n+1)   | 功能         |
|------|-----|------------|------|-----------|--------------|
| 1    | x   | x          | x    | 高阻      | 禁止输出     |
| 0    | 1   | x          | x    | 0000 0000 | 清零并输出   |
| 0    | 0   | 0          | x    | Q^n       | 保持并输出   |
| 0    | 0   | ↑(上升沿)  | D    | D         | 置入数据并输出 |

## 管脚分配

### 输入

- BT (D15): 时钟CLK
- SW[0] (P17): 清零CLR
- SW[1] (T18): 输出使能OE_N
- SW[9:2]: 数据输入D[7:0]

### 输出

- LED[7:0]: 数据输出Q[7:0]

## 使用说明

### 方法1: 手动在Vivado中操作

1. 在Vivado中创建新工程
2. 添加源文件和约束文件
3. 设置顶层模块为Top_Register
4. 运行综合和实现
5. 生成比特流文件并下载到FPGA
6. 通过拨动开关和按键验证寄存器功能

### 方法2: 使用自动化脚本

1. 打开Vivado Tcl控制台
2. 执行命令: `source ./regenerate_bitstream_simple.tcl`
3. 等待脚本执行完成
4. 下载生成的比特流文件到FPGA

详细使用说明请参阅 [USAGE_INSTRUCTIONS.md](USAGE_INSTRUCTIONS.md)

## 实验验证步骤

1. 设置数据输入: 通过SW[9:2]设置想要存储的数据
2. 触发时钟: 按下BT按钮产生时钟上升沿
3. 观察输出: LED应显示锁存的数据
4. 测试清零功能: 拨动SW[0]到高电平，观察LED是否全灭
5. 测试输出使能: 拨动SW[1]到高电平，观察LED是否进入高阻态

## 故障排除

如果遇到约束文件相关的错误，请尝试使用简化版约束文件(Register_Constraint_simple.xdc)。
