module Modulator_tb ();

reg [6:0] in;
reg CLK, Flag;
wire [6:0] out;

BPSK #(7) dut(in, out, CLK, Flag);


initial forever begin
	   CLK = 0; 
		#10
		CLK = 1;
		#10;
end 

initial begin


$display("Starting BPSK Modulator testbench test...");

in <= 7'b 0000_010; //0 input
Flag <= 1;
#7
Flag <= 0;
#7
Flag <= 1;
#7
Flag <= 0;
#7
Flag <= 1;
#7
Flag <= 0;
#7
in <= 7'b 1111_111; //1 input
Flag <= 1;
#7
Flag <= 0;
#7
Flag <= 1;
#7
Flag <= 0;
#7
Flag <= 1;
#7
Flag <= 0;
#7;

end


endmodule
