`timescale 1ns / 1ps

module Top_Register(
    input wire [15:0] SW,   // 开关输入 (使用SW[9:0])
    input wire BT,          // 按键输入 (使用BT)
    output wire [7:0] LED   // LED输出
    );
    
    // 信号连接说明:
    // SW[0]  -> CLR (清零信号)
    // SW[1]  -> OE_N (输出使能，低电平有效)
    // SW[9:2] -> D[7:0] (数据输入)
    // BT     -> CLK (时钟输入)
    // LED[7:0] -> Q[7:0] (数据输出)
    
    // 实例化8位寄存器模块
    Register_8bit reg_inst (
        .CLK(BT),                                    // 时钟输入
        .CLR(SW[0]),                                 // 清零信号
        .OE_N(SW[1]),                                // 输出使能信号
        .D({SW[8], SW[7], SW[6], SW[5], SW[4], SW[3], SW[2], SW[9]}),  // 8位数据输入
        .Q(LED[7:0])                                 // 8位数据输出
    );
    
endmodule