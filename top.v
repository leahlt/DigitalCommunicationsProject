module top (CLOCK_50, CLOCK2_50, KEY, FPGA_I2C_SCLK, FPGA_I2C_SDAT, AUD_XCK, 
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
	wire signed [23:0] readdata_left, readdata_right;
	wire signed [23:0] writedata_left, writedata_right;
	wire reset = ~KEY[0];

	/////////////////////////////////
	// Our Code
	/////////////////////////////////
	
  //Required helper modules and files (found in FPGA_Starter Folder for now): GenericModules.v (VariableFlipFlop, VariableDivider, adder) and FIR_filter.v
	
	
	wire signed [23:0] filtered_left, filtered_right, noise, noise_left, noise_right;
	wire signed [23:0] modulated_writedata_left, modulated_writedata_right, demodulated_writedata_left, demodulated_writedata_right;
	wire signed [23:0] transmitted_left, transmitted_right, received_left, received_right;
	
	assign read = read_ready;
	assign write = write_ready; //write input flags to output flags
	
	//Modulation
	//BPSK #(24) modulate_left(.DataIn(readdata_left), .DataOut(modulated_writedata_left), .CLK(CLOCK_50), .Flag(1'b1));
	//BPSK #(24) modulate_right(.DataIn(readdata_right), .DataOut(modulated_writedata_right), .CLK(CLOCK_50), .Flag(1'b1));
	
	//transmitter
	assign writedata_left = (write_ready) ? readdata_left:24'b0;
	assign writedata_right = (write_ready) ? readdata_right:24'b0; //Transfer data from read to write when ready_ready is high

	
	//receiver
	//mycircuit reciever(.CLOCK_50(CLOCK_50), .read_ready(read_ready), .write_ready(write_ready), .read(read), .write(write), 
	//						 .readdata_left(transmitted_left), 
	//					    .readdata_right(transmitted_right), .writedata_left(writedata_left), .writedata_right(writedata_right), .reset(reset));
						  
	//demodulation
	//BPSK #(24) demodulate_left(.DataIn(received_left), .DataOut(writedata_left), .CLK(CLOCK_50), .Flag(1'b1));
	//BPSK #(24) demodulate_right(.DataIn(received_right), .DataOut(writedata_right), .CLK(CLOCK_50), .Flag(1'b1));

	
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

