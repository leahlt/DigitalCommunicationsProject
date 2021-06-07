
module rc4_top_tb();
   reg clk, rst;
   reg [7:0] password, data_in;
   wire [7:0] data_out;
   reg 	      valid1;
   reg 	      rdy_de, rdy_en, done_en, done_de;
   
   reg 	      valid;
  
   
   rc4_top DUT(clk, rst, password, data_in, data_out, valid1, valid);
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
      rst <= 1;
      data_in <= 0;
      password <= 0;
      rdy_en <= 0;
      rdy_de <= 0;
      done_en <= 0;
      done_de <= 0;
      valid <= 0;
      valid1 <= 0;
      
      #10;
      rst <= 0;
      password <= 57248;
      #8500;

      

      #10;
      valid1 <= 1;
      
      data_in <= 5;
      #10;
      
      data_in <= 10;
      #10;
      data_in <= 20;
      #10;
      data_in <= 30;
      #10;
      data_in <= 40;
      #40;
      valid1 <= 0;
      
 
      valid <= 1;
      
      #10;
  
      

      
      #120;
  
      
      valid <= 0;
      
      #10;

      
      #20;
      done_de <= 0;
      done_en <= 0;




      
      #100;
   
      #10;
      
      valid1 <= 1;
      
      data_in <= 5;
      #20;
      
      data_in <= 10;
      #20;
      data_in <= 20;
      #20;
      data_in <= 30;
      #20;
      data_in <= 40;
      #40;
      valid1 <= 0;
      
      #10;
      valid <= 1;
      
      

      
      #120;
      

      valid <= 0;
      
      #10;
      
      #20;

      
         
      
   end
endmodule // rc4_top_tb

   
