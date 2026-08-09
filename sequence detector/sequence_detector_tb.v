//====================================================
// Testbench for 1011 Sequence Detector
// File: sequence_detector_tb.v
//====================================================

`timescale 1ns/1ps

module sequence_detector_tb;

    reg clk;
    reg reset;
    reg din;

    wire detected;

    integer errors;

    // Instantiate DUT
    sequence_detector DUT (
        .clk(clk),
        .reset(reset),
        .din(din),
        .detected(detected)
    );

    // Clock generation
    always #5 clk = ~clk;

    //================================================
    // Send one bit and check output
    //================================================

    task send_bit;
        input bit_value;
        input expected_output;

        begin

            din = bit_value;

            @(posedge clk);
            #1;

            if (detected !== expected_output) begin

                $display(
                    "FAIL: Time=%0t Input=%b Expected=%b Actual=%b",
                    $time,
                    bit_value,
                    expected_output,
                    detected
                );

                errors = errors + 1;

            end
            else begin

                $display(
                    "PASS: Time=%0t Input=%b Expected=%b Actual=%b",
                    $time,
                    bit_value,
                    expected_output,
                    detected
                );

            end

        end
    endtask

    //================================================
    // Main Test
    //================================================

    initial begin

        errors = 0;

        clk   = 1'b0;
        reset = 1'b1;
        din   = 1'b0;

        // Generate waveform
        $dumpfile("sequence_detector.vcd");
        $dumpvars(0, sequence_detector_tb);

        $display("========================================");
        $display("       1011 SEQUENCE DETECTOR");
        $display("========================================");

        // Reset
        @(posedge clk);
        #1;

        reset = 1'b0;

        //================================================
        // Test 1: Detect 1011
        //================================================

        $display("----------------------------------------");
        $display("TEST 1: Detect 1011");

        send_bit(1'b1, 1'b0);
        send_bit(1'b0, 1'b0);
        send_bit(1'b1, 1'b0);
        send_bit(1'b1, 1'b1);

        //================================================
        // Test 2: No complete sequence
        //================================================

        $display("----------------------------------------");
        $display("TEST 2: No sequence");

        reset = 1'b1;
        @(posedge clk);
        #1;
        reset = 1'b0;

        send_bit(1'b1, 1'b0);
        send_bit(1'b0, 1'b0);
        send_bit(1'b0, 1'b0);
        send_bit(1'b1, 1'b0);

        //================================================
        // Test 3: Overlapping detection
        // Input: 1011011
        //================================================

        $display("----------------------------------------");
        $display("TEST 3: Overlapping sequence 1011011");

        reset = 1'b1;
        @(posedge clk);
        #1;
        reset = 1'b0;

        send_bit(1'b1, 1'b0);
        send_bit(1'b0, 1'b0);
        send_bit(1'b1, 1'b0);
        send_bit(1'b1, 1'b1);

        send_bit(1'b0, 1'b0);
        send_bit(1'b1, 1'b0);
        send_bit(1'b1, 1'b1);

        //================================================
        // Final result
        //================================================

        $display("========================================");

        if (errors == 0)
            $display("ALL TEST CASES PASSED!");
        else
            $display("TEST FAILED: %0d ERROR(S)", errors);

        $display("========================================");

        $finish;

    end

endmodule