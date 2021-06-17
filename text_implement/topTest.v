module topTest(IN, OUT, CLK, errors, error_flag, reset);
input [11:0] IN;
input CLK, reset;
output [11:0] OUT;
output [49:0] errors;
output error_flag;

wire [15:0] temp;
wire [7:0] Alawed, demoded;

BPSK_mod  #(8) mod(Alawed,temp);
BPSK_demod  #(8) demod(temp, demoded);

//compression comp(IN, temp);
//decompression decomp(temp, OUT);

Alaw compress(IN, Alawed);
deAlaw decompress(demoded, OUT);

 BER_audio ber(
IN,
OUT,
CLK,
reset,
1'b1,		//enabled by the tx enable
errors,		// number of errors
error_flag	//is set when errorcount is full
);




endmodule
