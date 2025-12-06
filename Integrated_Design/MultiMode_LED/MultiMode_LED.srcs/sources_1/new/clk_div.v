module clk_div #(
    parameter CNT_MAX = 25_000_000/2 - 1  // 100MHz / 4Hz / 2 = 12.5M
)(
    input wire clk_in,   // 100MHz
    input wire rst,      // 复位
    output reg clk_out   // 输出低频时钟
);

    reg [24:0] cnt;

    always @(posedge clk_in or posedge rst) begin
        if(rst) begin
            cnt <= 0;
            clk_out <= 0;
        end else begin
            if(cnt >= CNT_MAX) begin
                cnt <= 0;
                clk_out <= ~clk_out; // 翻转产生方波
            end else begin
                cnt <= cnt + 1;
            end
        end
    end
endmodule
