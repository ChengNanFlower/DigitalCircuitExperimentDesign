`timescale 1ns / 1ps

module Top_Rev_Counter(
    input wire [15:0] SW,   // 开关输入 (使用SW[10:0])
    input wire BT,          // 按键输入 (使用BT作为时钟)
    output wire [7:0] LED   // LED输出
    );
    
    // 信号连接说明:
    // SW[0]  -> CLR (异步清零信号，高电平有效)
    // SW[1]  -> LD (加载信号，低电平有效)
    // SW[2]  -> U_D (上/下计数控制，高电平=下计数, 低电平=上计数)
    // SW[6:3] -> D[3:0] (并行数据输入)
    // SW[7]  -> 未使用
    // SW[10:8] -> 未使用
    // BT     -> CLK (时钟输入)
    // LED[3:0] -> Q[3:0] (计数输出)
    // LED[4]   -> MAX/MIN指示
    // LED[5]   -> RCO指示
    // LED[7:6] -> 未使用
    
    // 内部连线
    wire [3:0] counter_out;
    wire max_min_sig;
    wire rco_sig;
    
    // 实例化4位可逆计数器模块
    Rev_Counter_4bit rev_counter_inst (
        .CLK(BT),                           // 时钟输入
        .CLR(SW[0]),                        // 异步清零信号
        .LD(SW[1]),                         // 加载信号
        .U_D(SW[2]),                        // 上/下计数控制
        .D({SW[6], SW[5], SW[4], SW[3]}),   // 4位并行数据输入
        .Q(counter_out),                    // 4位计数输出
        .MAX_MIN(max_min_sig),              // 最大/最小值指示信号
        .RCO(rco_sig)                       // 进位输出
    );
    
    // 连接LED输出
    assign LED[3:0] = counter_out;       // 计数值显示在LED[3:0]
    assign LED[4] = max_min_sig;         // MAX/MIN指示显示在LED[4]
    assign LED[5] = rco_sig;             // RCO指示显示在LED[5]
    assign LED[7:6] = 2'b00;             // LED[7:6]未使用，设为0
    
endmodule