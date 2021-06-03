module byte_to_bitstream_tb();
   reg clk, rst,  data_in_valid;
   reg [7:0] data_in;
   
   wire data_out;
   wire       data_out_valid;
   
   byte_to_bitstream DUT(clk, rst, data_in, data_in_valid,data_out, data_out_valid);
   initial begin
      $display("hello, world");
      $dumpfile("t.vcd");
      $dumpvars;

      #1000;
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
      data_in = 0;
      data_in_valid =0;
      rst = 0;
      #5;
      
      rst = 1;
      #10;
      rst = 0;
      #10;
      data_in_valid = 1;
      data_in = 8'b10101010;		 
      #10;
      data_in_valid = 0;
      #150;
      data_in_valid = 1;
      data_in = 8'b00001111;
      #10;
      data_in_valid = 0;
      
      
   end // initial begin

endmodule // bit_to_byte_tb