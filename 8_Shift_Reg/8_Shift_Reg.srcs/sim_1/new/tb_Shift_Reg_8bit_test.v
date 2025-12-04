`timescale 1ns / 1ps

module tb_Shift_Reg_8bit_test;

    // 定义测试模块的输入输出信号
    reg CLK;
    reg CR;
    reg SI;
    reg SO;
    reg CP;
    reg [7:0] DI;
    wire [7:0] Q;
    wire SQ;
    
    // 实例化移位寄存器模块
    Shift_Reg_8bit uut (
        .CLK(CLK),
        .CR(CR),
        .SI(SI),
        .SO(SO),
        .CP(CP),
        .DI(DI),
        .Q(Q),
        .SQ(SQ)
    );
    
    // 时钟生成
    always begin
        #10 CP = ~CP;  // 50MHz时钟
    end
    
    // 测试过程
    initial begin
        // 初始化信号
        CLK = 0;
        CR = 1;   // 正常工作状态（高电平）
        SI = 0;   // 初始保持状态
        SO = 0;
        CP = 0;
        DI = 8'b00000000;
        
        // 显示初始状态
        $display("Time\tCR\tSI\tDI\t\tQ\t\tSQ");
        $display("------------------------------------------------");
        #20;
        display_status();
        
        // 测试异步清零功能
        $display("\n=== 测试异步清零功能 ===");
        CR = 0;  // 清零信号置低
        #20;
        display_status();
        CR = 1;  // 恢复正常工作状态
        #20;
        display_status();
        
        // 测试保持功能
        $display("\n=== 测试保持功能 ===");
        DI = 8'b10101010;  // 设置并行输入数据
        SI = 1;  // 启用移位
        #20;
        display_status();
        DI = 8'b00000000;  // 清除并行输入
        #20;
        display_status();
        
        // 测试右移功能
        $display("\n=== 测试右移功能 ===");
        SI = 1;  // 启用移位
        #40;  // 多个时钟周期
        display_status();
        
        // 测试左移功能（加载并行数据）
        $display("\n=== 测试左移功能（加载并行数据） ===");
        DI = 8'b11001100;  // 设置并行输入数据
        #20;
        display_status();
        DI = 8'b00000000;  // 清除并行输入
        #20;
        display_status();
        
        // 结束仿真
        $display("\n=== 仿真结束 ===");
        $finish;
    end
    
    // 显示当前状态的任务
    task display_status;
    begin
        $display("%0t\t%b\t%b\t%b\t%b\t%b", 
                 $time, CR, SI, DI, Q, SQ);
    end
    endtask

endmodule