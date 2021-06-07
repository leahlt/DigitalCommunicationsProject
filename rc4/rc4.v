`define KEY_SIZE 7
module rc4(clk,rst,output_ready,password_input,K, init_done, rdy, done);

input clk; // Clock
input rst; // Reset
input [7:0] password_input; // Password input
output output_ready; // Output valid
output [7:0] K; // Output port
   input     done;
   

wire clk, rst; // clock, reset
reg output_ready;
wire [7:0] password_input;
output wire    init_done;
input wire  start;
   input wire rdy;
   
   

/* RC4 PRGA */

// Key
reg [7:0] key;
// S array
reg [7:0] S[0:256];
reg [9:0] discardCount;

// Key-scheduling state
`define KSS_KEYREAD 4'h0
`define KSS_KEYSCHED1 4'h1
`define KSS_KEYSCHED2 4'h2
`define KSS_KEYSCHED3 4'h3
`define KSS_CRYPTO 	 4'h4
`define KSS_CRYPTO2 	 4'h5
`define RST_STATE 4'h6
`define RDY_STATE 4'h7
`define DONE_STATE 4'h8
   
// Variable names from http://en.wikipedia.org/wiki/RC4
   reg [3:0] KSState;
reg [7:0] i; // Counter
reg [7:0] j;
reg [7:0] K;
   reg [7:0] temp_K;
   
reg [7:0] tmp;

always @ (posedge clk or posedge rst) begin

	case (KSState)	
	  `KSS_KEYREAD:	begin // KSS_KEYREAD state: Read key from input
	     if (rst) KSState <= `RST_STATE;
	     else begin
		      KSState <= `KSS_KEYSCHED1;
		key <= password_input;
		temp_K <= password_input;
		
	     end 
	  end
	  /*
for i from 0 to 255
    S[i] := i
endfor
*/
	  `KSS_KEYSCHED1:	begin // KSS_KEYSCHED1: Increment counter for S initialization
	     if(rst) KSState <= `RST_STATE;
	     else begin
		S[i] <= i;
		if (i == 8'hFF)
		  begin
		     KSState <= `KSS_KEYSCHED2;
		     i <= 8'h00;
		  end
		else	i <= i +1;
	     end
	  end // case: `KSS_KEYSCHED1
	  
/*		
j := 0
for i from 0 to 255
    j := (j + S[i] + key[i mod keylength]) mod 256
    swap values of S[i] and S[j]
endfor
*/
	  `KSS_KEYSCHED2:	begin // KSS_KEYSCHED2: Initialize S array
	     if(rst) KSState <= `RST_STATE;
	     else begin
		j <= (j + S[i] + key[i % `KEY_SIZE]);
		KSState <= `KSS_KEYSCHED3;
	     end
	  end
	  
	  `KSS_KEYSCHED3:	begin // KSS_KEYSCHED3: S array permutation
	     if(rst) KSState <= `RST_STATE;
	     else begin
		S[i]<=S[j];
		S[j]<=S[i];
		if (i == 8'hFF)
		  begin
		     KSState <= `KSS_CRYPTO;
		     i <= 8'h01;
		     j <= S[1];
		     discardCount <= 10'h0;
		     output_ready <= 0; // K not valid yet
		     
		  end
		else	begin
		   i <= i + 1;
		   KSState <= `KSS_KEYSCHED2;
		end
	     end // else: !if(rst)
	  end
/*				
i := 0
j := 0
while GeneratingOutput:
    i := (i + 1) mod 256
    j := (j + S[i]) mod 256
    swap values of S[i] and S[j]
    K := S[(S[i] + S[j]) mod 256]
    output K
endwhile
*/

	  
	  `KSS_CRYPTO: begin
	     if(rst) KSState <= `RST_STATE;
	     else begin
		S[i] <= S[j];
		S[j] <= S[i]; // We can do this because of verilog.
		tmp<=S[i]+S[j];
		KSState <= `KSS_CRYPTO2;
		output_ready <= 0; 
	     end
	  end
	  
	  `KSS_CRYPTO2: begin
	     if(rst) KSState <= `RST_STATE;
	     else begin
		K <= S[tmp];//S[ S[i]+S[j] ];

		output_ready <= 1; // Valid K at output
		i <= i+1;
		// Here is the secret of 1-clock: we develop all possible values of j in the future
		if (j==i+1) 
   		  j <= (j + S[i]);
		else
		  if (i==255) j <= (j + S[0]);
		  else j <= (j + S[i+1]);
	//	$display ("rc4: output = %08X",K);
		if(done) KSState <= `DONE_STATE;
		
		KSState <= `KSS_CRYPTO;
	     end // else: !if(rst)
	     K <= temp_K;
	     
	  end // case: `KSS_CRYPTO2
	  
	  `RST_STATE: begin
	     i <= 8'h0;
	     KSState <= `KSS_KEYREAD;
	     output_ready <= 0;
	     j <= 0; 
	  end
	  `DONE_STATE: begin
	     KSState <= `RDY_STATE;
	  end
	  
	  
	  default:	KSState <= `RST_STATE;
	  
	endcase
end 

   assign init_done = (KSState == `KSS_CRYPTO || KSState == `KSS_CRYPTO2 || KSState == `RDY_STATE);
   
endmodule
