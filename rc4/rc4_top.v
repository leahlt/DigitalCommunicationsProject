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



