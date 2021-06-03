module top_convert(clk, rst, data_in, data_in_valid, data_out, data_out_valid);
   input clk, rst, data_in_valid;
   output data_out_valid;
   input data_in;
   output data_out;
   
   wire [7:0] temp_data;
   wire       temp_valid;
   
   bitstream_to_byte bit_to_byte(.clk(clk), .rst(rst), .data_in(data_in), .data_in_valid(data_in_valid),.data_out(temp_data), .data_out_valid(temp_valid));
   byte_to_bitstream byte_to_bit(.clk(clk) ,.rst(rst), .data_in(temp_data), .data_in_valid(temp_valid), .data_out(data_out), .data_out_valid(data_out_valid));
   
   
				 
endmodule // top_convert
