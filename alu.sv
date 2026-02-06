module alu (
    input  logic [7:0] a,
    input  logic [7:0] b,
    input  logic [3:0] op,     // operation select
    output logic [7:0] result,
    output logic carry,
    output logic zero,
    output logic overflow
);

    logic [8:0] temp; // for carry & overflow detection

    always_comb begin
        result   = 8'h00;
        carry    = 0;
        overflow = 0;

        unique case (op)

            4'b0000: begin                     // ADD
                temp   = a + b;
                result = temp[7:0];
                carry  = temp[8];
                overflow = (a[7] & b[7] & ~result[7]) |
                           (~a[7] & ~b[7] & result[7]);
            end

            4'b0001: begin                     // SUB
                temp   = a - b;
                result = temp[7:0];
                carry  = temp[8];
                overflow = (a[7] & ~b[7] & ~result[7]) |
                           (~a[7] & b[7] & result[7]);
            end

            4'b0010:  result = a & b;          // AND
            4'b0011:  result = a | b;          // OR
            4'b0100:  result = a ^ b;          // XOR
            4'b0101:  result = a << 1;         // Shift Left
            4'b0110:  result = a >> 1;         // Shift Right

            4'b0111: begin                     // Compare Equal
                result = (a == b) ? 8'h01 : 8'h00;
            end

            4'b1000: begin                     // Compare Greater
                result = (a > b) ? 8'h01 : 8'h00;
            end

            default: result = 8'h00;

        endcase
    end

    assign zero = (result == 8'h00);

endmodule
