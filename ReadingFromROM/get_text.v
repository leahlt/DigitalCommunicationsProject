module get_text(clk, reset, data_out);
	input clk, reset;
	output [7:0] data_out;

	//internal signals
	reg [4:0] address = 5'b0; //initialize address

	parameter end_address = 5'hFF;

	always @ (posedge clk or posedge reset) begin 
		if (reset) address <= 5'b0;
		else if (address < end_address) address <= address + 1'b1;
		else address <= address; //avoid infered latches
	end 
	
	m_memory ROM(.clock(clk), .address(address), .q(data_out));
endmodule 