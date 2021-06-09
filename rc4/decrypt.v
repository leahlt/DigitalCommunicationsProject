
module decrypt(clk, rst, password, data_in, data_out, init_done,  valid, out_valid);
   input wire clk, rst;
   input wire [7:0] password, data_in;
   output reg [7:0] data_out;
   wire 	    output_ready;
   reg [7:0] 	    temp_K = 0;
   reg [7:0] 	    temp_K2 = 0;
   
   reg [7:0] 	    prev_K;
   reg [7:0] 	    data_in_temp;
   input 	    valid;
   
   
   output wire 	    init_done;
   wire [7:0] 	    K;
   input wire 	    done;   
   reg [2:0] 	    state;
   output reg 	    out_valid = 0;
   reg 		    temp_out_valid = 0;
   
   reg 		    temp_out_valid2;
   
   rc4 device(.clk(clk), .rst(rst), .output_ready(output_ready),.password_input(password),.K(K), .init_done(init_done), .valid(valid));
   always @ (posedge clk) begin
      data_out <= 0;
      out_valid <= 0;
      temp_K2 <= password;
      temp_out_valid2 <= 0;
      temp_out_valid <= 0;
      
      if(valid) begin	 
	 data_out <= temp_K2 ^ data_in;
	 temp_out_valid <= 1;
	 temp_out_valid2 <= temp_out_valid;
	 
	 out_valid <= temp_out_valid2;
      end
   end // always @ (posedge clk)
   always @ (posedge output_ready) begin
	 temp_K <= K;
      
	 
   end

   
endmodule // decrypt
