`timescale 1ns / 1ps

module Seg7_Scan(
    input wire clk_100M,        // 板载时钟
    input wire [0:0] BT,        // 使用 BT[0] 作为复位
    input wire [35:0] SW,       // 36位开关 (31:0为数据, 35:34为选择)
    output wire [7:0] AN,       // 数码管位选
    output wire [7:0] SEG       // 数码管段选
    );

    wire rst;
    assign rst = BT[0]; // 按钮按下拉高复位

    // 提取控制信号
    wire [1:0] Sel;
    assign Sel = SW[35:34]; // 使用最左边的两个开关作为选择位

    wire [31:0] Switch_Data;
    assign Switch_Data = SW[31:0];

    // --- 四选一数据选择器 (Mux) ---
    reg [31:0] Data_To_Show;

    always @(*) begin
        case(Sel)
            2'b00: Data_To_Show = Switch_Data;         // 模式0: 显示开关数据
            2'b01: Data_To_Show = 32'h12345678;        // 模式1: 固定常数1
            2'b10: Data_To_Show = 32'h87654321;        // 模式2: 固定常数2
            2'b11: Data_To_Show = 32'h19491001;        // 模式3: 固定常数3 (国庆)
            default: Data_To_Show = 32'h00000000;
        endcase
    end

    // --- 实例化数码管显示模块 ---
    Tube u_Tube (
        .clk    (clk_100M),
        .rst    (rst),
        .Data   (Data_To_Show),
        .AN     (AN),
        .SEG    (SEG)
    );

endmodule
