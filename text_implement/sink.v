module sink(clk, reset, data_in, start_sink);
	input clk, reset;
	input [7:0] data_in;
	input start_sink;
	//internal signals
	reg [7:0] address = 0; //initialize address
	integer counter = 0;
	parameter end_address = 10;

	always @ (posedge clk or posedge reset) begin 
		if (reset) begin 
			address <= 0;
			counter = 0;
		end

		else if (counter >2 && address < end_address) begin
			address <= address + 1'b1;
		end
		else counter = counter + 1;

	end 
	wire [7:0] data_out;
	ram sink_mem(.address(address), .clock(clk), .data(data_in), .wren(1),  .q(data_out));
endmodule 