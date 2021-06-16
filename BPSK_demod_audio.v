module BPSK_demod_audio (in, DataOut);
parameter n=8; //default value is set for hamming, not BCH which needs 15 bits in
input [2*n-1:0] in;
output [n-1:0] DataOut;

wire out0, out1, out2, out3, out4, out5, out6, out7;
wire [15:0] max_size;


assign out0 = (0<= n) ? ((in[1:0] == 01) ? 0:1) : 00;
assign out1 = (1<= n) ? ((in[3:2] == 01) ? 0:1) : 00;
assign out2 = (2<= n) ? ((in[5:4] == 01) ? 0:1) : 00;
assign out3 = (3<= n) ? ((in[7:6] == 01) ? 0:1) : 00;
assign out4 = (4<= n) ? ((in[9:8] == 01) ? 0:1) : 00;
assign out5 = (5<= n) ? ((in[11:10] == 01) ? 0:1) : 00;
assign out6 = (6<= n) ? ((in[13:12] == 01) ? 0:1) : 00;
assign out7 = (7<= n) ? ((in[15:14] == 01) ? 0:1) : 00;


assign max_size = {out7, out6, out5, out4, out3, out2, out1, out0};

assign DataOut = max_size[n-1:0];

endmodule
 