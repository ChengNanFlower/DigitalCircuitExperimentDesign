module Top_74LS76(
    input wire [7:0] SW,  // 开关输入
    input wire [0:0] BT,  // 按键输入 (用作 CP)
    output wire [3:0] LED // LED 输出
    );

    // 第1个 J-K 触发器实例化
    // 映射: J=SW0, K=SW1, n_SD=SW2, n_RD=SW3, CP=BT0
    // 输出: Q=LED0, Q_n=LED1
    JK_FlipFlop JK1 (
        .CP   (BT[0]),
        .n_SD (SW[2]),
        .n_RD (SW[3]),
        .J    (SW[0]),
        .K    (SW[1]),
        .Q    (LED[0]),
        .Q_n  (LED[1])
    );

    // 第2个 J-K 触发器实例化 (实验选做，若只要一个可忽略此段)
    // 映射: J=SW4, K=SW5, n_SD=SW6, n_RD=SW7, CP=BT0 (共用时钟)
    // 输出: Q=LED2, Q_n=LED3
    JK_FlipFlop JK2 (
        .CP   (BT[0]),
        .n_SD (SW[6]),
        .n_RD (SW[7]),
        .J    (SW[4]),
        .K    (SW[5]),
        .Q    (LED[2]),
        .Q_n  (LED[3])
    );

endmodule
