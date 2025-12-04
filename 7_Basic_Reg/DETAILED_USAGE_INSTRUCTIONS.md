# 详细TCL脚本使用说明

## 问题分析

从用户的反馈来看，出现了以下问题：

1. `source 7_Basic_Reg\regenerate_bitstream_simple.tcl` - "no such file or directory"
2. 路径分隔符使用不一致（混合使用了正斜杠和反斜杠）

## 解决方案

### 方案一：使用完整绝对路径（推荐）

在Vivado TCL控制台中执行以下命令：

```tcl
# 首先确认当前工作目录
pwd

# 使用完整绝对路径执行脚本
source E:/codes/DigitalCircuitExperimentDesign/7_Basic_Reg/regenerate_bitstream_simple.tcl
```

### 方案二：先切换到正确目录

```tcl
# 切换到项目根目录
cd E:/codes/DigitalCircuitExperimentDesign

# 然后执行脚本
source 7_Basic_Reg/regenerate_bitstream_simple.tcl
```

### 方案三：使用统一的路径分隔符

```tcl
# 使用正斜杠（Unix风格）而不是反斜杠
source 7_Basic_Reg/regenerate_bitstream_simple.tcl

# 或者使用双反斜杠（Windows风格）
source 7_Basic_Reg\\regenerate_bitstream_simple.tcl
```

## 脚本路径问题修复

让我检查并修复 `regenerate_bitstream_simple.tcl` 脚本中的路径问题：

<read_file>
<args>
  <file>
    <path>7_Basic_Reg/regenerate_bitstream_simple.tcl</path>
  </file>
</args>
</read_file>
