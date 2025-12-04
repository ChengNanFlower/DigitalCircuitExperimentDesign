# TCL脚本使用说明

## 脚本文件介绍

### 1. test_script.tcl

- **功能**：完整的自动化测试脚本，从创建工程到生成比特流
- **适用场景**：首次运行或需要完全重新构建项目时使用
- **注意**：会覆盖现有工程设置

### 2. regenerate_bitstream.tcl

- **功能**：重新生成比特流脚本（使用完整约束文件）
- **适用场景**：已有工程但需要重新综合和实现设计时使用
- **注意**：使用完整版约束文件，可能存在兼容性问题

### 3. regenerate_bitstream_simple.tcl（推荐使用）

- **功能**：重新生成比特流脚本（使用简化约束文件）
- **适用场景**：已有工程且希望避免约束文件语法错误时使用
- **优势**：使用简化版约束文件，兼容性更好

## 使用方法

### 方法一：在Vivado GUI中使用

1. 打开Vivado软件
2. 在Tcl控制台中输入以下命令：

   ```
   cd E:/codes/DigitalCircuitExperimentDesign/7_Basic_Reg
   source regenerate_bitstream_simple.tcl
   ```

   或者使用完整路径：

   ```
   source E:/codes/DigitalCircuitExperimentDesign/7_Basic_Reg/regenerate_bitstream_simple.tcl
   ```

### 方法二：在命令行中使用

1. 打开命令提示符(cmd)或PowerShell
2. 导航到Vivado安装目录的bin文件夹，例如：

   ```
   cd C:\Xilinx\Vivado\2025.2\bin
   ```

3. 运行以下命令：

   ```
   vivado -mode batch -source E:/codes/DigitalCircuitExperimentDesign/7_Basic_Reg/regenerate_bitstream_simple.tcl
   ```

## 脚本执行过程说明

### regenerate_bitstream_simple.tcl 脚本会依次执行以下操作

1. **打开现有工程**
   - 打开位于 ./7_Basic_Reg/7_Basic_Reg.xpr 的工程

2. **设置顶层模块**
   - 将顶层模块设置为 Top_Register

3. **更新源文件**
   - 添加寄存器模块文件 Register_8bit.v
   - 添加顶层设计文件 Top_Register.v

4. **更新约束文件**
   - 移除旧的约束文件
   - 添加简化版约束文件 Register_Constraint_simple.xdc

5. **重新综合设计**
   - 重置综合运行
   - 启动综合过程并等待完成

6. **重新实现设计**
   - 重置实现运行
   - 启动实现过程直至生成比特流并等待完成

7. **下载到硬件**
   - 打开硬件管理器
   - 连接硬件服务器
   - 打开硬件目标
   - 将生成的比特流下载到FPGA设备

## 常见问题及解决方案

### 问题1：找不到工程文件

**错误信息**：can't read file "./7_Basic_Reg/7_Basic_Reg.xpr"
**解决方案**：

1. 确保在正确的目录下运行脚本
2. 确保工程文件确实存在
3. 使用绝对路径而不是相对路径

### 问题2：约束文件语法错误

**错误信息**：Invalid option value '#' specified for 'objects'
**解决方案**：

1. 使用 regenerate_bitstream_simple.tcl 脚本（推荐）
2. 该脚本使用简化版约束文件，避免了语法问题

### 问题3：硬件连接问题

**错误信息**：Hardware target not found
**解决方案**：

1. 确保FPGA开发板已正确连接到电脑
2. 确保USB驱动已正确安装
3. 重启Vivado和硬件设备

## 手动操作替代方案

如果不使用脚本，也可以手动执行以下步骤：

1. 打开Vivado并加载工程
2. 在Sources窗口中添加源文件：
   - 7_Basic_Reg/7_Basic_Reg.srcs/sources_1/new/Register_8bit.v
   - 7_Basic_Reg/7_Basic_Reg.srcs/sources_1/new/Top_Register.v
3. 在Constraints窗口中添加约束文件：
   - 7_Basic_Reg/7_Basic_Reg.srcs/constrs_1/new/Register_Constraint_simple.xdc
4. 点击"Run Synthesis"按钮
5. 综合完成后点击"Run Implementation"按钮
6. 实现完成后点击"Generate Bitstream"按钮
7. 生成比特流后点击"Open Hardware Manager"
8. 连接设备并编程FPGA

## 验证结果

脚本执行成功后：

1. 检查控制台输出应显示"实验7 基本寄存器设计比特流重新生成完成!"
2. 在 7_Basic_Reg/7_Basic_Reg.runs/impl_1/ 目录下应生成 Top_Register.bit 文件
3. FPGA设备上的LED应响应开关输入的变化
