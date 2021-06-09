// megafunction wizard: %FIFO%
// GENERATION: STANDARD
// VERSION: WM1.0
// MODULE: scfifo 

// ============================================================
// File Name: ram2.v
// Megafunction Name(s):
// 			scfifo
//
// Simulation Library Files(s):
// 			altera_mf
// ============================================================
// ************************************************************
// THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
//
// 19.1.0 Build 670 09/22/2019 SJ Lite Edition
// ************************************************************


//Copyright (C) 2019  Intel Corporation. All rights reserved.
//Your use of Intel Corporation's design tools, logic functions 
//and other software and tools, and any partner logic 
//functions, and any output files from any of the foregoing 
//(including device programming or simulation files), and any 
//associated documentation or information are expressly subject 
//to the terms and conditions of the Intel Program License 
//Subscription Agreement, the Intel Quartus Prime License Agreement,
//the Intel FPGA IP License Agreement, or other applicable license
//agreement, including, without limitation, that your use is for
//the sole purpose of programming logic devices manufactured by
//Intel and sold by Intel or its authorized distributors.  Please
//refer to the applicable agreement for further details, at
//https://fpgasoftware.intel.com/eula.


// synopsys translate_off
`timescale 1 ps / 1 ps
// synopsys translate_on
module ram2 (
	clock,
	data,
	rdreq,
	wrreq,
	empty,
	full,
	q);

	input	  clock;
	input	[23:0]  data;
	input	  rdreq;
	input	  wrreq;
	output	  empty;
	output	  full;
	output	[23:0]  q;

	wire  sub_wire0;
	wire  sub_wire1;
	wire [23:0] sub_wire2;
	wire  empty = sub_wire0;
	wire  full = sub_wire1;
	wire [23:0] q = sub_wire2[23:0];

	scfifo	scfifo_component (
				.clock (clock),
				.data (data),
				.rdreq (rdreq),
				.wrreq (wrreq),
				.empty (sub_wire0),
				.full (sub_wire1),
				.q (sub_wire2),
				.aclr (),
				.almost_empty (),
				.almost_full (),
				.eccstatus (),
				.sclr (),
				.usedw ());
	defparam
		scfifo_component.add_ram_output_register = "OFF",
		scfifo_component.intended_device_family = "Cyclone V",
		scfifo_component.lpm_hint = "RAM_BLOCK_TYPE=M10K",
		scfifo_component.lpm_numwords = 256, //adjust this for n
		scfifo_component.lpm_showahead = "OFF",
		scfifo_component.lpm_type = "scfifo",
		scfifo_component.lpm_width = 24,
		scfifo_component.lpm_widthu = 8, //adjust this for n (2^widthu = n)
		scfifo_component.overflow_checking = "ON",
		scfifo_component.underflow_checking = "ON",
		scfifo_component.use_eab = "ON";


endmodule

// ============================================================
// CNX file retrieval info
// ============================================================
// Retrieval info: PRIVATE: AlmostEmpty NUMERIC "0"
// Retrieval info: PRIVATE: AlmostEmptyThr NUMERIC "-1"
// Retrieval info: PRIVATE: AlmostFull NUMERIC "0"
// Retrieval info: PRIVATE: AlmostFullThr NUMERIC "-1"
// Retrieval info: PRIVATE: CLOCKS_ARE_SYNCHRONIZED NUMERIC "0"
// Retrieval info: PRIVATE: Clock NUMERIC "0"
// Retrieval info: PRIVATE: Depth NUMERIC "64"
// Retrieval info: PRIVATE: Empty NUMERIC "1"
// Retrieval info: PRIVATE: Full NUMERIC "1"
// Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "Cyclone V"
// Retrieval info: PRIVATE: LE_BasedFIFO NUMERIC "0"
// Retrieval info: PRIVATE: LegacyRREQ NUMERIC "1"
// Retrieval info: PRIVATE: MAX_DEPTH_BY_9 NUMERIC "0"
// Retrieval info: PRIVATE: OVERFLOW_CHECKING NUMERIC "0"
// Retrieval info: PRIVATE: Optimize NUMERIC "0"
// Retrieval info: PRIVATE: RAM_BLOCK_TYPE NUMERIC "2"
// Retrieval info: PRIVATE: SYNTH_WRAPPER_GEN_POSTFIX STRING "0"
// Retrieval info: PRIVATE: UNDERFLOW_CHECKING NUMERIC "0"
// Retrieval info: PRIVATE: UsedW NUMERIC "0"
// Retrieval info: PRIVATE: Width NUMERIC "24"
// Retrieval info: PRIVATE: dc_aclr NUMERIC "0"
// Retrieval info: PRIVATE: diff_widths NUMERIC "0"
// Retrieval info: PRIVATE: msb_usedw NUMERIC "0"
// Retrieval info: PRIVATE: output_width NUMERIC "24"
// Retrieval info: PRIVATE: rsEmpty NUMERIC "1"
// Retrieval info: PRIVATE: rsFull NUMERIC "0"
// Retrieval info: PRIVATE: rsUsedW NUMERIC "0"
// Retrieval info: PRIVATE: sc_aclr NUMERIC "0"
// Retrieval info: PRIVATE: sc_sclr NUMERIC "0"
// Retrieval info: PRIVATE: wsEmpty NUMERIC "0"
// Retrieval info: PRIVATE: wsFull NUMERIC "1"
// Retrieval info: PRIVATE: wsUsedW NUMERIC "0"
// Retrieval info: LIBRARY: altera_mf altera_mf.altera_mf_components.all
// Retrieval info: CONSTANT: ADD_RAM_OUTPUT_REGISTER STRING "OFF"
// Retrieval info: CONSTANT: INTENDED_DEVICE_FAMILY STRING "Cyclone V"
// Retrieval info: CONSTANT: LPM_HINT STRING "RAM_BLOCK_TYPE=M10K"
// Retrieval info: CONSTANT: LPM_NUMWORDS NUMERIC "64"
// Retrieval info: CONSTANT: LPM_SHOWAHEAD STRING "OFF"
// Retrieval info: CONSTANT: LPM_TYPE STRING "scfifo"
// Retrieval info: CONSTANT: LPM_WIDTH NUMERIC "24"
// Retrieval info: CONSTANT: LPM_WIDTHU NUMERIC "6"
// Retrieval info: CONSTANT: OVERFLOW_CHECKING STRING "ON"
// Retrieval info: CONSTANT: UNDERFLOW_CHECKING STRING "ON"
// Retrieval info: CONSTANT: USE_EAB STRING "ON"
// Retrieval info: USED_PORT: clock 0 0 0 0 INPUT NODEFVAL "clock"
// Retrieval info: USED_PORT: data 0 0 24 0 INPUT NODEFVAL "data[23..0]"
// Retrieval info: USED_PORT: empty 0 0 0 0 OUTPUT NODEFVAL "empty"
// Retrieval info: USED_PORT: full 0 0 0 0 OUTPUT NODEFVAL "full"
// Retrieval info: USED_PORT: q 0 0 24 0 OUTPUT NODEFVAL "q[23..0]"
// Retrieval info: USED_PORT: rdreq 0 0 0 0 INPUT NODEFVAL "rdreq"
// Retrieval info: USED_PORT: wrreq 0 0 0 0 INPUT NODEFVAL "wrreq"
// Retrieval info: CONNECT: @clock 0 0 0 0 clock 0 0 0 0
// Retrieval info: CONNECT: @data 0 0 24 0 data 0 0 24 0
// Retrieval info: CONNECT: @rdreq 0 0 0 0 rdreq 0 0 0 0
// Retrieval info: CONNECT: @wrreq 0 0 0 0 wrreq 0 0 0 0
// Retrieval info: CONNECT: empty 0 0 0 0 @empty 0 0 0 0
// Retrieval info: CONNECT: full 0 0 0 0 @full 0 0 0 0
// Retrieval info: CONNECT: q 0 0 24 0 @q 0 0 24 0
// Retrieval info: GEN_FILE: TYPE_NORMAL ram2.v TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL ram2.inc FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL ram2.cmp FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL ram2.bsf FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL ram2_inst.v FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL ram2_bb.v FALSE
// Retrieval info: LIB_FILE: altera_mf
