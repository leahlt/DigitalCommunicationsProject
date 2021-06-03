module top_convert_tb();
   reg clk, rst,  data_in, data_in_valid;
   wire data_out;
   wire       data_out_valid;
   
   top_convert DUT(clk, rst, data_in, data_in_valid,data_out, data_out_valid);
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
	 #5;
	 clk = ~clk;
      end
   end
   initial begin
      data_in <= 0;
      data_in_valid <=0;
      rst <= 0;
      #5;
      rst <= 1;
      #10;
      rst <= 0;
      #10;
      data_in_valid <= 1;
      data_in <= 1;
      #10;
      data_in <= 0;
      #10;
      data_in <= 1;
      #10;      
      data_in <= 0;
      #10;     
      data_in <= 1;
      #10;      
      data_in <= 0;
      #10;     
      data_in <= 1;
      #10;
      data_in <= 0;
 
      
      #10;
      data_in_valid <= 0;
      
      
   end // initial begin

endmodule // bit_to_byte_tb
