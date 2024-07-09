// Project: Summit
// Unit: top
//
// Wrapper for the adder to map to the targeted FPGA board.

module top(
    input wire[9:0] switches,
    input wire btn,
    output wire[5:0] leds
);

    // wrap the test
    adder u0(
        .input1(switches[9:5]),
        .input2(switches[4:0]),
        .carry_in(cin),
        .sum(leds[4:0]),
        .carry_out(leds[5])
    );

endmodule
