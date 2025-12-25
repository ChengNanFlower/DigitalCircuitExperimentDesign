`timescale 1ns / 1ps

module Tube(
    input wire clk,             // 100MHz 系统时钟
    input wire rst,             // 复位信号 (高电平有效)
    input wire [31:0] Data,     // 要显示的32位数据
    output reg [7:0] AN,        // 位选信号 (Active Low)
    output reg [7:0] SEG        // 段选信号 (Active Low)
    );

    // --- 1. 产生扫描时钟 (约2ms) ---
    reg [17:0] count;
    wire clk_fresh;
    
    always @(posedge clk or posedge rst) begin
        if(rst)
            count <= 0;
        else
            count <= count + 1'b1;
    end
    // 100MHz / 2^18 ≈ 381Hz (约2.6ms周期)，符合人眼视觉暂留
    assign clk_fresh = count[17]; 

    // --- 2. 位选控制 (轮流点亮) ---
    reg [2:0] bit_select;
    
    always @(posedge clk_fresh or posedge rst) begin
        if(rst) 
            bit_select <= 0;
        else 
            bit_select <= bit_select + 1'b1;
    end

    always @(*) begin
        case(bit_select)
            3'd0: AN = 8'b1111_1110; // TB0
            3'd1: AN = 8'b1111_1101; // TB1
            3'd2: AN = 8'b1111_1011; // TB2
            3'd3: AN = 8'b1111_0111; // TB3
            3'd4: AN = 8'b1110_1111; // TB4
            3'd5: AN = 8'b1101_1111; // TB5
            3'd6: AN = 8'b1011_1111; // TB6
            3'd7: AN = 8'b0111_1111; // TB7
            default: AN = 8'b1111_1111;
        endcase
    end

    // --- 3. 数据选择 ---
    reg [3:0] hex_digit;
    always @(*) begin
        case(bit_select)
            3'd0: hex_digit = Data[3:0];
            3'd1: hex_digit = Data[7:4];
            3'd2: hex_digit = Data[11:8];
            3'd3: hex_digit = Data[15:12];
            3'd4: hex_digit = Data[19:16];
            3'd5: hex_digit = Data[23:20];
            3'd6: hex_digit = Data[27:24];
            3'd7: hex_digit = Data[31:28];
            default: hex_digit = 4'h0;
        endcase
    end

    // --- 4. 段选解码 (字形显示) ---
    // 依据实验指导书表6.1编码 (共阳极，0亮1灭)
    // 顺序假定为: A B C D E F G DP (根据 0=00000011 推断 A为最高位)
    always @(*) begin
        case(hex_digit)
            4'h0: SEG = 8'b0000_0011; // 0
            4'h1: SEG = 8'b1001_1111; // 1
            4'h2: SEG = 8'b0010_0101; // 2
            4'h3: SEG = 8'b0000_1101; // 3
            4'h4: SEG = 8'b1001_1001; // 4
            4'h5: SEG = 8'b0100_1001; // 5
            4'h6: SEG = 8'b0100_0001; // 6
            4'h7: SEG = 8'b0001_1111; // 7
            4'h8: SEG = 8'b0000_0001; // 8
            4'h9: SEG = 8'b0000_1001; // 9
            4'hA: SEG = 8'b0001_0001; // A
            4'hB: SEG = 8'b1100_0001; // b
            4'hC: SEG = 8'b0110_0011; // C
            4'hD: SEG = 8'b1000_0101; // d
            4'hE: SEG = 8'b0110_0001; // E
            4'hF: SEG = 8'b0111_0001; // F
            default: SEG = 8'b1111_1111; // 灭
        endcase
    end

endmodule
