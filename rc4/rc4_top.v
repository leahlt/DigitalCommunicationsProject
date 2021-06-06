
module rc4_top(clk, rst, password, data_in, data_out, rdy_en, rdy_de, done_en, done_de);
   input wire clk, rst;
   input wire [7:0] password, data_in;
   output wire [7:0] data_out;
   input 	     rdy_en, rdy_de, done_en, done_de;
   wire [7:0] 	     data_out_temp;
   reg [7:0] 	     data_out_temp2;
   wire 	     init_done1, init_done2;
   reg [7:0] 	     storage[255:0];
   wire 	     start_en, start_de;
   
   integer 	     i = 0;
   integer 	     j = 0;
   
   reg [1:0] 	     state1 = 0;
   reg [1:0] 	     state2 = 0;
   
   
   
   encrypt encrypt_d(.clk(clk), .rst(rst), .password(password), .data_in(data_in) ,.data_out(data_out_temp), .init_done(init_done1), .rdy(rdy_en), .done(done_en));
   decrypt decrypt_d(.clk(clk), .rst(rst), .password(password), .data_in(data_out_temp2) ,.data_out(data_out), .init_done(init_done2), .rdy(rdy_de), .done(done_de));
 

   always @(posedge clk) begin
      case (state1)
	 0 : begin
	    if(rdy_en) begin
	       state1 <= 1;
	    end
	 end
	1 : begin
	   if(done_en) begin
	      state1 <=2 ;
	   end
	   storage[i] <= data_out_temp;
	   i <= i + 1;
	end
	2 : begin
	   i <= 0;
	   state1 <= 0;
	end
	default : state1 <= 0;
	
      endcase // case (state1)
   end // always @ (posedge clk)
   

   always @(posedge clk) begin
      case (state2)
	 0 : begin
	    if(rdy_de) begin
	       state2 <= 1;
	    end
	 end
	1 : begin
	   if(done_de) begin
	      state2 <=2 ;
	   end
        data_out_temp2 <= storage[j];
	 j <= j + 1;
	end
	2 : begin
	   j <= 0;
	   state2 <= 0;
	end
	default : state2 <= 0;
	
      endcase // case (state1)
   end // always @ (posedge clk)
   

	    
	    


endmodule // rc4_top


module encrypt(clk, rst, password, data_in, data_out, init_done, rdy, done);
   input wire clk, rst;
   input wire [7:0] password, data_in;
   output reg [7:0] data_out;
    wire 	    output_ready;
    wire [7:0] 	    K;
   reg [7:0] 	    prev_K;
   output wire 	    init_done;
   input wire 	    rdy;
   input wire 	    done;
   
   
   
   rc4 device(.clk(clk), .rst(rst), .output_ready(output_ready),.password_input(password),.K(K), .init_done(init_done), .rdy(rdy), .done(done));
   always @ (posedge clk) begin
      if(output_ready) begin
	 data_out = K ^ data_in;
      end
   end
   
endmodule // decrypt


module decrypt(clk, rst, password, data_in, data_out, init_done, rdy, done);
   input wire clk, rst;
   input wire [7:0] password, data_in;
   output reg [7:0] data_out;
    wire 	    output_ready;
    reg [7:0] 	    temp_K;
   reg [7:0] 	    prev_K;
   reg [7:0] 	    temp_data_in;
   
   output wire 	    init_done;
   input wire 	    rdy;
   wire [7:0] 	    K;
   input wire 	    done;   
   
   rc4 device(.clk(clk), .rst(rst), .output_ready(output_ready),.password_input(password),.K(K), .init_done(init_done), .rdy(rdy), .done(done));
   always @ (posedge clk) begin
      if(output_ready) begin
	 temp_K <= K;
	 
	 data_out = temp_K ^ data_in;
      end
   end
   
endmodule // decrypt


