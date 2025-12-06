`timescale 1ns / 1ps

module tb_Digital_Clock;
    reg clk;
    reg rst;
    reg mode_sw;
    reg btn_h, btn_m, btn_s;
    wire [7:0] SEG;
    wire [7:0] AN;

    // 实例化被测模块
    Digital_Clock uut (
        .clk_100M(clk),
        .rst(rst),
        .mode_sw(mode_sw),
        .btn_h(btn_h),
        .btn_m(btn_m),
        .btn_s(btn_s),
        .SEG(SEG),
        .AN(AN)
    );

    // 生成时钟
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 100MHz
    end

    // 测试流程
    initial begin
        // 初始化
        rst = 1; mode_sw = 0; btn_h = 0; btn_m = 0; btn_s = 0;
        #100;
        rst = 0;
        
        // 1. 测试正常走时 (由于仿真1s太慢，在实际代码中需要暂时将 cnt_1hz 阈值改小才能看到效果，这里仅模拟信号)
        #1000;
        
        // 2. 测试设置模式
        mode_sw = 1; // 进入设置模式
        #100;
        
        // 模拟按键调整秒
        btn_s = 1; #20; btn_s = 0; #20; // +1s
        btn_s = 1; #20; btn_s = 0; #20; // +1s
        
        // 模拟按键调整分
        btn_m = 1; #20; btn_m = 0; #20; // +1m
        
        // 恢复正常模式
        mode_sw = 0;
        
        #5000;
        $stop;
    end
endmodule
