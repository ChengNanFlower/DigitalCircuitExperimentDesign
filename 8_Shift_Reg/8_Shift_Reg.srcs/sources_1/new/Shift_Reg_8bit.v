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
    // 控制逻辑：
    // 1. CR=0: 异步清零（优先级最高）
    // 2. SI=0: 保持当前值
    // 3. SI=1且DI!=0: 左移（加载并行数据）
    // 4. SI=1且DI=0: 右移1位
    always @(posedge CP or negedge CR) begin
        if (!CR) begin
            Q <= 8'b00000000;  // 异步清零
        end
        else if (!SI) begin
            // SI=0: 保持当前值
            Q <= Q;
        end
        else if (DI != 8'b00000000) begin
            // SI=1且DI非全0: 左移（加载并行数据）
            Q <= DI;
        end
        else begin
            // SI=1且DI全0: 右移1位
            // 右移操作：高位补0，低位移出到SQ
            Q <= {1'b0, Q[7:1]};
        end
    end
    
    // 串行输出（取自最低位）
    assign SQ = Q[0];
    
endmodule