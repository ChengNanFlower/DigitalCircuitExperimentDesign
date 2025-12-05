`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/11/07 11:32:03
// Design Name: 
// Module Name: Adder_Design
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


module FA_gate(
    // 输出端口
    output Fi,
    output Ci_plus_1,
    // 输入端口
    input Ai,
    input Bi,
    input Ci
);
    // 中间信号
    wire w1, w2, w3;
    // 全加器逻辑实现
    xor U1(w1, Ai, Bi);
    xor U2(Fi, w1, Ci);
    and U3(w2, Ai, Bi);
    and U4(w3, w1, Ci);
    or U5(Ci_plus_1, w2, w3);
endmodule
