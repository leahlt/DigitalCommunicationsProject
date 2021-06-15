module Modulator_tb ();

reg [11:0] in;

wire [11:0] out;

topTest dut(in, out);



initial begin


$display("Starting BPSK Modulator testbench test...");

in <= 12'b 1111_0000_0011; //0 input
#10;
in <= 12'b 0000_0000_0000; //0 input
#10;
in <= 12'b 0101_1111_0000; //0 input
#10;
in <= 12'b 1111_1111_1111; //0 input
#10;


end


endmodule
