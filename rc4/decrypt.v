`define START 0
`define PROGRESS 1

module decrypt(clk, rst, password, data_in, data_out, init_done, start, done);
   input wire clk, rst;
   input wire [7:0] password, data_in;
   output reg [7:0] data_out;
    wire 	    output_ready;
    reg [7:0] 	    temp_K;
   reg [7:0] 	    prev_K;
   reg [7:0] 	    temp_data_in;
   
   output wire 	    init_done;
   input wire 	    start;
   wire [7:0] 	    K;
   input wire 	    done;   
   wire 	    valid;
   reg [2:0] 	    state;
   
   rc4 device(.clk(clk), .rst(rst), .output_ready(output_ready),.password_input(password),.K(K), .init_done(init_done), .start(start), .done(done));
   always @ (posedge clk) begin
      if(output_ready) begin
	 temp_K <= K;
	 data_out = temp_K ^ data_in;
	 
      end
   end
   /*
   always @(posedge clk) begin
      case (state)
	`START : begin
	   if(start) state <= `PROGRESS;
	end
	`PROGRESS : begin
	   if(done) state <= `START;
	end
	default : state <= `START;
	
      endcase
   end
   assign valid = (state == `PROGRESS);
    */
   
   
endmodule // decrypt



