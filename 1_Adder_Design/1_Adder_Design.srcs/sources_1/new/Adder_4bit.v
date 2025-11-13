`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/11/07 11:45:00
// Design Name: 4-bit Ripple Carry Adder
// Module Name: Adder_4bit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: This module creates a 4-bit adder by instantiating four 1-bit 
//              Full Adders (FA_gate).
// 
// Dependencies: FA_gate.v
// 
//////////////////////////////////////////////////////////////////////////////////


module Adder_4bit(
    // 输出端口
    output [3:0] F,       // 4位加法和的输出
    output       C_out,   // 最终的进位输出
    // 输入端口
    input  [3:0] A,       // 4位加数A
    input  [3:0] B,       // 4位加数B
    input        C_in     // 初始的进位输入
    );
    
    // 中间信号：用于连接各个FA模块之间的进位链 (Carry Chain)
    // C1 是 FA0 的进位输出, C2 是 FA1 的进位输出, ...
    wire C1, C2, C3;
    
    // 例化四个 FA_gate 模块
    // -----------------------------------------------------
    // 例化第0位全加器 (最低位, LSB)
    // 输入是 A[0], B[0] 和 C_in
    // 输出是 F[0] 和到下一位的进位 C1
    FA_gate FA0 (
        .Fi(F[0]), 
        .Ci_plus_1(C1), 
        .Ai(A[0]), 
        .Bi(B[0]), 
        .Ci(C_in)
    );
    
    // -----------------------------------------------------
    // 例化第1位全加器
    // 输入是 A[1], B[1] 和来自上一位的进位 C1
    // 输出是 F[1] 和到下一位的进位 C2
    FA_gate FA1 (
        .Fi(F[1]), 
        .Ci_plus_1(C2), 
        .Ai(A[1]), 
        .Bi(B[1]), 
        .Ci(C1)
    );
    
    // -----------------------------------------------------
    // 例化第2位全加器
    // 输入是 A[2], B[2] 和来自上一位的进位 C2
    // 输出是 F[2] 和到下一位的进位 C3
    FA_gate FA2 (
        .Fi(F[2]), 
        .Ci_plus_1(C3), 
        .Ai(A[2]), 
        .Bi(B[2]), 
        .Ci(C2)
    );
    
    // -----------------------------------------------------
    // 例化第3位全加器 (最高位, MSB)
    // 输入是 A[3], B[3] 和来自上一位的进位 C3
    // 输出是 F[3] 和最终的进位 C_out
    FA_gate FA3 (
        .Fi(F[3]), 
        .Ci_plus_1(C_out), 
        .Ai(A[3]), 
        .Bi(B[3]), 
        .Ci(C3)
    );

endmodule
