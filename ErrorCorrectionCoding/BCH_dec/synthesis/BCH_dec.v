// BCH_dec.v

// Generated using ACDS version 18.1 625

`timescale 1 ps / 1 ps
module BCH_dec (
		input  wire       clk,           // clk.clk
		input  wire       load,          //  in.valid
		output wire       ready,         //    .ready
		input  wire       sop_in,        //    .startofpacket
		input  wire       eop_in,        //    .endofpacket
		input  wire [7:0] data_in,       //    .data_in
		output wire       valid_out,     // out.valid
		input  wire       sink_ready,    //    .ready
		output wire       sop_out,       //    .startofpacket
		output wire       eop_out,       //    .endofpacket
		output wire [7:0] data_out,      //    .data_out
		output wire [7:0] number_errors, //    .number_errors
		input  wire       reset          // rst.reset
	);

	BCH_dec_bch_0 bch_0 (
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
