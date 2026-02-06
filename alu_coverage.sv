covergroup alu_cg @(posedge clk);

    
    coverpoint dut.op {
        bins add     = {4'b0000};
        bins sub     = {4'b0001};
        bins and_op  = {4'b0010};
        bins or_op   = {4'b0011};
        bins xor_op  = {4'b0100};
        bins shl_op  = {4'b0101};
        bins shr_op  = {4'b0110};
        bins eq_op   = {4'b0111};
        bins gt_op   = {4'b1000};
    }

    coverpoint dut.result {
        bins zero       = {8'h00};
        bins positive[] = {[1:127]};
        bins negative[] = {[128:255]};
    }

    // Cross: operation vs result category
    cross dut.op, dut.result;

    // Flags
    coverpoint dut.carry;
    coverpoint dut.zero;
    coverpoint dut.overflow;

endgroup

alu_cg cg = new();
