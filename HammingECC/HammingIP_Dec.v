// megafunction wizard: %ALTECC%
// GENERATION: STANDARD
// VERSION: WM1.0
// MODULE: altecc_decoder 

// ============================================================
// File Name: HammingIP_Dec.v
// Megafunction Name(s):
// 			altecc_decoder
//
// Simulation Library Files(s):
// 			lpm
// ============================================================
// ************************************************************
// THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
//
// 18.1.0 Build 625 09/12/2018 SJ Lite Edition
// ************************************************************


//Copyright (C) 2018  Intel Corporation. All rights reserved.
//Your use of Intel Corporation's design tools, logic functions 
//and other software and tools, and its AMPP partner logic 
//functions, and any output files from any of the foregoing 
//(including device programming or simulation files), and any 
//associated documentation or information are expressly subject 
//to the terms and conditions of the Intel Program License 
//Subscription Agreement, the Intel Quartus Prime License Agreement,
//the Intel FPGA IP License Agreement, or other applicable license
//agreement, including, without limitation, that your use is for
//the sole purpose of programming logic devices manufactured by
//Intel and sold by Intel or its authorized distributors.  Please
//refer to the applicable agreement for further details.


//altecc_decoder CBX_AUTO_BLACKBOX="ALL" device_family="Cyclone V" lpm_pipeline=0 width_codeword=12 width_dataword=7 data err_corrected err_detected err_fatal q
//VERSION_BEGIN 18.1 cbx_altecc_decoder 2018:09:12:13:04:24:SJ cbx_cycloneii 2018:09:12:13:04:24:SJ cbx_lpm_add_sub 2018:09:12:13:04:24:SJ cbx_lpm_compare 2018:09:12:13:04:24:SJ cbx_lpm_decode 2018:09:12:13:04:24:SJ cbx_mgl 2018:09:12:13:10:36:SJ cbx_nadder 2018:09:12:13:04:24:SJ cbx_stratix 2018:09:12:13:04:24:SJ cbx_stratixii 2018:09:12:13:04:24:SJ  VERSION_END
// synthesis VERILOG_INPUT_VERSION VERILOG_2001
// altera message_off 10463


