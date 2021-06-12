module tx(clk, data_in, b0, b1, b2, b3, b4, b5, b6, b7);
   input clk;
   
   input [7:0] data_in;
   output reg [8:0] b0 = 0;
   output reg [8:0] b1 = 0;
   output reg [8:0] b2 = 0;
   output reg [8:0] b3 = 0;
   output reg [8:0] b4 = 0;
   output reg [8:0] b5 = 0;
   output reg [8:0] b6 = 0;
   output reg [8:0] b7 = 0;

   always @(posedge clk) begin
      b0 = {data_in[0], 8'b0};
      b1 = {data_in[1], 8'b0};
      b2 = {data_in[2], 8'b0};
      b3 = {data_in[3], 8'b0};
      b4 = {data_in[4], 8'b0};
      b5 = {data_in[5], 8'b0};
      b6 = {data_in[6], 8'b0};
      b7 = {data_in[7], 8'b0};
      
   end
   
endmodule // tx

module rx(clk, b0, b1, b2, b3, b4, b5, b6, b7, data_out);
   input clk;
   input [8:0] b0;
   input [8:0] b1;
   input [8:0] b2;
   input [8:0] b3;
   input [8:0] b4;
   input [8:0] b5;
   input [8:0] b6;
   input [8:0] b7;

   output [7:0] data_out;
   assign data_out = {b7[8], b6[8], b5[8], b4[8], b3[8], b2[8], b1[8], b0[8]};
   
   
endmodule // rx



module channel(input clk, input reset, input [7:0] data_in, output [7:0] data_out);
   

   wire [8:0]  b0, b1, b2, b3, b4, b5, b6, b7;
   wire [8:0]  b0n, b1n, b2n, b3n, b4n, b5n, b6n, b7n;
   
   wire        busy, sum_real_n_truncation;
   wire [7:0]  Y_out_real, Y_out_imag;
   
   tx trans(clk, data_in, b0, b1, b2, b3, b4, b5, b6, b7);
   awgn noise(clk, reset, 1'b1, data_in, 1'b0, busy, Y_out_real, Y_out_imag, sum_real_n_truncation);

   assign b0n = b0 + Y_out_real;
   assign b1n = b1 + Y_out_real;
   assign b2n = b2 + Y_out_real;
   assign b3n = b3 + Y_out_real;
   assign b4n = b4 + Y_out_real;
   assign b5n = b5 + Y_out_real;
   assign b6n = b6 + Y_out_real;
   assign b7n = b7 + Y_out_real;

   rx rec (clk, b0n, b1n, b2n, b3n, b4n, b5n, b6n, b7n, data_out);
   
   
endmodule // top

module top_tb();
   reg 	      clk, reset;
   reg [7:0]  data_in;
   wire [7:0] data_out;
   task delay(input [31:0] num);
      integer i;
      
      for (i=0; i<num; i=i+1)
	@(posedge clk) ;
   endtask// delay
   
   top DUT(clk, reset, data_in, data_out);

   
   initial begin
      $display("hello, world");
      $dumpfile("t.vcd");
      $dumpvars;

      #100000;
      $finish;
   end
   initial begin
      clk = 0;
      forever begin
	 #4;
	 clk = ~clk;
      end
   end

   initial begin
      reset <= 0;
      delay(2);
      reset <= 1;
      delay(2);
      reset <= 0;
      delay(100);
      
      
      data_in <= 8'b10101010;
      delay(15);
      data_in <= 8'b01100110;
      delay(15);
      data_in <= 8'b00000000;
      delay(15);
      data_in <= 8'b00111111;
      
      delay(1000);
      
      $stop;
      
   end
   
   
endmodule // top_tb
