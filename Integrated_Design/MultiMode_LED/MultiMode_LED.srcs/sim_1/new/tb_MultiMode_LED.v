`timescale 1ns / 1ps

module tb_MultiMode_LED();
    reg clk_100M;
    reg [1:0] SW;
    reg BT_RST;
    wire [15:0] LED;

    // 实例化顶层，但在仿真中我们想把分频改小以便快速观察
    // 此时需暂时修改 clk_div 的默认值或使用 defparam (如果模块结构允许)
    // 这里直接实例化顶层模块进行验证
    MultiMode_LED uut (
        .clk_100M(clk_100M), 
        .SW(SW), 
        .BT_RST(BT_RST), 
        .LED(LED)
    );

    // 强制覆盖分频参数用于仿真，否则仿真跑太慢
    defparam uut.u_clk_div.CNT_MAX = 5; 

    initial begin
        clk_100M = 0;
        BT_RST = 1; // 复位
        SW = 2'b00;
        
        #100 BT_RST = 0; // 释放复位
        
        // 测试模式 0: 从左到右
        #2000; 
        
        // 测试模式 1: 从右到左
        SW = 2'b01; 
        #2000;
        
        // 测试模式 2: 中间向两边
        SW = 2'b10;
        #2000;
        
        // 测试模式 3: 两边向中间
        SW = 2'b11;
        #2000;
        
        $stop;
    end

    always #5 clk_100M = ~clk_100M; // 100MHz 时钟

endmodule
