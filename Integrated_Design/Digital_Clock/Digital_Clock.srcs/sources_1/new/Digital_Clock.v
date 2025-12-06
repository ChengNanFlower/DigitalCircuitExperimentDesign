`timescale 1ns / 1ps

module Digital_Clock(
    input clk_100M,       // 100MHz 系统时钟 (Pin E3)
    input rst,            // 复位按键 (BT[0] - D15)
    input mode_sw,        // 模式切换: 0=正常走时, 1=设置时间 (SW[0] - P17)
    input btn_h,          // 小时加1 (BT[3])
    input btn_m,          // 分钟加1 (BT[2])
    input btn_s,          // 秒加1   (BT[1])
    output [7:0] SEG,     // 数码管段选: 这里的顺序在 assign 时修正
    output [7:0] AN       // 数码管位选
    );

    // ==========================================
    // 1. 时钟分频模块
    // ==========================================
    reg [31:0] cnt_1hz;
    reg clk_1hz_flag;     // 1Hz 脉冲信号
    reg [16:0] cnt_scan;
    wire clk_scan;        // 扫描时钟

    always @(posedge clk_100M or posedge rst) begin
        if(rst) begin
            cnt_1hz <= 0;
            clk_1hz_flag <= 0;
        end else begin
            if(cnt_1hz >= 99_999_999) begin // 1秒: 100M-1
                cnt_1hz <= 0;
                clk_1hz_flag <= 1;
            end else begin
                cnt_1hz <= cnt_1hz + 1;
                clk_1hz_flag <= 0;
            end
        end
    end

    // 扫描时钟生成 (使用计数器高位)
    always @(posedge clk_100M) cnt_scan <= cnt_scan + 1;
    assign clk_scan = cnt_scan[16]; 

    // ==========================================
    // 2. 按键边沿检测 (简化版消抖)
    // ==========================================
    reg btn_h_r, btn_h_rr, btn_m_r, btn_m_rr, btn_s_r, btn_s_rr;
    
    always @(posedge clk_100M) begin
        btn_h_r <= btn_h; btn_h_rr <= btn_h_r;
        btn_m_r <= btn_m; btn_m_rr <= btn_m_r;
        btn_s_r <= btn_s; btn_s_rr <= btn_s_r;
    end
    
    wire h_press = btn_h_r & ~btn_h_rr; // 检测上升沿
    wire m_press = btn_m_r & ~btn_m_rr;
    wire s_press = btn_s_r & ~btn_s_rr;

    // ==========================================
    // 3. 时钟计数逻辑
    // ==========================================
    reg [5:0] sec;
    reg [5:0] min;
    reg [4:0] hour;

    always @(posedge clk_100M or posedge rst) begin
        if(rst) begin
            sec <= 0; min <= 0; hour <= 0;
        end else if (mode_sw == 1) begin 
            // --- 设置模式 ---
            if(s_press) begin 
                if(sec >= 59) sec <= 0; else sec <= sec + 1; 
            end
            if(m_press) begin 
                if(min >= 59) min <= 0; else min <= min + 1; 
            end
            if(h_press) begin 
                if(hour >= 23) hour <= 0; else hour <= hour + 1; 
            end
        end else begin 
            // --- 走时模式 ---
            if(clk_1hz_flag) begin
                if(sec >= 59) begin
                    sec <= 0;
                    if(min >= 59) begin
                        min <= 0;
                        if(hour >= 23) hour <= 0;
                        else hour <= hour + 1;
                    end else begin
                        min <= min + 1;
                    end
                end else begin
                    sec <= sec + 1;
                end
            end
        end
    end

    // ==========================================
    // 4. 数码管显示驱动 (修正乱码的关键部分)
    // ==========================================
    wire [3:0] sec_unit = sec % 10;
    wire [3:0] sec_tens = sec / 10;
    wire [3:0] min_unit = min % 10;
    wire [3:0] min_tens = min / 10;
    wire [3:0] hour_unit = hour % 10;
    wire [3:0] hour_tens = hour / 10;

    reg [3:0] current_digit_val;
    reg [7:0] seg_temp; // 临时存储标准段码
    reg [7:0] an_reg;
    reg [2:0] scan_sel;

    always @(posedge clk_scan) begin
        scan_sel <= scan_sel + 1;
    end

    // 位选控制 (AN0 为最右侧数码管)
    always @(*) begin
        case(scan_sel)
            3'd0: begin an_reg = 8'b1111_1110; current_digit_val = sec_unit; end // AN0: 秒个位
            3'd1: begin an_reg = 8'b1111_1101; current_digit_val = sec_tens; end // AN1: 秒十位
            3'd2: begin an_reg = 8'b1111_1011; current_digit_val = 4'hf;     end // AN2: -
            3'd3: begin an_reg = 8'b1111_0111; current_digit_val = min_unit; end // AN3: 分个位
            3'd4: begin an_reg = 8'b1110_1111; current_digit_val = min_tens; end // AN4: 分十位
            3'd5: begin an_reg = 8'b1101_1111; current_digit_val = 4'hf;     end // AN5: -
            3'd6: begin an_reg = 8'b1011_1111; current_digit_val = hour_unit; end // AN6: 时个位
            3'd7: begin an_reg = 8'b0111_1111; current_digit_val = hour_tens; end // AN7: 时十位
            default: begin an_reg = 8'b1111_1111; current_digit_val = 0; end
        endcase
    end
    
    // 标准共阳极数码管段码表 [DP, G, F, E, D, C, B, A]
    // 0 = 亮, 1 = 灭
    // 例如 0: 1100_0000 (C0) -> DP和G灭, 其余亮
    always @(*) begin
        case(current_digit_val)
            4'd0: seg_temp = 8'hc0;
            4'd1: seg_temp = 8'hf9;
            4'd2: seg_temp = 8'ha4;
            4'd3: seg_temp = 8'hb0;
            4'd4: seg_temp = 8'h99;
            4'd5: seg_temp = 8'h92;
            4'd6: seg_temp = 8'h82;
            4'd7: seg_temp = 8'hf8;
            4'd8: seg_temp = 8'h80;
            4'd9: seg_temp = 8'h90;
            4'hf: seg_temp = 8'hbf; // 显示横线 -
            default: seg_temp = 8'hff;
        endcase
    end

    // Output Assignment: 强行翻转位序以匹配用户 XDC
    // seg_temp[0] 是 A，必须连接到 SEG[7] (Pin E2)
    // seg_temp[1] 是 B，必须连接到 SEG[6] (Pin A3)
    // ...
    assign SEG = {seg_temp[0], seg_temp[1], seg_temp[2], seg_temp[3], seg_temp[4], seg_temp[5], seg_temp[6], seg_temp[7]};
    
    assign AN  = an_reg;

endmodule
