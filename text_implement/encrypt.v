
module encrypt(clk, rst, password, data_in, data_out, init_done, valid);

   parameter n=7;
   input wire clk, rst;
   input wire [n-1:0] password, data_in;
   output wire [n-1:0] data_out;
   reg [n-1:0] data_out_temp;
   input valid;
   wire 	    output_ready;
   wire [n-1:0] 	    K;
   reg [n-1:0] 	    prev_K;
   output wire 	    init_done;

   reg [2:0] 	    state;
   reg [n-1:0] 	    temp_K = 0;
   reg out_valid;
   
   
   rc4 device(.clk(clk), .rst(rst), .output_ready(output_ready),.password_input(password),.K(K), .init_done(init_done), .valid(valid));
   always @ (posedge clk) begin
      data_out_temp <= 0;
      out_valid <= 0;
      temp_K <= password;
      
      if(valid) begin
	 data_out_temp <= K ^ data_in;
	 out_valid <= 1;
	 
      end
   end
   assign data_out = (temp_K ^ data_in);
   
endmodule // decrypt
