`timescale 1ns / 1ps

module Top_Shift_Reg(
    input wire [15:0] SW,   // 开关输入 (使用SW[10:0])
    input wire BT,          // 按键输入 (使用BT作为时钟)
    output wire [7:0] LED,  // LED输出
    output wire SQ_OUT      // 串行输出
    );
    
    // 信号连接说明:
    // SW[0]  -> CR (异步清零信号，低电平有效)
    // SW[1]  -> SI (串行输入/移位控制信号)
    // SW[2]  -> 未使用
    // SW[10:3] -> DI[7:0] (并行数据输入)
    // BT     -> CP (时钟脉冲输入)
    // LED[7:0] -> Q[7:0] (并行数据输出)
    // SQ_OUT -> 串行输出
    
    // 实例化8位移位寄存器模块
    Shift_Reg_8bit shift_reg_inst (
        .CLK(),              // 未使用
        .CR(SW[0]),          // 异步清零信号 (SW是高电平有效，CR也是高电平有效)
        .SI(SW[1]),          // 串行输入/移位控制信号
        .SO(),               // 未使用
        .CP(BT),             // 时钟脉冲输入
        .DI({SW[10], SW[9], SW[8], SW[7], SW[6], SW[5], SW[4], SW[3]}),  // 并行数据输入
        .Q(LED[7:0]),        // 并行数据输出
        .SQ(SQ_OUT)          // 串行输出
    );
    
endmodule