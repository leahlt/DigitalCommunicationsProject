

module decrypt(clk, rst, password, data_in, data_out, init_done);

   parameter n=7; //Bus width



   input wire clk, rst;
   input wire [n-1:0] password, data_in;
   reg [n-1:0] data_out_temp;
   output wire [n-1:0] data_out;

   wire 	    output_ready;
   reg [n-1:0] 	    temp_K = 0;
   reg [n-1:0] 	    temp_K2 = 0;
   
   reg [n-1:0] 	    prev_K;
   reg [n-1:0] 	    data_in_temp;
   
   
   output wire 	    init_done;
   wire [n-1:0] 	    K;
   reg [2:0] 	    state;
   reg 		    temp_out_valid = 0;
   reg out_valid;
   reg valid;
   reg [3:0] i = 0;

   
   rc4 device(.clk(clk), .rst(rst), .output_ready(output_ready),.password_input(password),.K(K), .init_done(init_done), .valid(valid));
   always @ (posedge clk) begin
      data_out_temp <= 0;
      out_valid <= 0;
      temp_K <= password;
      
      if(valid) begin	 
	 data_out_temp <= temp_K ^ data_in;
	 temp_out_valid <= 1;
	 out_valid <= temp_out_valid;
	 
	 
	 
      end
   end
   assign data_out =  (temp_K ^ data_in);

   always @ (posedge clk) begin
     if(rst) begin
     i <= 0;
     i <= i + 1;
     end
     else if(i > 2) valid <= 1;
   end
endmodule // decrypt
