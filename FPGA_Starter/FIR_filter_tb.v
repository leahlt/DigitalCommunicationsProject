module flipFlop_tb();

reg [23:0] D;
reg CLK;
wire [23:0] Q;

VariableFlipFlop #(24) dut(D, CLK, Q);


initial forever begin
	   CLK = 0; 
		#10
		CLK = 1;
		#10;
end 

initial begin


$display("Starting Flip Flop testbench test...");

D <= 24'b 000000_000000_000000_000000; //0 input
#50;
D <= 24'b 111111_111111_111111_111111; //1 input
#50;
D <= 24'b 000000_000000_000000_000000; //0 input
#50;
D <= 24'b 111111_111111_111111_111111; //1 input
#50;

//expected output, output (Q) follows the input after one clock cycle.
end


endmodule


module Divider_tb();

reg [23:0] IN;
wire [23:0] OUT;

VariableDivider #(24) dut(IN, OUT);


initial begin


$display("Starting Divider testbench test...");

IN <= 24'b 111000_000000_000000_000101; //0 input, expecting 000111_000000_000000_000000 output
#50;


end

endmodule


module adder_tb();

reg [23:0] IN, ADD;
wire [23:0] OUT;

adder #(24) dut(IN, ADD, OUT);


initial begin


$display("Starting adder testbench test...");

IN <= 24'b 000000_000000_000000_000011;
ADD <= 24'b 000000_000000_000000_000001; //expecting ...100
#50;


end

endmodule

module filter_tb();
reg [23:0] IN;
reg CLK;
wire [23:0] OUT;

FIRfilter dut(IN, CLK, OUT);

initial forever begin
	   CLK = 0; 
		#10;
		CLK = 1;
		#10;
end 

initial begin


$display("Starting filter testbench test...");

IN <= 8;
#200;
IN <= 16;
end

//expecting the output to reflect the moving average after 7 clock cycles (out=8 after 8 cycles, then 9, 10, 11, etc. every clock cycle until 16 is reached)

endmodule


/*
module avg_tb();
reg [23:0] IN;
reg write, read;
reg CLK;
wire [23:0] OUT;

avg_FIR_filter dut(IN, CLK, read, write, OUT);

initial forever begin
		CLK = 0; 
		#10;
		CLK = 1;
		#10;
		read <=0;
		write<=1;
end 

initial begin


$display("Starting part 3 avg_filter testbench test...");

IN <= 8;
#200;
IN <= 16;
end


endmodule

*/

