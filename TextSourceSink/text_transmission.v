/*************************************************************************************************
- reads 8-bit characters from a ROM memory
- stores 8-bits into a vector data bus
- once 64 characters have been read, outputs them to a data bus in this format:

output_data = {character0, character1,..., character63} 

- waits until sink has received this 64 character data bus before reading another 64 characters 
- continues until last address in 256 word memory has been read
*************************************************************************************************/
module get_text_source(clk, reset, data_received, data_out);
	input clk, reset, data_received;
	output reg [511:0] data_out;

	//internal signals
	wire load_incr, load_data, load_output, rst_counter; 
	reg [6:0] counter  = 7'b0;  //initialize counter
	reg [7:0] address = 8'b0; //initialize address
	wire [7:0] data_from_ROM; 
	reg [0:7] data_bus [63:0]; //data bus is an 8-bit vector net with a depth of 64
	parameter end_address = 8'hFF;
	
	//state encodings
	parameter WAIT = 		7'b000_0000;
	parameter DONE = 		7'b001_0000;
	parameter READ = 		7'b010_0000;
	parameter STORE =		7'b011_0001;
	parameter INCREMENT =   	7'b100_0010;
	parameter SEND_DATA_BUS = 	7'b101_1100;
	
	reg [6:0] state = WAIT; //initialize state

	//control signals driven by state bits
	assign load_data = state[0];
	assign load_incr = state[1];
	assign rst_counter = state[2];
	assign load_output = state[3];
	
	//determining address
	always @ (posedge clk or posedge reset) begin
		if (reset) address <= 8'b0;
		else if (load_incr) address <= address + 1'b1;
		else address <= address;
	end 

	//determining counter
	always @ (posedge clk or posedge reset) begin
		if (reset | rst_counter) counter <= 7'b0; 
		else if (load_incr) counter <= counter + 1'b1;
		else counter <= counter;
	end

	//data bus
	always @ (posedge clk) begin
		if (load_data) data_bus[counter] <= data_from_ROM;
		else data_bus[counter] <= data_bus[counter];
	end

	//output 64 character data bus
	always @ (posedge clk) begin
		if (load_output) 
			data_out <= {data_bus[0], 
				     data_bus[1],
				     data_bus[2], 
				     data_bus[3],
				     data_bus[4], 
				     data_bus[5],
				     data_bus[6], 
				     data_bus[7],
				     data_bus[8], 
				     data_bus[9],
				     data_bus[10], 
				     data_bus[11],
				     data_bus[12], 
				     data_bus[13],
				     data_bus[14], 
				     data_bus[15],
				     data_bus[16], 
				     data_bus[17],
				     data_bus[18], 
				     data_bus[19],
				     data_bus[20], 
				     data_bus[21],
				     data_bus[22], 
				     data_bus[23],
				     data_bus[24], 
				     data_bus[25],
				     data_bus[26], 
				     data_bus[27],
				     data_bus[28], 
				     data_bus[29],
				     data_bus[30], 
				     data_bus[31],
				     data_bus[32], 
				     data_bus[33],
				     data_bus[34], 
				     data_bus[35],
			             data_bus[36], 
				     data_bus[37],
				     data_bus[38], 
				     data_bus[39],
				     data_bus[40], 
				     data_bus[41],
				     data_bus[42], 
				     data_bus[43],
				     data_bus[44], 
				     data_bus[45],
				     data_bus[46], 
				     data_bus[47],
				     data_bus[48], 
				     data_bus[49],
				     data_bus[50], 
				     data_bus[51],
				     data_bus[52], 
				     data_bus[53],
				     data_bus[54], 
				     data_bus[55],
				     data_bus[56], 
				     data_bus[57],
				     data_bus[58], 
				     data_bus[59],
				     data_bus[60], 
				     data_bus[61],
				     data_bus[62], 
				     data_bus[63]
				     };
	end 
		
	//state transitions
	always @ (posedge clk or posedge reset) begin
		if (reset) state <= WAIT;
		else begin
			case(state)
			WAIT: if (address == end_address) state <= DONE;
			      else if (data_received) state <= READ; 
			      else state <= WAIT;
			READ: state <= STORE;
			STORE: if (counter < 7'd64) state <= INCREMENT;
			       else state <= SEND_DATA_BUS;
			INCREMENT: state <= READ;
			SEND_DATA_BUS: state <= WAIT;
			DONE: state <= DONE;
			default: state <= WAIT;
			endcase
		end 
	end 

	//instantiate ROM memory which holds data to be transmitted
	ROM source(
	.address(address),
	.clock(clk),
	.q(data_from_ROM)
	);
	
endmodule
 
/*************************************************************************************************
- gets 64 8-bit characters 
- stores each character into a vector data bus in this format:

data_bus = {character63, character62,..., character0} 

- stores each character into RAM (character[0] into address = 0) 
- increments counter each time character stored
- continues until all 64 characters stored, resets counter, sends source a "data_received" signal
- waits for new set of 64-characters
*************************************************************************************************/
module get_text_sink(clk, reset, data_valid, data_in, data_received);
	input clk, reset, data_valid;
	input [511:0] data_in;
	output data_received;

	//internal signals
	wire load_data, load_incr, write, rst_counter;
	reg [7:0] address = 8'b0; //initialize address
	reg [7:0] counter = 8'b0; //initialize counter
	reg [7:0] data_to_RAM;
	wire [0:7] data_bus [63:0]; //data bus is an 8-bit vector net with a depth of 64

	//state encodings
	parameter WAIT = 	7'b000_0000;
	parameter LOAD_DATA = 	7'b001_0001;
	parameter INCREMENT = 	7'b010_0010;
	parameter WRITE = 	7'b011_0100;
	parameter DONE = 	7'b100_1000;

	reg [6:0] state = WAIT; //initialize state

	//control signals driven by state bits
	assign load_data = state[0];
	assign load_incr = state[1];
	assign write = state[2];
	assign data_received = state[3];
	assign rst_counter = state[3];

	//turning 512-bit input into a vector data bus
	assign data_bus[0] = data_in[511:504]; //character0
	assign data_bus[1] = data_in[503:496];
	assign data_bus[2] = data_in[495:488];
	assign data_bus[3] = data_in[487:480];
	assign data_bus[4] = data_in[479:472];
	assign data_bus[5] = data_in[471:464];
	assign data_bus[6] = data_in[463:456];
	assign data_bus[7] = data_in[455:448];
	assign data_bus[8] = data_in[447:440];
	assign data_bus[9] = data_in[439:432];
	assign data_bus[10] = data_in[431:424];
	assign data_bus[11] = data_in[423:416];
	assign data_bus[12] = data_in[415:408];
	assign data_bus[13] = data_in[407:400];
	assign data_bus[14] = data_in[399:392];
	assign data_bus[15] = data_in[391:384];
	assign data_bus[16] = data_in[383:376];
	assign data_bus[17] = data_in[375:368];
	assign data_bus[18] = data_in[367:360];
	assign data_bus[19] = data_in[359:352];
	assign data_bus[20] = data_in[351:344];
	assign data_bus[21] = data_in[343:336];
	assign data_bus[22] = data_in[335:328];
	assign data_bus[23] = data_in[327:320];
	assign data_bus[24] = data_in[319:312];
	assign data_bus[25] = data_in[311:304];
	assign data_bus[26] = data_in[303:296];
	assign data_bus[27] = data_in[295:288];
	assign data_bus[28] = data_in[287:280];
	assign data_bus[29] = data_in[279:272];
	assign data_bus[30] = data_in[271:264];
	assign data_bus[31] = data_in[263:256];
	assign data_bus[32] = data_in[255:248];
	assign data_bus[33] = data_in[247:240];
	assign data_bus[34] = data_in[239:232];
	assign data_bus[35] = data_in[231:224];
	assign data_bus[36] = data_in[223:216];
	assign data_bus[37] = data_in[215:208];
	assign data_bus[38] = data_in[207:200];
	assign data_bus[39] = data_in[199:192];
	assign data_bus[40] = data_in[191:184];
	assign data_bus[41] = data_in[183:176];
	assign data_bus[42] = data_in[175:168];
	assign data_bus[43] = data_in[167:160];
	assign data_bus[44] = data_in[159:152];
	assign data_bus[45] = data_in[151:144];
	assign data_bus[46] = data_in[143:136];
	assign data_bus[47] = data_in[135:128];
	assign data_bus[48] = data_in[127:120];
	assign data_bus[49] = data_in[119:112];
	assign data_bus[50] = data_in[111:104];
	assign data_bus[51] = data_in[103:96];
	assign data_bus[52] = data_in[95:88];
	assign data_bus[53] = data_in[87:80];
	assign data_bus[54] = data_in[79:72];
	assign data_bus[55] = data_in[71:64];
	assign data_bus[56] = data_in[63:56];
	assign data_bus[57] = data_in[55:48];
	assign data_bus[58] = data_in[47:40];
	assign data_bus[59] = data_in[39:32];
	assign data_bus[60] = data_in[31:24];
	assign data_bus[61] = data_in[23:16];
	assign data_bus[62] = data_in[15:8];
	assign data_bus[63] = data_in[7:0]; //character63


	//determine address
	always @ (posedge clk or posedge reset) begin
		if (reset) address <= 8'b0;
		else if (load_incr) address <= address + 1'b1;
		else address <= address;
	end

	//determine counter
	always @ (posedge clk or posedge reset) begin
		if (reset | rst_counter) counter <= 8'b0;
		else if (load_incr) counter <= counter + 1'b1;
		else counter <= counter;
	end

	//determine data being sent to RAM
	always @ (posedge clk) begin
		if (load_data) data_to_RAM <= data_bus[counter];
		else data_to_RAM <= data_to_RAM;
	end 
		
	//state transitions
	always @ (posedge clk or posedge reset) begin
		if (reset) state <= WAIT; 
		else begin
			case (state)
			WAIT: if (data_valid) state <= LOAD_DATA;
			      else state <= WAIT;
			LOAD_DATA: state <= INCREMENT;			
			INCREMENT: state <= WRITE;
			WRITE: if (counter < 7'd64) state <= LOAD_DATA;
			       else state <= DONE;
			DONE: state <= WAIT;
			default: state <= WAIT;
			endcase
		end
	end
	
	//initialize RAM memory which stores transmitted data
	RAM sink(
	.address(address),
	.clock(clk),
	.data(data_to_RAM),
	.wren(write),
	.q()
	);
endmodule 