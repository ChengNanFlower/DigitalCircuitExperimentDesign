`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/11/14 13:39:54
// Design Name: 
// Module Name: decoder_74ls138
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module decoder_74ls138 (
    // 输入信号
    input       G1,         // 使能端, 高电平有效
    input       G2A_bar,    // 使能端, 低电平有效
    input       G2B_bar,    // 使能端, 低电平有效
    input [2:0] A_in,       // 3位地址输入 (A_in[2]对应C, A_in[1]对应B, A_in[0]对应A)
    // 输出信号
    output reg [7:0] Y_out_bar  // 8位输出, 低电平有效 (Y_out_bar[7]对应Y7, ..., Y_out_bar[0]对应Y0)
);
    // always块用于描述组合逻辑
    // 当任意一个输入信号(G1, G2A_bar, G2B_bar, A_in)发生变化时，就执行块内的代码
    always @(*) begin
        // 判断译码器是否使能
        // 使能条件: G1=1, G2A_bar=0, G2B_bar=0
        if ( (G1 == 1'b1) && (G2A_bar == 1'b0) && (G2B_bar == 1'b0) ) begin
            // 在使能状态下，根据地址输入A_in的值进行译码
            case (A_in)
                3'b000: Y_out_bar = 8'b11111110; // A_in=0, Y0_bar有效(为0)
                3'b001: Y_out_bar = 8'b11111101; // A_in=1, Y1_bar有效(为0)
                3'b010: Y_out_bar = 8'b11111011; // A_in=2, Y2_bar有效(为0)
                3'b011: Y_out_bar = 8'b11110111; // A_in=3, Y3_bar有效(为0)
                3'b100: Y_out_bar = 8'b11101111; // A_in=4, Y4_bar有效(为0)
                3'b101: Y_out_bar = 8'b11011111; // A_in=5, Y5_bar有效(为0)
                3'b110: Y_out_bar = 8'b10111111; // A_in=6, Y6_bar有效(为0)
                3'b111: Y_out_bar = 8'b01111111; // A_in=7, Y7_bar有效(为0)
                default: Y_out_bar = 8'b11111111; // 默认情况，所有输出无效
            endcase
        end
        else begin
            // 在未使能状态下，所有输出都为高电平(无效状态)
            Y_out_bar = 8'b11111111;
        end
    end
endmodule
