//-----------------------------------------------------------------
// Module:      mux8_to_1_4bit
// Description: 8输入、4位宽的数据选择器 (8-to-1 Multiplexer, 4-bit wide)
// Author:      AI Assistant
//-----------------------------------------------------------------

module mux8_to_1_4bit (
    // 输入端口
    input  wire [3:0]   d0,     // 数据输入 0
    input  wire [3:0]   d1,     // 数据输入 1
    input  wire [3:0]   d2,     // 数据输入 2
    input  wire [3:0]   d3,     // 数据输入 3
    input  wire [3:0]   d4,     // 数据输入 4
    input  wire [3:0]   d5,     // 数据输入 5
    input  wire [3:0]   d6,     // 数据输入 6
    input  wire [3:0]   d7,     // 数据输入 7
    input  wire [2:0]   sel,    // 3位选择信号
    
    // 输出端口
    output reg  [3:0]   y       // 4位数据输出
);

    // 使用 always 块和 case 语句实现组合逻辑
    // 当任何输入信号（d0-d7, sel）发生变化时，重新计算输出 y
    always @(*) begin
        case (sel)
            3'b000: y = d0;
            3'b001: y = d1;
            3'b010: y = d2;
            3'b011: y = d3;
            3'b100: y = d4;
            3'b101: y = d5;
            3'b110: y = d6;
            3'b111: y = d7;
            default: y = 4'b0000; // 默认输出，防止产生锁存器
        endcase
    end

endmodule
