module BCH_enc_ctrl(clk, reset, data_in, data_enc);
	parameter N = 8;
	input clk, reset;
	input [N-1:0] data_in;
	output reg [N-1:0] data_enc;

	wire ready, valid_out, sop_out, eop_out, load, sop_in, eop_in, sink_ready;
	wire [N-1:0] data_out;

	assign sink_ready = 1'b1; //always want forward pressure

	parameter WAIT = 5'b00_000;
	parameter ASSERT_LOAD = 5'b01_011;
	parameter PACKET_END = 5'b10_100;

	reg [4:0] state = WAIT; //initialize state

	//control signals driven by state bits
	assign load = state[0];
	assign sop_in = state[1];
	assign eop_in = state[2];

	//output
	always @ (posedge clk)
		if (valid_out) data_enc <= data_out;
		else data_enc <= data_enc; 

	//state transitions
	always @ (posedge clk or posedge reset) begin
		if (reset) state <= WAIT;
		else begin
		case (state) 
			WAIT: if (ready) state <= ASSERT_LOAD;
			      else state <= WAIT;
			ASSERT_LOAD: state <= PACKET_END;
			PACKET_END: state <= WAIT;
			default: state <= WAIT;
		endcase
		end
	end

	BCH_enc_24 u0 (
		.clk        (clk),        // clk.clk
		.reset      (reset),      // rst.reset
		.load       (load),       //  in.valid
		.ready      (ready),      //    .ready
		.sop_in     (sop_in),     //    .startofpacket
		.eop_in     (eop_in),     //    .endofpacket
		.data_in    (data_in),    //    .data_in
		.valid_out  (valid_out),  // out.valid
		.sink_ready (sink_ready), //    .ready
		.sop_out    (sop_out),    //    .startofpacket
		.eop_out    (eop_out),    //    .endofpacket
		.data_out   (data_out)    //    .data_out
	);

endmodule 

module BCH_dec_ctrl(clk, reset, data_in, data_dec);
	parameter N = 8;
	input clk, reset;
	input [N-1:0] data_in;
	output reg [N-1:0] data_dec;

	wire ready, valid_out, sop_out, eop_out, load, sop_in, eop_in, sink_ready;
	wire [N-1:0] data_out;

	assign sink_ready = 1'b1; //always want forward pressure

	parameter WAIT = 5'b00_000;
	parameter ASSERT_LOAD = 5'b01_011;
	parameter PACKET_END = 5'b10_100;

	reg [4:0] state = WAIT; //initialize state

	//control signals driven by state bits
	assign load = state[0];
	assign sop_in = state[1];
	assign eop_in = state[2];

	//output
	always @ (posedge clk)
		if (valid_out) data_dec <= data_out;
		else data_dec <= data_dec; 

	//state transitions
	always @ (posedge clk or posedge reset) begin
		if (reset) state <= WAIT;
		else begin
		case (state) 
			WAIT: if (ready) state <= ASSERT_LOAD;
			      else state <= WAIT;
			ASSERT_LOAD: state <= PACKET_END;
			PACKET_END: state <= WAIT;
			default: state <= WAIT;
		endcase
		end
	end
	

		BCH_dec_24 u0 (
		.clk           (clk),           // clk.clk
		.reset         (reset),         // rst.reset
		.load          (load),          //  in.valid
		.ready         (ready),         //    .ready
		.sop_in        (sop_in),        //    .startofpacket
		.eop_in        (eop_in),        //    .endofpacket
		.data_in       (data_in),       //    .data_in
		.valid_out     (valid_out),     // out.valid
		.sink_ready    (sink_ready),    //    .ready
		.sop_out       (sop_out),       //    .startofpacket
		.eop_out       (eop_out),       //    .endofpacket
		.data_out      (data_out),      //    .data_out
		.number_errors (number_errors)  //    .number_errors
	);
endmodule 