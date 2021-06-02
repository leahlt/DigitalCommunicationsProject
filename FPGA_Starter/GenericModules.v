//Flip Flop module from CPEN 311 notes, slide set 2, page 35

module VariableFlipFlop (D, CLK, Q);
parameter n = 24; //default input bits
input signed [n-1:0] D; 
input CLK;
output reg signed [n-1:0] Q;

	
always @(posedge CLK)
	Q <= D;

endmodule



//Divide module

module VariableDivider (IN, OUT); 
parameter n=3; //default shift number divides by 8
input signed [23:0] IN;
output signed [23:0] OUT;

assign OUT = IN>>n; //shift by n to the right (which is actually divide by 2^n)
endmodule



//Adder Module
module adder (IN,ADD,OUT);
parameter n=24; //default input bits
input signed [n-1:0] IN, ADD;
output signed [n-1:0] OUT;

assign OUT = IN + ADD; //add

endmodule

