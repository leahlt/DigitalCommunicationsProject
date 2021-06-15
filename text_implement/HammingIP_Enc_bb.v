// megafunction wizard: %ALTECC%VBB%
// GENERATION: STANDARD
// VERSION: WM1.0
// MODULE: altecc_encoder 

// ============================================================
// File Name: HammingIP_Enc.v
// Megafunction Name(s):
// 			altecc_encoder
//
// Simulation Library Files(s):
// 			
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

module HammingIP_Enc (
	data,
	q)/* synthesis synthesis_clearbox = 1 */;

	input	[6:0]  data;
	output	[11:0]  q;

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
// Retrieval info: USED_PORT: data 0 0 7 0 INPUT NODEFVAL "data[6..0]"
// Retrieval info: USED_PORT: q 0 0 12 0 OUTPUT NODEFVAL "q[11..0]"
// Retrieval info: CONNECT: @data 0 0 7 0 data 0 0 7 0
// Retrieval info: CONNECT: q 0 0 12 0 @q 0 0 12 0
// Retrieval info: GEN_FILE: TYPE_NORMAL HammingIP_Enc.v TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL HammingIP_Enc.inc FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL HammingIP_Enc.cmp FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL HammingIP_Enc.bsf FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL HammingIP_Enc_inst.v FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL HammingIP_Enc_bb.v TRUE
