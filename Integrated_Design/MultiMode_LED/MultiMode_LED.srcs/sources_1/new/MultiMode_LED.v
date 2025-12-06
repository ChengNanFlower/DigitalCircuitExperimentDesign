module MultiMode_LED(
    input wire clk_100M, // E3 引脚
    input wire [1:0] SW, // T18, P17
    input wire BT_RST,   // D15 (假设使用BT[0]作为复位)
    output wire [15:0] LED
);

    wire clk_slow;

    // 实例化分频器
    clk_div #(
        .CNT_MAX(12500000) // 实物使用参数
    ) u_clk_div (
        .clk_in(clk_100M),
        .rst(BT_RST),
        .clk_out(clk_slow)
    );

    // 实例化LED控制器
    led_ctrl u_led_ctrl (
        .clk(clk_slow),
        .rst(BT_RST),
        .sw(SW),
        .led(LED)
    );

endmodule
