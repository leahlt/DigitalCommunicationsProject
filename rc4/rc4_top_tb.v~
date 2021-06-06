
module rc4_top_tb();
   reg clk, rst;
   reg [7:0] password, data_in;
   wire [7:0] data_out;
   reg 	      rdy_en;
   reg 	      rdy_de;
   reg 	      done_de, done_en;
  
   
   rc4_top DUT(clk, rst, password, data_in, data_out, rdy_en, rdy_de, done_en, done_de);
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
      
      #10;
      rst <= 0;
      # 50;
      password <= 1;
      #8500;

      

      #10;
      
      rdy_en <= 1;
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
      rdy_en <= 0;
      done_en <= 1;
      rdy_de <= 1;
      #10;
  
      

      
      #150;
      #10;
      
      rdy_de <= 0;

      done_de <= 1;
      #10;

      
      #20;
      done_de <= 0;
      done_en <= 0;




      
      #100;
   
      #10;
      
      rdy_en <= 1;
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
      rdy_en <= 0;
      done_en <= 1;
      rdy_de <= 1;
      #10;
 
      

      
      #150;
      #10;
      
      rdy_de <= 0;

      done_de <= 1;
      #10;
      
      #20;
      done_de <= 0;
      done_en <= 0;
      
         
      
   end
endmodule // rc4_top_tb

   
