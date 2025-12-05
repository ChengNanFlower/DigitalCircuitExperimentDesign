`timescale 1ns / 1ps

module Rev_Counter_4bit(
    input wire CLK,         // 时钟输入
    input wire CLR,         // 异步清零端 (高电平有效)
    input wire LD,          // 加载信号 (低电平有效)
    input wire U_D,         // 上/下计数控制 (高电平=下计数, 低电平=上计数)
    input wire [3:0] D,     // 4位并行数据输入
    output wire [3:0] Q,    // 4位计数输出
    output wire MAX_MIN,    // 最大/最小值指示信号
    output wire RCO         // 进位输出
    );
    
    // 内部寄存器存储
    reg [3:0] count_reg;
    
    // 异步清零、加载和计数控制
    always @(posedge CLK or posedge CLR) begin
        if (CLR) begin
            count_reg <= 4'b0000;  // 异步清零
        end
        else if (!LD) begin
            count_reg <= D;        // 并行加载数据
        end
        else begin
            // 根据U/D信号进行上/下计数
            if (!U_D) begin
                // 上计数 (0->1->2->...->15->0)
                if (count_reg == 4'b1111) 
                    count_reg <= 4'b0000;
                else 
                    count_reg <= count_reg + 1;
            end
            else begin
                // 下计数 (15->14->13->...->0->15)
                if (count_reg == 4'b0000) 
                    count_reg <= 4'b1111;
                else 
                    count_reg <= count_reg - 1;
            end
        end
    end
    
    // 输出连接
    assign Q = count_reg;
    
    // MAX/MIN信号：当计数值为15(最大)时为高电平，为0(最小)时为低电平
    assign MAX_MIN = (count_reg == 4'b1111);
    
    // RCO进位输出：在特定条件下产生进位
    // 对于上计数，当计数值为15且下一个时钟周期将变为0时产生进位
    // 对于下计数，当计数值为0且下一个时钟周期将变为15时产生借位
    assign RCO = (!U_D && (count_reg == 4'b1111)) || (U_D && (count_reg == 4'b0000));

endmodule