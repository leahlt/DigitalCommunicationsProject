
module rc4_top_tb();
   reg clk, rst;
   reg [7:0] password, data_in;
   wire [7:0] data_out;
   reg 	      valid1;
   reg 	      rdy_de, rdy_en, done_en, done_de;
   
   reg 	      valid;
   task delay(input [31:0] num);
      integer i;
      
      for (i=0; i<num; i=i+1)
	@(posedge clk) ;
   endtask// delay
   
   
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
      
      delay(2);
      rst <= 0;
      password <= 137;
      delay(1000);
      

      

      delay(2);
      valid1 <= 1;
      
      data_in <= 5;
      delay(2);
      
      data_in <= 10;
      delay(2);
      data_in <= 20;
      delay(2);
      data_in <= 30;
      delay(2);
      data_in <= 40;
      delay(2);
      valid1 <= 0;
      
 
      valid <= 1;
      
      delay(10);
  
      

      
      delay(120);
      
  
      
      valid <= 0;
      
      delay(10);

      
      delay(2);
      done_de <= 0;
      done_en <= 0;




      
      delay(100);
   
      delay(10);
      
      valid1 <= 1;
      
      data_in <= 5;
      delay(2);
      
      data_in <= 10;
      delay(2);
      data_in <= 20;
      delay(2);
      data_in <= 30;
      delay(2);
      data_in <= 40;
      delay(4);
      valid1 <= 0;
      
      delay(10);
      valid <= 1;
      
      

      
      delay(130);
      

      valid <= 0;
      
      delay(10);
      

      
         
      
   end
endmodule // rc4_top_tb

   
