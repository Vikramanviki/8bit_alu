`timescale 1ns/1ps

module alu_tb;

    logic [7:0] a, b;
    logic [3:0] op;
    logic [7:0] result;
    logic carry, zero, overflow;

    // DUT
    alu dut (
        .a(a),
        .b(b),
        .op(op),
        .result(result),
        .carry(carry),
        .zero(zero),
        .overflow(overflow)
    );

    // Task to display test results
    task run_test(input [7:0] ta, tb, input [3:0] top);
        begin
            a = ta;
            b = tb;
            op = top;
            #5;

            $display("A=%0d, B=%0d, OP=%b -> RESULT=%0d, C=%b, Z=%b, OV=%b",
                     a, b, op, result, carry, zero, overflow);
        end
    endtask

    // Test sequence
    initial begin
        $dumpfile("alu.vcd");
        $dumpvars(0, alu_tb);

        // Arithmetic
        run_test(10, 20, 4'b0000); // ADD
        run_test(40, 10, 4'b0001); // SUB

        // Logic
        run_test(8'hAA, 8'h55, 4'b0010); // AND
        run_test(8'hAA, 8'h0F, 4'b0011); // OR
        run_test(8'hF0, 8'h0F, 4'b0100); // XOR

        // Shifts
        run_test(8'h12, 0, 4'b0101); // SHL
        run_test(8'h80, 0, 4'b0110); // SHR

        // Compare
        run_test(20, 20, 4'b0111); // EQUAL
        run_test(30, 10, 4'b1000); // GREATER

        $display("All tests completed!");
        $finish;
    end

endmodule
