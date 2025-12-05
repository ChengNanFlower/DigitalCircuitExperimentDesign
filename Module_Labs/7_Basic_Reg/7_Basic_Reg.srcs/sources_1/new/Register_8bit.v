`timescale 1ns / 1ps

module Register_8bit(
    input wire CLK,         // 时钟输入
    input wire CLR,         // 异步清零端 (高电平有效)
    input wire OE_N,        // 输出使能端 (低电平有效)
    input wire [7:0] D,     // 8位数据输入
    output wire [7:0] Q     // 8位数据输出 (三态)
    );
    
    // 内部寄存器存储
    reg [7:0] reg_data;
    
    // 异步清零和时钟控制的寄存器
    always @(posedge CLK or posedge CLR) begin
        if (CLR) begin
            reg_data <= 8'b00000000;  // 异步清零
        end
        else begin
            reg_data <= D;            // 在时钟上升沿锁存数据
        end
    end
    
    // 三态输出缓冲器 (输出使能控制)
    assign Q = OE_N ? 8'bzzzzzzzz : reg_data;
    
endmodule