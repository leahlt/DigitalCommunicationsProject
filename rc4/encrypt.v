
module encrypt(clk, rst, password, data_in, data_out, init_done, start, done);
   input wire clk, rst;
   input wire [7:0] password, data_in;
   output reg [7:0] data_out;
    wire 	    output_ready;
    wire [7:0] 	    K;
   reg [7:0] 	    prev_K;
   output wire 	    init_done;
   input wire 	    start;
   input wire 	    done;
   
   
   
   rc4 device(.clk(clk), .rst(rst), .output_ready(output_ready),.password_input(password),.K(K), .init_done(init_done), .start(start), .done(done));
   always @ (posedge clk) begin
      if(output_ready) begin
	 data_out = K ^ data_in;
      end
   end
   
endmodule // decrypt
