`timescale 1ns / 1ps

module tb_ShiftReg_Top();

    reg clk_100M;
    reg [15:0] SW;
    reg [0:0] BT;
    wire [7:0] LED;

    // 实例化被测模块
    ShiftReg_Top uut (
        .clk_100M(clk_100M), 
        .SW(SW), 
        .BT(BT), 
        .LED(LED)
    );

    // 生成100MHz时钟
    initial begin
        clk_100M = 0;
        forever #5 clk_100M = ~clk_100M;
    end

    // 定义模拟按键按下的任务 (Task)
    task press_button;
        begin
            BT[0] = 1;
            #20000000; // 模拟按住20ms (仿真时如果跑得慢，可这里改小一点，比如 #100)
            BT[0] = 0;
            #20000000; // 松开
        end
    endtask

    initial begin
        // 1. 初始化
        SW = 0; 
        BT = 0;
        SW[15] = 0; // nCR = 0 (Reset)
        #100;
        
        // 2. 释放复位
        SW[15] = 1; // nCR = 1
        
        // 3. 并行置数 (Load D = 8'b10101010)
        SW[14:13] = 2'b11; // S = 11
        SW[7:0] = 8'b10101010;
        #100 press_button(); // 产生CP脉冲
        
        // 4. 保持 (Hold)
        SW[14:13] = 2'b00;
        SW[7:0] = 8'b00000000; // 改变输入看输出变不变
        #100 press_button();
        
        // 5. 右移 (Shift Right) - 补1
        SW[14:13] = 2'b01;
        SW[12] = 1; // SR_in = 1
        #100 press_button(); // 移一位
        #100 press_button(); // 再移一位
        
        // 6. 左移 (Shift Left) - 补0
        SW[14:13] = 2'b10;
        SW[11] = 0; // SL_in = 0
        #100 press_button();
        
        // 7. 异步清零测试
        #100 SW[15] = 0;
        
        #1000 $stop;
    end

endmodule
