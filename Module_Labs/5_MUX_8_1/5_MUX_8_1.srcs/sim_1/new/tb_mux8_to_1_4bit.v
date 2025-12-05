//-----------------------------------------------------------------
// Module:      tb_mux8_to_1_4bit
// Description: 针对 mux8_to_1_4bit 模块的仿真测试平台
// Author:      AI Assistant
//-----------------------------------------------------------------

`timescale 1ns / 1ps // 定义时间单位和精度

module tb_mux8_to_1_4bit;

    // 激励信号定义为 reg 类型
    reg  [3:0]   d0, d1, d2, d3, d4, d5, d6, d7;
    reg  [2:0]   sel;

    // 响应信号定义为 wire 类型
    wire [3:0]   y;

    // 实例化待测试模块 (DUT: Design Under Test)
    mux8_to_1_4bit dut (
        .d0(d0), .d1(d1), .d2(d2), .d3(d3),
        .d4(d4), .d5(d5), .d6(d6), .d7(d7),
        .sel(sel),
        .y(y)
    );

    // 仿真激励过程
    initial begin
        // 1. 初始化输入信号
        $display("------ Simulation Start ------");
        d0 = 4'hA; // 1010
        d1 = 4'hB; // 1011
        d2 = 4'hC; // 1100
        d3 = 4'hD; // 1101
        d4 = 4'h1; // 0001
        d5 = 4'h2; // 0010
        d6 = 4'h3; // 0011
        d7 = 4'h4; // 0100
        sel = 3'b000;
        
        // 2. 产生激励序列，遍历所有选择情况
        #10; // 延时10ns
        
        // 测试 sel = 000
        sel = 3'b000; #10;
        $display("Time=%0t ns, sel=%b, y=%h (expected: %h)", $time, sel, y, d0);

        // 测试 sel = 001
        sel = 3'b001; #10;
        $display("Time=%0t ns, sel=%b, y=%h (expected: %h)", $time, sel, y, d1);
        
        // 测试 sel = 010
        sel = 3'b010; #10;
        $display("Time=%0t ns, sel=%b, y=%h (expected: %h)", $time, sel, y, d2);

        // 测试 sel = 011
        sel = 3'b011; #10;
        $display("Time=%0t ns, sel=%b, y=%h (expected: %h)", $time, sel, y, d3);

        // 测试 sel = 100
        sel = 3'b100; #10;
        $display("Time=%0t ns, sel=%b, y=%h (expected: %h)", $time, sel, y, d4);
        
        // 测试 sel = 101
        sel = 3'b101; #10;
        $display("Time=%0t ns, sel=%b, y=%h (expected: %h)", $time, sel, y, d5);
        
        // 测试 sel = 110
        sel = 3'b110; #10;
        $display("Time=%0t ns, sel=%b, y=%h (expected: %h)", $time, sel, y, d6);
        
        // 测试 sel = 111
        sel = 3'b111; #10;
        $display("Time=%0t ns, sel=%b, y=%h (expected: %h)", $time, sel, y, d7);
        
        // 3. 结束仿真
        #20;
        $display("------ Simulation End ------");
        $stop;
    end

endmodule
