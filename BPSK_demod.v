module BPSK_demod (in, DataOut);
parameter n=8; //default value is set for hamming, not BCH which needs 15 bits in
input [2*n-1:0] in;
output [n-1:0] DataOut;

wire out0, out1, out2, out3, out4, out5, out6, out7, out8, out9, out10, out11, out12, out13, out14;
wire [15:0] max_size;


assign out0 = (0<= n) ? ((in[1:0] == 01) ? 0:1) : 00;
assign out1 = (1<= n) ? ((in[3:2] == 01) ? 0:1) : 00;
assign out2 = (2<= n) ? ((in[5:4] == 01) ? 0:1) : 00;
assign out3 = (3<= n) ? ((in[7:6] == 01) ? 0:1) : 00;
assign out4 = (4<= n) ? ((in[9:8] == 01) ? 0:1) : 00;
assign out5 = (5<= n) ? ((in[11:10] == 01) ? 0:1) : 00;
assign out6 = (6<= n) ? ((in[13:12] == 01) ? 0:1) : 00;
assign out7 = (7<= n) ? ((in[15:14] == 01) ? 0:1) : 00;
assign out8 = (8<= n) ? ((in[17:16] == 01) ? 0:1) : 00;
assign out9 = (9<= n) ? ((in[19:18] == 01) ? 0:1) : 00;
assign out10 = (10<= n) ? ((in[21:20] == 01) ? 0:1) : 00;
assign out11 = (11<= n) ? ((in[23:22] == 01) ? 0:1) : 00;
assign out12 = (12<= n) ? ((in[25:24] == 01) ? 0:1) : 00;
assign out13 = (13<= n) ? ((in[27:26] == 01) ? 0:1) : 00;
assign out14 = (14<= n) ? ((in[29:28] == 01) ? 0:1) : 00;

assign max_size = {out14, out13, out12, out11, out10, out9, out8, out7, out6, out5, out4, out3, out2, out1, out0};

assign DataOut = max_size[n-1:0];

endmodule
 