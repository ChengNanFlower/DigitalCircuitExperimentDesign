//-----------------------------------------------------------------
// Module:      top
// Description: 顶层模块，例化8选1选择器并连接到FPGA引脚
// Author:      AI Assistant
//-----------------------------------------------------------------

module top (
    input  wire [35:0]  SW,     // 36位拨码开关输入
    output wire [3:0]   LED     // 4位LED输出 (只使用低4位)
);
    
    // 定义内部连线
    wire [3:0] data_inputs [0:7]; // 使用数组简化连接
    wire [2:0] select_signal;
    wire [3:0] mux_output;

    // 将开关信号分配给选择信号和8组数据输入
    assign select_signal = SW[34:32];
    assign data_inputs[0] = SW[3:0];
    assign data_inputs[1] = SW[7:4];
    assign data_inputs[2] = SW[11:8];
    assign data_inputs[3] = SW[15:12];
    assign data_inputs[4] = SW[19:16];
    assign data_inputs[5] = SW[23:20];
    assign data_inputs[6] = SW[27:24];
    assign data_inputs[7] = SW[31:28];

    // 例化8选1数据选择器
    mux8_to_1_4bit u_mux (
        .d0(data_inputs[0]),
        .d1(data_inputs[1]),
        .d2(data_inputs[2]),
        .d3(data_inputs[3]),
        .d4(data_inputs[4]),
        .d5(data_inputs[5]),
        .d6(data_inputs[6]),
        .d7(data_inputs[7]),
        .sel(select_signal),
        .y(mux_output)
    );

    // 将选择器的输出连接到LED
    assign LED = mux_output;

endmodule
