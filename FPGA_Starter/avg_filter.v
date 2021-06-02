module avg_FIR_filter(IN, CLK, READ, WRITE, OUT);
input signed [23:0] IN;
input CLK, READ, WRITE;
output [23:0] OUT;

wire signed [23:0] divider, fifo_out, add_out, accu_out, neg_fifo_out;


VariableDivider #(19) init(IN, divider); //set parameter to 19 for best filtering, turn down to 15 or below for poor filtering example

FIFO fifo(CLK, divider, READ, WRITE, fifo_out); //instansiate IP catalouge fifo module

assign neg_fifo_out = ~fifo_out +24'b000000_000000_000000_000001; //same as *-1 because we are just making it the two's complement

adder a1(neg_fifo_out, divider, add_out); //one adder

VariableFlipFlop f1(OUT, CLK, accu_out); //one D flip flop

adder a2(add_out, accu_out, OUT);

endmodule
