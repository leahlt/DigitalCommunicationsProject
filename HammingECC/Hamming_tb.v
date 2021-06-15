`timescale 1 ps / 1 ps
module Hamming_tb;
	wire err_corrected, err_detected, err_fatal;
	reg [6:0] data_in;
	wire [11:0] data_enc, data_dec;
	
	HammingIP_Enc
	encode( 
	.data(data_in),
	.q(data_enc)
	);

	HammingIP_Dec
	decode( 
	.data(data_enc),
	.err_corrected(err_corrected),
	.err_detected(err_corrected),
	.err_fatal(err_fatal),
	.q(data_dec) 
	);
	
	initial begin
	data_in = 7'b100_0011;
	#5;
	data_in = 7'b111_0000;
	#5;
	data_in = 7'b101_0100;
	#5;
	$stop;
	end
endmodule
