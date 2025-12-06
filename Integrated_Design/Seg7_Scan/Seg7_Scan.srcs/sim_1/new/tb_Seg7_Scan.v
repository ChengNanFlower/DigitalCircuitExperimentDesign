`timescale 1ns / 1ps

module tb_Seg7_Scan;

    // Inputs
    reg clk_100M;
    reg [0:0] BT;
    reg [35:0] SW;

    // Outputs
    wire [7:0] AN;
    wire [7:0] SEG;

    // Instantiate the Unit Under Test (UUT)
    Seg7_Scan uut (
        .clk_100M(clk_100M), 
        .BT(BT), 
        .SW(SW), 
        .AN(AN), 
        .SEG(SEG)
    );

    initial begin
        // Initialize Inputs
        clk_100M = 0;
        BT = 0;     // 复位，假设按下为1
        SW = 0;

        // 1. 复位测试
        #100;
        BT[0] = 1;  // 按下复位
        #100;
        BT[0] = 0;  // 释放复位
        
        // 2. 测试模式 1: 显示常数 12345678
        SW[35:34] = 2'b01; 
        #5000000; // 仿真运行足够长的时间看 AN 切换 (5ms)

        // 3. 测试模式 0: 显示开关数据 AAAAAAAA
        SW[35:34] = 2'b00;
        SW[31:0] = 32'hAAAAAAAA;
        #5000000;

        $stop;
    end
    
    // 产生 100MHz 时钟 (周期 10ns)
    always #5 clk_100M = ~clk_100M;
      
endmodule
