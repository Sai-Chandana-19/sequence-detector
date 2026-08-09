//====================================================
// 1011 Sequence Detector
// Overlapping Sequence Detector
// File: sequence_detector.v
//====================================================

module sequence_detector (
    input  wire clk,
    input  wire reset,
    input  wire din,
    output reg  detected
);

    // State definitions
    parameter S0 = 3'b000;
    parameter S1 = 3'b001;
    parameter S2 = 3'b010;
    parameter S3 = 3'b011;
    parameter S4 = 3'b100;

    reg [2:0] current_state;
    reg [2:0] next_state;

    //================================================
    // State Register
    //================================================

    always @(posedge clk) begin
        if (reset)
            current_state <= S0;
        else
            current_state <= next_state;
    end

    //================================================
    // Next State Logic
    //================================================

    always @(*) begin

        case (current_state)

            S0: begin
                if (din)
                    next_state = S1;
                else
                    next_state = S0;
            end

            S1: begin
                if (din)
                    next_state = S1;
                else
                    next_state = S2;
            end

            S2: begin
                if (din)
                    next_state = S3;
                else
                    next_state = S0;
            end

            S3: begin
                if (din)
                    next_state = S4;
                else
                    next_state = S2;
            end

            S4: begin
                if (din)
                    next_state = S1;
                else
                    next_state = S2;
            end

            default:
                next_state = S0;

        endcase

    end

    //================================================
    // Output Logic
    //================================================

    always @(*) begin

        if (current_state == S4)
            detected = 1'b1;
        else
            detected = 1'b0;

    end

endmodule