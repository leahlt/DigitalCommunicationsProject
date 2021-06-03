module bitstream_to_byte(clk, rst, data_in, data_in_valid, data_out, data_out_valid);
   parameter IN_SIZE = 8;
   input wire clk,rst, data_in_valid, data_in;
   output reg data_out_valid;
   output reg[IN_SIZE - 1:0] data_out;
   reg [IN_SIZE - 1:0] 	   temp_storage;
   
   reg [3:0] 	   count;
   
   always @(posedge clk) begin
      data_out <= 0;
      data_out_valid <= 0;
      if(rst) begin
	 temp_storage <= 0;
	 count <= 0;
      end
      else begin
	 if(data_in_valid) begin
	    temp_storage[count] <= data_in;
	    if(count == (IN_SIZE - 1)) begin
	       count <= 0;
	       data_out <= temp_storage + (data_in  << (IN_SIZE - 1));
	       data_out_valid <= 1;
	       temp_storage <= 0;
	    end
	    else count <= count + 1;
	 end	 	    
      end
   end

endmodule // bit_to_byte
