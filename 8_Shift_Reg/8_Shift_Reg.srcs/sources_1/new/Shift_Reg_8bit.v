`timescale 1ns / 1ps

module Shift_Reg_8bit(
    input wire CLK,         // 时钟输入（未使用）
    input wire CR,          // 异步清零端 (低电平有效)
    input wire SI,          // 串行输入/右移输入
    input wire SO,          // 未使用
    input wire CP,          // 时钟脉冲输入
    input wire [7:0] DI,    // 并行数据输入（左移时使用）
    output reg [7:0] Q,     // 并行数据输出
    output wire SQ          // 串行输出
    );
    
    // 异步清零和时钟控制的移位寄存器
    always @(posedge CP or negedge CR) begin
        if (!CR) begin
            Q <= 8'b00000000;  // 异步清零
        end
        else if (!SI) begin
            // SI=0: 保持当前值
            Q <= Q;
        end
        else begin
            // SI=1: 移位操作
            // 根据实验要求，当SI=1时应该加载并行数据（左移功能）
            // 不管DI的值是什么，都应该加载到Q中
            Q <= DI;
        end
    end
    
    // 串行输出（取自最低位）
    assign SQ = Q[0];
    
endmodule