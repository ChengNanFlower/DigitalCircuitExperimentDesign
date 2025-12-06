module led_ctrl(
    input wire clk,          // 接收分频后的慢时钟
    input wire rst,
    input wire [1:0] sw,     // 模式开关
    output reg [15:0] led
);
    
    reg [1:0] sw_old;        // 用于检测开关是否变化

    always @(posedge clk or posedge rst) begin
        if(rst) begin
            led <= 16'h8000;
            sw_old <= sw;
        end else begin
            // 检测开关状态是否改变，如果改变则重置初值
            if(sw != sw_old) begin
                sw_old <= sw;
                case(sw)
                    2'b00: led <= 16'h8000; // 模式0初始值
                    2'b01: led <= 16'h0001; // 模式1初始值
                    2'b10: led <= 16'h0180; // 模式2初始值
                    2'b11: led <= 16'h8001; // 模式3初始值
                endcase
            end else begin
                // 如果开关未变，执行移位逻辑
                case(sw)
                    2'b00: led <= {led[0], led[15:1]};         // 循环右移 (从左到右亮)
                    2'b01: led <= {led[14:0], led[15]};         // 循环左移 (从右到左亮)
                    2'b10: led <= {led[14:8], led[15], led[0], led[7:1]}; // 中间向两边 (高8左移，低8右移)
                    2'b11: led <= {led[8], led[15:9], led[6:0], led[7]};   // 两边向中间 (高8右移，低8左移)
                endcase
            end
        end
    end
endmodule
