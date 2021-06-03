`define RST_STATE 0
`define INIT_STATE 1
`define PROGRESS_STATE 2

module byte_to_bitstream(clk, rst, data_in, data_in_valid, data_out, data_out_valid);

   parameter IN_SIZE = 8;
   input clk, rst, data_in_valid;
   input [IN_SIZE - 1:0] data_in;
   output 	    data_out;
   output 	    data_out_valid;
   reg [IN_SIZE - 1:0] 	    temp_storage;
   
   reg [3:0] 	    count;
   reg 		    start;
   reg [3:0] 	    c_state = 0;
   
   reg [3:0] 	    n_state;
   
   always @(posedge clk) begin
      if(rst) c_state <= `RST_STATE;
      else c_state <= n_state;	
   end
   
   always @(*) begin
      case (c_state)
	`RST_STATE : begin
	   n_state = `INIT_STATE;
	end
	`INIT_STATE: begin
	   if(data_in_valid) begin
	      n_state = `PROGRESS_STATE;
	   end
	   else n_state = `INIT_STATE;
	end
	`PROGRESS_STATE : begin
	   if(count == (IN_SIZE - 1)) begin
	      n_state = `INIT_STATE;
	   end
	   else begin
	      n_state = `PROGRESS_STATE;
	   end	   
	end // case: `PROGRESS_STATE
	default : n_state = c_state;
	
      endcase // case (c_state)
   end // always @ (*)

   always @(posedge clk) begin
      if(c_state == `RST_STATE || c_state == `INIT_STATE) begin
	 count <= 0;	 
      end
      else begin
	 if(c_state == `PROGRESS_STATE && count == (IN_SIZE - 1)) count <= 0;
	 else count <= count + 1;
      end  
   end

   always @(posedge clk) begin
      if(c_state == `INIT_STATE && data_in_valid) temp_storage <= data_in;
   end
   
   assign data_out_valid = (c_state == `PROGRESS_STATE);
   assign data_out = (c_state == `PROGRESS_STATE) ? temp_storage[count] : 0;
   
   
endmodule // byte_to_bitsream
