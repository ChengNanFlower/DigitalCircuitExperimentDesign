`timescale 1ns / 1ps

module Digital_Clock(
    input clk_100M,        // 100MHz 系统时钟 (Pin E3)
    input rst,             // 复位按键 (BT[0])
    input sw_set_time,     // [SW0] 0=走时, 1=设置当前时间
    input sw_set_alarm,    // [SW1] 0=显示时间, 1=显示/设置闹钟
    input btn_h,           // 小时加1 (BT[3])
    input btn_m,           // 分钟加1 (BT[2])
    input btn_s,           // 秒加1   (BT[1])
    output [7:0] SEG,      // 数码管段选 (已修正乱码)
    output [7:0] AN,       // 数码管位选
    output [15:0] LED      // LED指示灯 (闹钟响时点亮)
    );

    // ==========================================
    // 1. 时钟分频模块
    // ==========================================
    reg [31:0] cnt_1hz;
    reg clk_1hz_flag;
    reg [16:0] cnt_scan;
    wire clk_scan;

    always @(posedge clk_100M or posedge rst) begin
        if(rst) begin
            cnt_1hz <= 0; clk_1hz_flag <= 0;
        end else begin
            if(cnt_1hz >= 99_999_999) begin 
                cnt_1hz <= 0; clk_1hz_flag <= 1;
            end else begin
                cnt_1hz <= cnt_1hz + 1; clk_1hz_flag <= 0;
            end
        end
    end

    // 扫描时钟生成
    always @(posedge clk_100M) cnt_scan <= cnt_scan + 1;
    assign clk_scan = cnt_scan[16]; 

    // ==========================================
    // 2. 按键边沿检测 (Edge Detection)
    // ==========================================
    reg btn_h_r, btn_h_rr, btn_m_r, btn_m_rr, btn_s_r, btn_s_rr;
    always @(posedge clk_100M) begin
        btn_h_r <= btn_h; btn_h_rr <= btn_h_r;
        btn_m_r <= btn_m; btn_m_rr <= btn_m_r;
        btn_s_r <= btn_s; btn_s_rr <= btn_s_r;
    end
    wire h_press = btn_h_r & ~btn_h_rr;
    wire m_press = btn_m_r & ~btn_m_rr;
    wire s_press = btn_s_r & ~btn_s_rr;

    // ==========================================
    // 3. 核心计时与闹钟设置逻辑
    // ==========================================
    reg [5:0] sec, min;
    reg [4:0] hour;
    
    // 闹钟寄存器
    reg [5:0] alarm_m;
    reg [4:0] alarm_h;

    always @(posedge clk_100M or posedge rst) begin
        if(rst) begin
            sec <= 0; min <= 0; hour <= 0;
            alarm_m <= 0; alarm_h <= 0;
        end else begin
            // --- 优先级判断 ---
            
            if (sw_set_alarm) begin
                // [模式 A]: 设置/查看 闹钟 (SW1=1)
                // 此时按键修改 alarm_h/m
                if(m_press) begin 
                    if(alarm_m >= 59) alarm_m <= 0; else alarm_m <= alarm_m + 1; 
                end
                if(h_press) begin 
                    if(alarm_h >= 23) alarm_h <= 0; else alarm_h <= alarm_h + 1; 
                end
                // 闹钟模式下时钟依然需要在后台走字
                if(clk_1hz_flag) begin
                    if(sec >= 59) begin
                        sec <= 0;
                        if(min >= 59) begin
                            min <= 0;
                            if(hour >= 23) hour <= 0; else hour <= hour + 1;
                        end else min <= min + 1;
                    end else sec <= sec + 1;
                end
            end 
            else if (sw_set_time) begin
                // [模式 B]: 设置 当前时间 (SW0=1, SW1=0)
                if(s_press) begin if(sec >= 59) sec <= 0; else sec <= sec + 1; end
                if(m_press) begin if(min >= 59) min <= 0; else min <= min + 1; end
                if(h_press) begin if(hour >= 23) hour <= 0; else hour <= hour + 1; end
            end 
            else begin
                // [模式 C]: 正常走时 (SW0=0, SW1=0)
                if(clk_1hz_flag) begin
                    if(sec >= 59) begin
                        sec <= 0;
                        if(min >= 59) begin
                            min <= 0;
                            if(hour >= 23) hour <= 0; else hour <= hour + 1;
                        end else min <= min + 1;
                    end else sec <= sec + 1;
                end
            end
        end
    end

    // ==========================================
    // 4. 数码管显示数据选择 (Multiplexer)
    // ==========================================
    reg [5:0] disp_sec, disp_min;
    reg [4:0] disp_hour;

    always @(*) begin
        if(sw_set_alarm) begin
            // 如果在闹钟设置模式，显示闹钟时间 (秒位显示00)
            disp_hour = alarm_h;
            disp_min  = alarm_m;
            disp_sec  = 6'd0; 
        end else begin
            // 否则显示当前时间
            disp_hour = hour;
            disp_min  = min;
            disp_sec  = sec;
        end
    end

    // ==========================================
    // 5. 数码管驱动 (包含乱码修复)
    // ==========================================
    wire [3:0] s_u = disp_sec % 10;
    wire [3:0] s_t = disp_sec / 10;
    wire [3:0] m_u = disp_min % 10;
    wire [3:0] m_t = disp_min / 10;
    wire [3:0] h_u = disp_hour % 10;
    wire [3:0] h_t = disp_hour / 10;

    reg [3:0] digit_val;
    reg [7:0] seg_temp;
    reg [7:0] an_reg;
    reg [2:0] scan_sel;

    always @(posedge clk_scan) scan_sel <= scan_sel + 1;

    always @(*) begin
        case(scan_sel)
            3'd0: begin an_reg = 8'b1111_1110; digit_val = s_u; end
            3'd1: begin an_reg = 8'b1111_1101; digit_val = s_t; end
            3'd2: begin an_reg = 8'b1111_1011; digit_val = 4'hf; end // -
            3'd3: begin an_reg = 8'b1111_0111; digit_val = m_u; end
            3'd4: begin an_reg = 8'b1110_1111; digit_val = m_t; end
            3'd5: begin an_reg = 8'b1101_1111; digit_val = 4'hf; end // -
            3'd6: begin an_reg = 8'b1011_1111; digit_val = h_u; end
            3'd7: begin an_reg = 8'b0111_1111; digit_val = h_t; end
            // 下面这行之前由于写成了 8'ff 而报错，现已修复为 8'hff
            default: begin an_reg = 8'hff; digit_val = 0; end
        endcase
    end
    
    // 段码编码
    always @(*) begin
        case(digit_val)
            4'd0: seg_temp = 8'hc0; 4'd1: seg_temp = 8'hf9;
            4'd2: seg_temp = 8'ha4; 4'd3: seg_temp = 8'hb0;
            4'd4: seg_temp = 8'h99; 4'd5: seg_temp = 8'h92;
            4'd6: seg_temp = 8'h82; 4'd7: seg_temp = 8'hf8;
            4'd8: seg_temp = 8'h80; 4'd9: seg_temp = 8'h90;
            4'hf: seg_temp = 8'hbf; // -
            default: seg_temp = 8'hff;
        endcase
    end
    
    // ** 关键：位序翻转修复乱码 **
    assign SEG = {seg_temp[0], seg_temp[1], seg_temp[2], seg_temp[3], seg_temp[4], seg_temp[5], seg_temp[6], seg_temp[7]};
    assign AN  = an_reg;

    // ==========================================
    // 6. 闹钟报警与LED控制
    // ==========================================
    reg match;
    always @(posedge clk_100M) begin
        // 当时和分匹配时，alarm 触发
        if(hour == alarm_h && min == alarm_m)
            match <= 1;
        else
            match <= 0;
    end

    // 闹钟到时点亮所有LED
    assign LED = (match) ? 16'hFFFF : 16'h0000;

endmodule
