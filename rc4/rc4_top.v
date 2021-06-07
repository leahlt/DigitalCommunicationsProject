`define START 0
`define PROGRESS 1
`define VALID 2

module rc4_top(clk, rst, password, data_in, data_out, valid1, valid);
   input wire clk, rst;
   input wire [7:0] password, data_in;
   output wire [7:0] data_out;
   input 	     valid1, valid;
   
   wire 	     rdy_en, rdy_de, done_en, done_de;
   wire [7:0] 	     data_out_temp ;
   reg [7:0] 	     data_out_temp2 = 0;
   wire 	     init_done1, init_done2;
   reg [7:0] 	     storage[255:0];
   wire 	     start_en, start_de;
   
   reg [31:0] 	     i = 0;
   reg [31:0] 	     j = 0;
   
   reg [1:0] 	     state1 = 0;
   reg [1:0] 	     state2 = 0;
   reg 	     valid2;
   
   
   
   encrypt encrypt_d(.clk(clk), .rst(rst), .password(password), .data_in(data_in) ,.data_out(data_out_temp), .init_done(init_done1), .rdy(rdy_en), .done(done_en), .valid(valid1));
   decrypt decrypt_d(.clk(clk), .rst(rst), .password(password), .data_in(data_out_temp2) ,.data_out(data_out), .init_done(init_done2), .rdy(rdy_de), .done(done_de), .valid(valid2));
   

   always @(posedge clk) begin

      if(valid1) begin
	 storage[i] <= data_out_temp;
	 i <= i + 1;
      end
      else i <= 0;
      
   end // always @ (posedge clk)
   

   always @(posedge clk) begin
      valid2 <= 0;
      data_out_temp2 <= 0;
      
      if(valid) begin
	 valid2 <= 1;
	 data_out_temp2 <= storage[j];
	 j <= j + 1;
	 
      end
      else
	j <= 0;
      

   end // always @ (posedge clk)
   

   
   


endmodule // rc4_top



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
   
   
   
   rc4 device(.clk(clk), .rst(rst), .output_ready(output_ready),.password_input(password),.K(K), .init_done(init_done), .rdy(rdy), .done(done));
   always @ (posedge clk) begin
      data_out <= 0;
      out_valid <= 0;
      
      if(valid) begin
	 data_out <= K ^ data_in;
	 out_valid <= 1;
	 
      end
   end
   
endmodule // decrypt


module decrypt(clk, rst, password, data_in, data_out, init_done, rdy, done, valid, out_valid);
   input wire clk, rst;
   input wire [7:0] password, data_in;
   output reg [7:0] data_out;
   wire 	    output_ready;
   reg [7:0] 	    temp_K = 0;
   reg [7:0] 	    temp_K2 = 0;
   input	    valid;
   
   reg [7:0] 	    prev_K;
   reg [7:0] 	    data_in_temp;
   
   output wire 	    init_done;
   input wire 	    rdy;
   wire [7:0] 	    K;
   input wire 	    done;   
   reg [2:0] 	    state;
   output reg 	    out_valid = 0;
   reg 		    temp_out_valid = 0;
   
   
   rc4 device(.clk(clk), .rst(rst), .output_ready(output_ready),.password_input(password),.K(K), .init_done(init_done), .rdy(rdy), .done(done));
   always @ (posedge clk) begin
      data_out <= 0;
      out_valid <= 0;
      
      if(valid) begin	 
	 data_out <= K ^ data_in;
	 temp_out_valid <= 1;
	 out_valid <= temp_out_valid;
	 
	 
      end
   end

endmodule // decrypt


