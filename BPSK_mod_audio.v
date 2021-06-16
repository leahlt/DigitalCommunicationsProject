module BPSK_mod_audio (in, DataOut);
parameter n=8; //default value is set for hamming, not BCH which needs 15 bits in
input [n-1:0] in;
output [2*n-1:0] DataOut;

wire [1:0] out0, out1, out2, out3, out4, out5, out6, out7;
wire [29:0] max_size;
//if we are in range of the parameters, map 0s to 1 and 1s to -1
assign out0 = (0<= n) ? ((in[0] == 0) ? 01:11) : 00;
assign out1 = (1<= n) ? ((in[1] == 0) ? 01:11) : 00;
assign out2 = (2<= n) ? ((in[2] == 0) ? 01:11) : 00;
assign out3 = (3<= n) ? ((in[3] == 0) ? 01:11) : 00;
assign out4 = (4<= n) ? ((in[4] == 0) ? 01:11) : 00;
assign out5 = (5<= n) ? ((in[5] == 0) ? 01:11) : 00;
assign out6 = (6<= n) ? ((in[6] == 0) ? 01:11) : 00;
assign out7 = (7<= n) ? ((in[7] == 0) ? 01:11) : 00;


assign max_size = {out7, out6, out5, out4, out3, out2, out1, out0};

assign DataOut = max_size[2*n-1:0];
endmodule
 