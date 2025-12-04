`timescale 1ns / 1ps

module tb_Register_8bit;

    // 声明测试信号
    reg CLK;
    reg CLR;
    reg OE_N;
    reg [7:0] D;
    wire [7:0] Q;
    
    // 实例化被测模块
    Register_8bit uut (
        .CLK(CLK),
        .CLR(CLR),
        .OE_N(OE_N),
        .D(D),
        .Q(Q)
    );
    
    // 时钟生成
    initial begin
        CLK = 0;
        forever #5 CLK = ~CLK;  // 10ns周期时钟
    end
    
    // 测试序列
    initial begin
        // 初始化信号
        CLR = 0;
        OE_N = 1;  // 初始禁止输出
        D = 8'b00000000;
        
        // 显示标题
        $display("Time\tCLK\tCLR\tOE_N\tD\t\tQ");
        $display("----\t---\t---\t-----\t--------\t--------");
        
        // 等待几个时钟周期
        #15;
        $display("%0t\t%b\t%b\t%b\t%b\t%b", $time, CLK, CLR, OE_N, D, Q);
        
        // 测试1: 异步清零功能
        CLR = 1;  // 激活清零
        #10;
        $display("%0t\t%b\t%b\t%b\t%b\t%b", $time, CLK, CLR, OE_N, D, Q);
        
        CLR = 0;  // 释放清零
        #10;
        $display("%0t\t%b\t%b\t%b\t%b\t%b", $time, CLK, CLR, OE_N, D, Q);
        
        // 测试2: 正常数据锁存功能
        D = 8'b10101010;  // 设置输入数据
        #10;
        $display("%0t\t%b\t%b\t%b\t%b\t%b", $time, CLK, CLR, OE_N, D, Q);
        
        @(posedge CLK);  // 等待时钟上升沿
        #1;
        $display("%0t\t%b\t%b\t%b\t%b\t%b", $time, CLK, CLR, OE_N, D, Q);
        
        // 测试3: 输出使能功能
        OE_N = 0;  // 使能输出
        #1;
        $display("%0t\t%b\t%b\t%b\t%b\t%b", $time, CLK, CLR, OE_N, D, Q);
        
        // 改变输入数据
        D = 8'b11110000;
        @(posedge CLK);  // 等待时钟上升沿
        #1;
        $display("%0t\t%b\t%b\t%b\t%b\t%b", $time, CLK, CLR, OE_N, D, Q);
        
        // 测试4: 禁止输出
        OE_N = 1;  // 禁止输出
        #1;
        $display("%0t\t%b\t%b\t%b\t%b\t%b", $time, CLK, CLR, OE_N, D, Q);
        
        // 结束仿真
        #20;
        $display("Simulation finished.");
        $finish;
    end
    
endmodule