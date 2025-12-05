`timescale 1ns / 1ps

module JK_FlipFlop(
    input wire CP,    // 时钟脉冲 (下降沿有效)
    input wire n_SD,  // 异步置位 (低电平有效)
    input wire n_RD,  // 异步复位 (低电平有效)
    input wire J,     // 激励输入 J
    input wire K,     // 激励输入 K
    output reg Q,     // 输出 Q
    output wire Q_n   // 输出 Q非
    );

    assign Q_n = ~Q; // Q_n 永远是 Q 的反

    // 敏感列表包含时钟下降沿和异步信号的下降沿
    always @(negedge CP or negedge n_SD or negedge n_RD) begin
        // 异步控制优先级最高
        if (!n_SD) begin
            Q <= 1'b1;  // 置位
        end
        else if (!n_RD) begin
            Q <= 1'b0;  // 复位/清零
        end
        else begin
            // 此时钟沿到来时的 J-K 逻辑
            case ({J, K})
                2'b00: Q <= Q;      // 保持
                2'b01: Q <= 1'b0;   // 置0
                2'b10: Q <= 1'b1;   // 置1
                2'b11: Q <= ~Q;     // 翻转
            endcase
        end
    end
endmodule
