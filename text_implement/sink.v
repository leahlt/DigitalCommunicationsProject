module sink(clk, reset, data_in);
	input clk, reset;
	input [7:0] data_in;

	//internal signals
	reg [7:0] address = 0; //initialize address

	parameter end_address = 255;

	always @ (posedge clk or posedge reset) begin 
		if (reset) address <= 0;
		else if (address < end_address) address <= address + 1'b1;
		else address <= address; //avoid infered latches
	end 
	wire [7:0] data_out;
	ram sink_mem(.address(address), .clock(clk), .data(data_in), .wren(1),  .q(data_out));
endmodule 