//synthesis_resources = lpm_decode 1 mux21 7 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module  HammingIP_Dec_altecc_decoder_soe
	( 
	data,
	err_corrected,
	err_detected,
	err_fatal,
	q) ;
	input   [11:0]  data;
	output   err_corrected;
	output   err_detected;
	output   err_fatal;
	output   [6:0]  q;

	wire  [15:0]   wire_error_bit_decoder_eq;
	wire	wire_mux21_0_dataout;
	wire	wire_mux21_1_dataout;
	wire	wire_mux21_2_dataout;
	wire	wire_mux21_3_dataout;
	wire	wire_mux21_4_dataout;
	wire	wire_mux21_5_dataout;
	wire	wire_mux21_6_dataout;
	wire  data_bit;
	wire  [6:0]  data_t;
	wire  [11:0]  data_wire;
	wire  [15:0]  decode_output;
	wire  err_corrected_wire;
	wire  err_detected_wire;
	wire  err_fatal_wire;
	wire  [5:0]  parity_01_wire;
	wire  [2:0]  parity_02_wire;
	wire  [0:0]  parity_03_wire;
	wire  [0:0]  parity_04_wire;
	wire  parity_bit;
	wire  [10:0]  parity_final_wire;
	wire  [3:0]  parity_t;
	wire  [6:0]  q_wire;
	wire  syn_bit;
	wire  syn_e_int;
	wire  [2:0]  syn_t;
	wire  [4:0]  syndrome;

	lpm_decode   error_bit_decoder
	( 
	.data(syndrome[3:0]),
	.eq(wire_error_bit_decoder_eq)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.aclr(1'b0),
	.clken(1'b1),
	.clock(1'b0),
	.enable(1'b1)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	);
	
	defparam
		error_bit_decoder.lpm_decodes = 16,
		error_bit_decoder.lpm_width = 4,
		error_bit_decoder.lpm_type = "lpm_decode";
	assign		wire_mux21_0_dataout = (syndrome[4] === 1'b1) ? (decode_output[3] ^ data_wire[0]) : data_wire[0];
	assign		wire_mux21_1_dataout = (syndrome[4] === 1'b1) ? (decode_output[5] ^ data_wire[1]) : data_wire[1];
	assign		wire_mux21_2_dataout = (syndrome[4] === 1'b1) ? (decode_output[6] ^ data_wire[2]) : data_wire[2];
	assign		wire_mux21_3_dataout = (syndrome[4] === 1'b1) ? (decode_output[7] ^ data_wire[3]) : data_wire[3];
	assign		wire_mux21_4_dataout = (syndrome[4] === 1'b1) ? (decode_output[9] ^ data_wire[4]) : data_wire[4];
	assign		wire_mux21_5_dataout = (syndrome[4] === 1'b1) ? (decode_output[10] ^ data_wire[5]) : data_wire[5];
	assign		wire_mux21_6_dataout = (syndrome[4] === 1'b1) ? (decode_output[11] ^ data_wire[6]) : data_wire[6];
	assign
		data_bit = data_t[6],
		data_t = {(data_t[5] | decode_output[11]), (data_t[4] | decode_output[10]), (data_t[3] | decode_output[9]), (data_t[2] | decode_output[7]), (data_t[1] | decode_output[6]), (data_t[0] | decode_output[5]), decode_output[3]},
		data_wire = data,
		decode_output = wire_error_bit_decoder_eq,
		err_corrected = err_corrected_wire,
		err_corrected_wire = ((syn_bit & syn_e_int) & data_bit),
		err_detected = err_detected_wire,
		err_detected_wire = (syn_bit & (~ (syn_e_int & parity_bit))),
		err_fatal = err_fatal_wire,
		err_fatal_wire = (err_detected_wire & (~ err_corrected_wire)),
		parity_01_wire = {(data_wire[6] ^ parity_01_wire[4]), (data_wire[4] ^ parity_01_wire[3]), (data_wire[3] ^ parity_01_wire[2]), (data_wire[1] ^ parity_01_wire[1]), (data_wire[0] ^ parity_01_wire[0]), data_wire[7]},
		parity_02_wire = {((data_wire[5] ^ data_wire[6]) ^ parity_02_wire[1]), ((data_wire[2] ^ data_wire[3]) ^ parity_02_wire[0]), (data_wire[8] ^ data_wire[0])},
		parity_03_wire = {(((data_wire[9] ^ data_wire[1]) ^ data_wire[2]) ^ data_wire[3])},
		parity_04_wire = {(((data_wire[10] ^ data_wire[4]) ^ data_wire[5]) ^ data_wire[6])},
		parity_bit = parity_t[3],
		parity_final_wire = {(data_wire[10] ^ parity_final_wire[9]), (data_wire[9] ^ parity_final_wire[8]), (data_wire[8] ^ parity_final_wire[7]), (data_wire[7] ^ parity_final_wire[6]), (data_wire[6] ^ parity_final_wire[5]), (data_wire[5] ^ parity_final_wire[4]), (data_wire[4] ^ parity_final_wire[3]), (data_wire[3] ^ parity_final_wire[2]), (data_wire[2] ^ parity_final_wire[1]), (data_wire[1] ^ parity_final_wire[0]), (data_wire[11] ^ data_wire[0])},
		parity_t = {(parity_t[2] | decode_output[8]), (parity_t[1] | decode_output[4]), (parity_t[0] | decode_output[2]), decode_output[1]},
		q = q_wire,
		q_wire = {wire_mux21_6_dataout, wire_mux21_5_dataout, wire_mux21_4_dataout, wire_mux21_3_dataout, wire_mux21_2_dataout, wire_mux21_1_dataout, wire_mux21_0_dataout},
		syn_bit = syn_t[2],
		syn_e_int = syndrome[4],
		syn_t = {(syn_t[1] | syndrome[3]), (syn_t[0] | syndrome[2]), (syndrome[0] | syndrome[1])},
		syndrome = {parity_final_wire[10], parity_04_wire[0], parity_03_wire[0], parity_02_wire[2], parity_01_wire[5]};
endmodule //HammingIP_Dec_altecc_decoder_soe
//VALID FILE


// synopsys translate_off
`timescale 1 ps / 1 ps
// synopsys translate_on
module HammingIP_Dec (
	data,
	err_corrected,
	err_detected,
	err_fatal,
	q);

	input	[11:0]  data;
	output	  err_corrected;
	output	  err_detected;
	output	  err_fatal;
	output	[6:0]  q;

	wire  sub_wire0;
	wire  sub_wire1;
	wire  sub_wire2;
	wire [6:0] sub_wire3;
	wire  err_corrected = sub_wire0;
	wire  err_detected = sub_wire1;
	wire  err_fatal = sub_wire2;
	wire [6:0] q = sub_wire3[6:0];

	HammingIP_Dec_altecc_decoder_soe	HammingIP_Dec_altecc_decoder_soe_component (
				.data (data),
				.err_corrected (sub_wire0),
				.err_detected (sub_wire1),
				.err_fatal (sub_wire2),
				.q (sub_wire3));

endmodule

// ============================================================
// CNX file retrieval info
// ============================================================
// Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "Cyclone V"
// Retrieval info: PRIVATE: SYNTH_WRAPPER_GEN_POSTFIX STRING "0"
// Retrieval info: LIBRARY: altera_mf altera_mf.altera_mf_components.all
// Retrieval info: CONSTANT: INTENDED_DEVICE_FAMILY STRING "Cyclone V"
// Retrieval info: CONSTANT: lpm_pipeline NUMERIC "0"
// Retrieval info: CONSTANT: width_codeword NUMERIC "12"
// Retrieval info: CONSTANT: width_dataword NUMERIC "7"
// Retrieval info: USED_PORT: data 0 0 12 0 INPUT NODEFVAL "data[11..0]"
// Retrieval info: USED_PORT: err_corrected 0 0 0 0 OUTPUT NODEFVAL "err_corrected"
// Retrieval info: USED_PORT: err_detected 0 0 0 0 OUTPUT NODEFVAL "err_detected"
// Retrieval info: USED_PORT: err_fatal 0 0 0 0 OUTPUT NODEFVAL "err_fatal"
// Retrieval info: USED_PORT: q 0 0 7 0 OUTPUT NODEFVAL "q[6..0]"
// Retrieval info: CONNECT: @data 0 0 12 0 data 0 0 12 0
// Retrieval info: CONNECT: err_corrected 0 0 0 0 @err_corrected 0 0 0 0
// Retrieval info: CONNECT: err_detected 0 0 0 0 @err_detected 0 0 0 0
// Retrieval info: CONNECT: err_fatal 0 0 0 0 @err_fatal 0 0 0 0
// Retrieval info: CONNECT: q 0 0 7 0 @q 0 0 7 0
// Retrieval info: GEN_FILE: TYPE_NORMAL HammingIP_Dec.v TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL HammingIP_Dec.inc FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL HammingIP_Dec.cmp FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL HammingIP_Dec.bsf FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL HammingIP_Dec_inst.v FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL HammingIP_Dec_bb.v TRUE
// Retrieval info: LIB_FILE: lpm
