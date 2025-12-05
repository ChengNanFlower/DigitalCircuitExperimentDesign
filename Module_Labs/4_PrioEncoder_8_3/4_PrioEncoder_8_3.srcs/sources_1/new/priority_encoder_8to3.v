//----------------------------------------------------------------------------------
// Module Name: priority_encoder_8to3
// Description: 8-to-3 Priority Encoder with active-low enable.
//              Priority: I[0] (highest) -> I[7] (lowest)
//----------------------------------------------------------------------------------
module priority_encoder_8to3(
    // Inputs
    input wire           EN_n,  // Active-low Enable signal
    input wire [7:0]     I,     // 8-bit data input, I[0] has highest priority

    // Outputs
    output reg [2:0]     Y,     // 3-bit encoded output
    output reg           Done   // Output valid signal
    );

    // Combinational logic block to determine the output based on inputs
    always @(*) begin
        // Default state: no valid input or module disabled
        Y = 3'b000;
        Done = 1'b0;

        // The encoder works only when EN_n is low (active)
        if (EN_n == 1'b0) begin
            // Check inputs from highest priority (I[0]) to lowest (I[7])
            if (I[0] == 1'b1) begin
                Y = 3'b000;
                Done = 1'b1;
            end
            else if (I[1] == 1'b1) begin
                Y = 3'b001;
                Done = 1'b1;
            end
            else if (I[2] == 1'b1) begin
                Y = 3'b010;
                Done = 1'b1;
            end
            else if (I[3] == 1'b1) begin
                Y = 3'b011;
                Done = 1'b1;
            end
            else if (I[4] == 1'b1) begin
                Y = 3'b100;
                Done = 1'b1;
            end
            else if (I[5] == 1'b1) begin
                Y = 3'b101;
                Done = 1'b1;
            end
            else if (I[6] == 1'b1) begin
                Y = 3'b110;
                Done = 1'b1;
            end
            else if (I[7] == 1'b1) begin
                Y = 3'b111;
                Done = 1'b1;
            end
            // If no input is '1', Done remains '0' and Y remains '000'
            else begin
                Y = 3'b000;
                Done = 1'b0;
            end
        end
        // If EN_n is high, the encoder is disabled. Outputs remain at default values.
    end

endmodule
