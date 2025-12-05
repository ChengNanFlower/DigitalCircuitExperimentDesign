`timescale 1ns / 1ps

module ShiftReg_Top(
    input           clk_100M,   // E3 System Clock
    input  [15:0]   SW,         // Switches
    input  [0:0]    BT,         // Button (Used as CLK pulse)
    output [7:0]    LED         // LEDs
    );

    // --- 信号定义 ---
    wire nCR = SW[15];          // 异步清零 (Active Low)
    wire [1:0] S = SW[14:13];   // 功能选择 S1, S0
    wire SR_in = SW[12];        // 右移串行输入
    wire SL_in = SW[11];        // 左移串行输入
    wire [7:0] D = SW[7:0];     // 并行输入数据
    
    reg [7:0] Q_reg;            // 寄存器输出
    assign LED = Q_reg;
    
    // --- 按键消抖与边沿检测 (Button Debounce & Edge Detect) ---
    // 只有检测到按键按下的上升沿，才产生一个时钟周期的 CP_pulse
    reg [19:0] cnt;             // 延时计数器
    reg btn_r0, btn_r1;         // 按键状态缓存
    wire CP_pulse;              // 消抖后的单次脉冲
    
    always @(posedge clk_100M) begin
        btn_r0 <= BT[0];
        // 简单的20ms消抖逻辑
        if(cnt < 20'd1_000_000) cnt <= cnt + 1;
        else begin 
            cnt <= 0;
            btn_r1 <= btn_r0;   // 只有状态稳定后才更新 btn_r1
        end 
    end
    
    // 边沿检测：当前稳定值(btn_r0)为1，且上一时刻稳定值(btn_r1)为0时，判定为按下
    // 注意：这里为了简化，使用btn_r1作为稳定判定后的旧值，配合btn_r0检测
    // 更严谨的做法是两级寄存器打拍，但对于实验课此逻辑足够
    reg btn_state, btn_state_last;
    always @(posedge clk_100M) begin
        if (cnt == 0) btn_state <= btn_r0; // 每隔一段时间采样一次
        btn_state_last <= btn_state;
    end
    assign CP_pulse = btn_state & (~btn_state_last); // 上升沿检测

    // --- 74LS198 核心逻辑 (Core Logic) ---
    // 行为完全对应表 5.16
    always @(posedge clk_100M or negedge nCR) begin
        if (!nCR) begin
            // 异步清零：优先级最高 (Step 1)
            Q_reg <= 8'b0000_0000;
        end
        else if (CP_pulse) begin
            // 仅当按键按下产生脉冲时，执行功能 (Step 2-5)
            case (S)
                2'b00: Q_reg <= Q_reg;                     // 保持 (Hold)
                2'b01: Q_reg <= {SR_in, Q_reg[7:1]};       // 右移 (Shift Right)
                2'b10: Q_reg <= {Q_reg[6:0], SL_in};       // 左移 (Shift Left)
                2'b11: Q_reg <= D;                         // 并行置数 (Parallel Load)
                default: Q_reg <= Q_reg;
            endcase
        end
    end

endmodule
