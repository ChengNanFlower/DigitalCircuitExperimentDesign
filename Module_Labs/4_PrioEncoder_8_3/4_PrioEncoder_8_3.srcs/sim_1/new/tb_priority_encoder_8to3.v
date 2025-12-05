`timescale 1ns / 1ps

//----------------------------------------------------------------------------------
// Module Name: tb_priority_encoder_8to3
// Description: Testbench for the 8-to-3 priority encoder (I[0] highest priority).
//----------------------------------------------------------------------------------
module tb_priority_encoder_8to3();

    // Inputs for the DUT (Device Under Test)
    reg           EN_n;
    reg  [7:0]    I;

    // Outputs from the DUT
    wire [2:0]    Y;
    wire          Done;

    // Instantiate the Device Under Test
    priority_encoder_8to3 uut (
        .EN_n(EN_n),
        .I(I),
        .Y(Y),
        .Done(Done)
    );

    // Stimulus generation block
    initial begin
        // 1. Initialize Inputs
        $display("======= Simulation Start (Priority: I[0] > I[7]) =======");
        EN_n = 1'b1; // Initially disabled
        I    = 8'b0000_0000;
        #10;

        // 2. Test Case: Disabled encoder
        $display("Test Case: Disabled (EN_n=1)");
        I = 8'b1111_1111;
        #10; // Expected: Y=000, Done=0

        // 3. Test Case: Enabled, but no input active
        $display("Test Case: Enabled, no active inputs");
        EN_n = 1'b0;
        I    = 8'b0000_0000;
        #10; // Expected: Y=000, Done=0

        // 4. Test each input individually (from highest to lowest priority)
        $display("Test Case: Individual inputs");
        I = 8'b0000_0001; #10; // I[0] -> Expected: Y=000, Done=1
        I = 8'b0000_0010; #10; // I[1] -> Expected: Y=001, Done=1
        I = 8'b0000_0100; #10; // I[2] -> Expected: Y=010, Done=1
        I = 8'b0000_1000; #10; // I[3] -> Expected: Y=011, Done=1
        I = 8'b0001_0000; #10; // I[4] -> Expected: Y=100, Done=1
        I = 8'b0010_0000; #10; // I[5] -> Expected: Y=101, Done=1
        I = 8'b0100_0000; #10; // I[6] -> Expected: Y=110, Done=1
        I = 8'b1000_0000; #10; // I[7] -> Expected: Y=111, Done=1

        // 5. Test priority logic (multiple inputs active)
        $display("Test Case: Priority check");
        I = 8'b1000_0001; #10; // I[0] and I[7] active -> I[0] wins. Expected: Y=000, Done=1
        I = 8'b0010_1000; #10; // I[3] and I[5] active -> I[3] wins. Expected: Y=011, Done=1
        I = 8'b1111_1111; #10; // All active -> I[0] wins. Expected: Y=000, Done=1

        // 6. End simulation
        $display("======= Simulation End =======");
        #20;
        $finish;
    end

endmodule
