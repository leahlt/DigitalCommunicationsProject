  
module get_text(clk, reset, data_out, start_read, start_source);
	input clk, reset;
	output [7:0] data_out;
	input start_source;
	input start_read;
	//internal signals
	reg [7:0] address = 0; //initialize address

	parameter end_address = 15;

	always @ (posedge clk or posedge reset) begin 
		if (reset) address <= 0;
		else if (address < end_address && start_read) address <= address + 1'b1;
	end 
	wire [7:0] data_in;
	s_mem S(.address(address), .clock(clk), .data(data_in), .wren(0),  .q(data_out));
endmodule 