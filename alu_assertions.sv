// ADD overflow rule

property add_overflow_correct;
    @(posedge clk)
    (dut.op == 4'b0000) |-> 
    (dut.overflow == 
        ((dut.a[7] & dut.b[7] & ~dut.result[7]) |
         (~dut.a[7] & ~dut.b[7] & dut.result[7])));
endproperty
assert property(add_overflow_correct)
    else $error("ADD overflow incorrect!");

// ZERO flag correctness

property zero_flag_check;
    @(posedge clk)
    dut.zero == (dut.result == 8'h00);
endproperty
assert property(zero_flag_check)
    else $error("Zero flag incorrect!");


// Logic ops must NOT assert carry

property logic_no_carry;
    @(posedge clk)
    (dut.op inside {4'b0010,4'b0011,4'b0100}) |-> (dut.carry == 0);
endproperty
assert property(logic_no_carry)
    else $error("Carry asserted during logic operation!");


// SUB should set borrow (carry=1 when a<b)

property sub_borrow_check;
    @(posedge clk)
    (dut.op == 4'b0001) |-> (dut.carry == (dut.a < dut.b));
endproperty
assert property(sub_borrow_check)
    else $error("SUB borrow logic incorrect!");

