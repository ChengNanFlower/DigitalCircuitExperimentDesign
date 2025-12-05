`timescale 1ns / 1ps

module TB_JK_FlipFlop();
    reg CP, n_SD, n_RD, J, K;
    wire Q, Q_n;

    // 实例化待测模块
    JK_FlipFlop uut (
        .CP(CP), .n_SD(n_SD), .n_RD(n_RD), .J(J), .K(K), .Q(Q), .Q_n(Q_n)
    );

    // 产生时钟
    initial CP = 0;
    always #10 CP = ~CP; // 周期20ns

    initial begin
        // 初始化
        n_SD = 1; n_RD = 1; J = 0; K = 0; 
        #20; 
        
        // 1. 测试异步复位 (n_RD=0)
        n_RD = 0; #20;
        n_RD = 1; #20; // 此时 Q 应为 0
        
        // 2. 测试异步置位 (n_SD=0)
        n_SD = 0; #20;
        n_SD = 1; #20; // 此时 Q 应为 1
        
        // 3. 测试 J=0, K=1 (置0)
        J=0; K=1; #40;
        
        // 4. 测试 J=1, K=0 (置1)
        J=1; K=0; #40;
        
        // 5. 测试 J=1, K=1 (翻转)
        J=1; K=1; #100; 
        
        // 6. 测试 J=0, K=0 (保持)
        J=0; K=0; #40;
        
        $stop;
    end
endmodule
