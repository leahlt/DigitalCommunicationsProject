module BPSK (DataIn, DataOut, CLK, Flag);
parameter n=12; //default value is set for hamming, not BCH which needs 15 bits in
input [n-1:0] DataIn;
input CLK, Flag;
output reg [n-1:0] DataOut;

always @ (posedge CLK) begin
	case(Flag)
		0: DataOut <= DataIn; //If the flag is 0 set the output to the inverse of the input
		//~ is the bitwise not operation
		1: DataOut <= ~DataIn; //use nonblocking assignment because this is a sequential logic blck

		default: DataOut = {n{1'bx}}; //should be able to verify any problems in modelsim like this

	endcase
end

endmodule
 