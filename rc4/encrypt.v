

module encrypt(clk, rst, password, data_in, data_out, init_done, rdy, done, valid, out_valid);
   input wire clk, rst;
   input wire [7:0] password, data_in;
   output reg [7:0] data_out;
   wire 	    output_ready;
   wire [7:0] 	    K;
   reg [7:0] 	    prev_K;
   output wire 	    init_done;
   input wire 	    rdy;
   input wire 	    done;
   
   reg [2:0] 	    state;
   reg [7:0] 	    temp_K = 0;
   input 	    valid;
   output  reg	    out_valid = 0;
   
   
   
   rc4 device(.clk(clk), .rst(rst), .output_ready(output_ready),.password_input(password),.K(K), .init_done(init_done), .valid(valid));
   always @ (posedge clk) begin
      data_out <= 0;
      out_valid <= 0;
      temp_K <= password;
      
      if(valid) begin
	 data_out <= temp_K ^ data_in;
	 out_valid <= 1;
	 
      end
   end
   
endmodule // decrypt
