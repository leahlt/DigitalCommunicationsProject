module BCH_test;
	reg clk, reset;
	reg [7:0] data_in, data_enc, data_out;
	

	BCH_enc_ctrl #(24) encode(.clk(clk), .reset(reset), .data_in(data_in), .data_enc(data_enc));
	BCH_dec_ctrl #(24) decode(.clk(clk), .reset(reset), .data_in(data_enc), .data_dec(data_out));

	always begin
	clk = 1'b0; #5;
	clk = 1'b1; #5;
	end

	initial begin
	reset = 1'b0;

	data_in = 24'hABC_DEF; #50;
	$stop;
	end 
endmodule 
	