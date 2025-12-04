`timescale 1ns / 1ps

module tb_Shift_Reg_8bit;

    // 定义测试模块的输入输出信号
    reg [15:0] SW;
    reg BT;
    wire [7:0] LED;
    wire SQ_OUT;
    
    // 实例化顶层模块
    Top_Shift_Reg uut (
        .SW(SW),
        .BT(BT),
        .LED(LED),
        .SQ_OUT(SQ_OUT)
    );
    
    // 时钟生成
    always begin
        #10 BT = ~BT;  // 50MHz时钟
    end
    
    // 测试过程
    initial begin
        // 初始化信号
        SW = 16'b0000000000000000;
        BT = 0;
        
        // 显示初始状态
        $display("Time\tSW[0](CR)\tSW[1](SI)\tSW[2](SO)\tSW[10:3](DI)\t\tBT(CP)\tLED[7:0]\tSQ_OUT");
        $display("--------------------------------------------------------------------------");
        #20;
        display_status();
        
        // 测试异步清零功能
        $display("\n=== 测试异步清零功能 ===");
        SW[0] = 0;  // 清零信号置低（低电平有效，这时应该清零）
        #20;
        display_status();
        SW[0] = 1;  // 清零信号置高（恢复正常工作状态）
        #20;
        display_status();
        
        // 测试保持功能
        $display("\n=== 测试保持功能 ===");
        SW[10:3] = 8'b10101010;  // 设置并行输入数据
        SW[1] = 0;  // SI=0，保持模式
        #40;  // 多个时钟周期
        display_status();
        
        // 测试右移功能
        $display("\n=== 测试右移功能 ===");
        SW[1] = 1;  // SI=1，启用移位
        SW[10:3] = 8'b00000000;  // 清除并行输入
        #40;  // 多个时钟周期
        display_status();
        
        // 测试左移功能（加载并行数据）
        $display("\n=== 测试左移功能（加载并行数据） ===");
        SW[10:3] = 8'b11001100;  // 设置并行输入数据
        #40;  // 多个时钟周期
        display_status();
        
        // 结束仿真
        $display("\n=== 仿真结束 ===");
        $finish;
    end
    
    // 显示当前状态的任务
    task display_status;
    begin
        $display("%0t\t%b\t\t%b\t\t%b\t\t%b\t%b\t%b\t%b", 
                 $time, SW[0], SW[1], SW[2], SW[10:3], BT, LED, SQ_OUT);
    end
    endtask

endmodule