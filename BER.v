//adapted from https://github.com/SaKi1309/Bit_Error_Tester/blob/main/Verilog_Design/error_counter.v

module BER_audio(
pattern1,
pattern2,
clock,
reset,
enable,		//enabled by the tx enable
errors,		// number of errors
error_flag	//is set when errorcount is full
);

input [11:0] pattern1;
input [11:0] pattern2;
input clock;
input reset;
input enable;

output reg [49:0] errors;   // 16 bit because 4 digit Hex Display
output reg error_flag;


always @ (posedge clock or posedge reset)
	begin
		if(reset)
			begin
				errors [49:0] <= 50'b0;
				error_flag <= 1'b0;
			end	
				else if (enable)
					begin
					 // because then the display shows FFFF when 2 edges later
						if(errors[49:0] == 50'b1-2'b10)
							begin
								error_flag <= 1'b1;
							end	
						else
							if (pattern1[11] != pattern2[11])
								errors[49:0] <= errors[49:0] + 1'b1;
								
							if (pattern1[10] != pattern2[10])
								errors[49:0] <= errors[49:0] + 1'b1;
								
							if (pattern1[9] != pattern2[9])
								errors[49:0] <= errors[49:0] + 1'b1;
								
							if (pattern1[8] != pattern2[8])
								errors[49:0] <= errors[49:0] + 1'b1;
								
							if (pattern1[7] != pattern2[7])
								errors[49:0] <= errors[49:0] + 1'b1;
								
							if (pattern1[6] != pattern2[6])
								errors[49:0] <= errors[49:0] + 1'b1;
								
							if (pattern1[5] != pattern2[5])
								errors[49:0] <= errors[49:0] + 1'b1;
								
							if (pattern1[4] != pattern2[4])
								errors[49:0] <= errors[49:0] + 1'b1;
								
							if (pattern1[3] != pattern2[3])
								errors[49:0] <= errors[49:0] + 1'b1;
								
							if (pattern1[2] != pattern2[2])
								errors[49:0] <= errors[49:0] + 1'b1;
								
							if (pattern1[1] != pattern2[1])
								errors[49:0] <= errors[49:0] + 1'b1;
								
							if (pattern1[0] != pattern2[0])
								errors[49:0] <= errors[49:0] + 1'b1;
					end
end

endmodule


//adapted from https://github.com/SaKi1309/Bit_Error_Tester/blob/main/Verilog_Design/error_counter.v

module BER_text(
pattern1,
pattern2,
clock,
reset,
enable,		//enabled by the tx enable
errors,		// number of errors
error_flag	//is set when errorcount is full
);

input [7:0] pattern1;
input [7:0] pattern2;
input clock;
input reset;
input enable;

output reg [49:0] errors;   // 16 bit because 4 digit Hex Display
output reg error_flag;


always @ (posedge clock or posedge reset)
	begin
		if(reset)
			begin
				errors [49:0] <= 50'b0;
				error_flag <= 1'b0;
			end	
				else if (enable)
					begin
					 // because then the display shows FFFF when 2 edges later
						if(errors[49:0] == 50'b1-2'b10)
							begin
								error_flag <= 1'b1;
							end	
						else
							if (pattern1[7] != pattern2[7])
								errors[49:0] <= errors[49:0] + 1'b1;
								
							if (pattern1[6] != pattern2[6])
								errors[49:0] <= errors[49:0] + 1'b1;
								
							if (pattern1[5] != pattern2[5])
								errors[49:0] <= errors[49:0] + 1'b1;
								
							if (pattern1[4] != pattern2[4])
								errors[49:0] <= errors[49:0] + 1'b1;
								
							if (pattern1[3] != pattern2[3])
								errors[49:0] <= errors[49:0] + 1'b1;
								
							if (pattern1[2] != pattern2[2])
								errors[49:0] <= errors[49:0] + 1'b1;
								
							if (pattern1[1] != pattern2[1])
								errors[49:0] <= errors[49:0] + 1'b1;
								
							if (pattern1[0] != pattern2[0])
								errors[49:0] <= errors[49:0] + 1'b1;
					end
end

endmodule
