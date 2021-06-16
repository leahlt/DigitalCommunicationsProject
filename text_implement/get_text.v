  
module get_text(clk, reset, data_out, start_source);
	input clk, reset;
	output [7:0] data_out;
	input start_source;
	//internal signals
	reg [7:0] address = 0; //initialize address

	parameter end_address = 10;

	always @ (posedge clk or posedge reset) begin 
		if (reset) address <= 0;
		else if (address < end_address) address <= address + 1'b1;
		else address <= address; //avoid infered latches
	end 
	wire [7:0] data_in;
	ram mem(.address(address), .clock(clk), .data(data_in), .wren(0),  .q(data_out));
endmodule 