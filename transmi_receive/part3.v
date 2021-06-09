
module part3 (CLOCK_50, CLOCK2_50, KEY, FPGA_I2C_SCLK, FPGA_I2C_SDAT, AUD_XCK, 
		        AUD_DACLRCK, AUD_ADCLRCK, AUD_BCLK, AUD_ADCDAT, AUD_DACDAT);

	input CLOCK_50, CLOCK2_50;
	input [0:0] KEY;
	// I2C Audio/Video config interface
	output FPGA_I2C_SCLK;
	inout FPGA_I2C_SDAT;
	// Audio CODEC
	output AUD_XCK;
	input AUD_DACLRCK, AUD_ADCLRCK, AUD_BCLK;
	input AUD_ADCDAT;
	output AUD_DACDAT;
	
	// Local wires.
	wire read_ready, write_ready, read, write;
	wire [23:0] readdata_left, readdata_right;
	wire [23:0] writedata_left, writedata_right;
	wire reset = ~KEY[0];
	
	/////////////////////////////////
	// Your code goes here 
	/////////////////////////////////
	wire [23:0] modulator_out_l, modulator_out_r;
	wire[23:0] demodulator_in_l, demodulator_in_r;
	wire [23:0] rc4_en_l_out, rc4_en_r_out, rc4_de_l_in, rc4_de_r_in;

	wire init_done_de_l, init_done_de_r, init_done_en_l, init_done_en_r;

	encrypt rc4_en_l(CLOCK_50, reset, 1234, readdata_left, rc4_en_l_out, init_done_en_l);
	encrypt rc4_en_r(CLOCK_50, reset, 1234, readdata_right, rc4_en_r_out, init_done_en_r);

	BPSK modulator_l(rc4_en_l_out, modulator_out_l, CLOCK_50, 1);
	BPSK modulator_r(rc4_en_r_out, modulator_out_r, CLOCK_50, 1);

	mycircuit circuit(CLOCK_50, read_ready, write_ready, read, write, modulator_out_l, modulator_out_r, demodulator_in_l, demodulator_in_r, reset);


	BPSK demodulator_l(demodulator_in_l, rc4_de_l_in , CLOCK_50, 1);
	BPSK demodulator_r(demodulator_in_r, rc4_de_r_in , CLOCK_50, 1);

	decrypt rc4_de_l(CLOCK_50, reset, 1234, rc4_de_l_in, writedata_left, init_done_en_l);
	decrypt rc4_de_r(CLOCK_50, reset, 1234, rc4_de_r_in, writedata_right, init_done_en_r);

	
/////////////////////////////////////////////////////////////////////////////////
// Audio CODEC interface. 
//
// The interface consists of the following wires:
// read_ready, write_ready - CODEC ready for read/write operation 
// readdata_left, readdata_right - left and right channel data from the CODEC
// read - send data from the CODEC (both channels)
// writedata_left, writedata_right - left and right channel data to the CODEC
// write - send data to the CODEC (both channels)
// AUD_* - should connect to top-level entity I/O of the same name.
//         These signals go directly to the Audio CODEC
// I2C_* - should connect to top-level entity I/O of the same name.
//         These signals go directly to the Audio/Video Config module
/////////////////////////////////////////////////////////////////////////////////
	clock_generator my_clock_gen(
		// inputs
		CLOCK2_50,
		reset,

		// outputs
		AUD_XCK
	);

	audio_and_video_config cfg(
		// Inputs
		CLOCK_50,
		reset,

		// Bidirectionals
		FPGA_I2C_SDAT,
		FPGA_I2C_SCLK
	);

	audio_codec codec(
		// Inputs
		CLOCK_50,
		reset,

		read,	write,
		writedata_left, writedata_right,

		AUD_ADCDAT,

		// Bidirectionals
		AUD_BCLK,
		AUD_ADCLRCK,
		AUD_DACLRCK,

		// Outputs
		read_ready, write_ready,
		readdata_left, readdata_right,
		AUD_DACDAT
	);

endmodule


