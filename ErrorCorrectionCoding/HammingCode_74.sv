//code found from: https://vlsicoding.blogspot.com/2017/06/verilog-code-for-74-systematic-hamming-encoder.html
//this code adds 3 parity bits to data_in
module hamming_encoder_74(data_in, data_out)
	input [3:0] data_in;
	output [6:0] data_out;

	wire p0, p1, p2;

	//assigning parity bits
	assign p0 = data_in[0] ^ data_in[1] ^ data_in[2];
	assign p1 = data_in[0] ^ data_in[2] ^ data_in[3];
	assign p2 = data_in[1] ^ data_in[2] ^ data_in[3];
	
	assign data_out = {data_in, p0,p1,p2};
endmodule 

module hamming_decoder_74(data_in, data_out);
	input [6:0] data_in;
	output [3:0] data_out;

endmodule 