module tx(clk, data_in, b0, b1, b2, b3, b4, b5, b6, b7, b8, b9, b10, b11, b12, b13, b14, b15, b16, b17, b18, b19, b20, b21, b22, b23);
   input clk;
   input [23:0] data_in;
   output reg [24:0] b0 = 0;
   output reg [24:0] b1 = 0;
   output reg [24:0] b2 = 0;
   output reg [24:0] b3 = 0;
   output reg [24:0] b4 = 0;
   output reg [24:0] b5 = 0;
   output reg [24:0] b6 = 0;
   output reg [24:0] b7 = 0;
   output reg [24:0] b8 = 0;
   output reg [24:0] b9 = 0;
   output reg [24:0] b10 = 0;
   output reg [24:0] b11 = 0;
   output reg [24:0] b12 = 0;
   output reg [24:0] b13 = 0;
   output reg [24:0] b14 = 0;
   output reg [24:0] b15 = 0;
   output reg [24:0] b16 = 0;
   output reg [24:0] b17 = 0;
   output reg [24:0] b18 = 0;
   output reg [24:0] b19 = 0;
   output reg [24:0] b20 = 0;
   output reg [24:0] b21 = 0;
   output reg [24:0] b22 = 0;
   output reg [24:0] b23 = 0;
   always @ (posedge clk) begin
      b0 = {data_in[0], 24'b0};
      b1 = {data_in[1], 24'b0};
      b2 = {data_in[2], 24'b0};
      b3 = {data_in[3], 24'b0};
      b4 = {data_in[4], 24'b0};
      b5 = {data_in[5], 24'b0};
      b6 = {data_in[6], 24'b0};
      b7 = {data_in[7], 24'b0};
      b8 = {data_in[8], 24'b0};
      b9 = {data_in[9], 24'b0};
      b10 = {data_in[10], 24'b0};
      b11 = {data_in[11], 24'b0};
      b12 = {data_in[12], 24'b0};
      b13 = {data_in[13], 24'b0};
      b14 = {data_in[14], 24'b0};
      b15 = {data_in[15], 24'b0};
      b16 = {data_in[16], 24'b0};
      b17 = {data_in[17], 24'b0};
      b18 = {data_in[18], 24'b0};
      b19 = {data_in[19], 24'b0};
      b20 = {data_in[20], 24'b0};
      b21 = {data_in[21], 24'b0};
      b22 = {data_in[22], 24'b0};
      b23 = {data_in[23], 24'b0};   
   end

endmodule

module rx(clk, b0, b1, b2, b3, b4, b5, b6, b7, b8, b9, b10, b11, b12, b13, b14, b15, b16, b17, b18, b19, b20, b21, b22, b23, data_out);
   input clk;
   input [24:0] b0;
   input [24:0] b1;
   input [24:0] b2;
   input [24:0] b3;
   input [24:0] b4;
   input [24:0] b5;
   input [24:0] b6;
   input [24:0] b7;
   input [24:0] b8;
   input [24:0] b9;
   input [24:0] b10;
   input [24:0] b11;
   input [24:0] b12;
   input [24:0] b13;
   input [24:0] b14;
   input [24:0] b15;
   input [24:0] b16;
   input [24:0] b17;
   input [24:0] b18;
   input [24:0] b19;
   input [24:0] b20;
   input [24:0] b21;
   input [24:0] b22;
   input [24:0] b23;
   output [23:0] data_out;
   assign data_out = {b23[24], b22[24], b21[24], b20[24], b19[24], b18[24], b17[24], b16[24], b15[24], b14[24], b13[24], b12[24], b11[24], b10[24], b9[24], b8[24], b7[24], b6[24], b5[24], b4[24], b3[24], b2[24], b1[24], b0[24]};


endmodule // rx

module channel(input clk, input reset, input [23:0] data_in, output [23:0] data_out);
 wire [24:0]  b0, b1, b2, b3, b4, b5, b6, b7, b8, b9, b10, b11, b12,b13,b14,b15,b16,b17,b18,b19,b20,b21,b22,b23;
   wire [24:0]  b0n, b1n, b2n, b3n, b4n, b5n, b6n, b7n, b8n, b9n, b10n, b11n, b12n, b13n,b14n,b15n,b16n,b17n,b18n,b19n,b20n,b21n,b22n,b23n;

   wire        busy, sum_real_n_truncation;
      wire [23:0]  Y_out_real, Y_out_imag;
 tx trans(clk, data_in, b0, b1, b2, b3, b4, b5, b6, b7, b8,b9,b10,b11,b12,b13,b14,b15,b16,b17,b18,b19,b20,b21,b22,b23);
   awgn noise(clk, reset, 1'b1, data_in, 1'b0, busy, Y_out_real, Y_out_imag, sum_real_n_truncation);

   assign b0n = b0 + Y_out_real;
assign b1n = b1 + Y_out_real;
   assign b2n = b2 + Y_out_real;
   assign b3n = b3 + Y_out_real;
   assign b4n = b4 + Y_out_real;
   assign b5n = b5 + Y_out_real;
   assign b6n = b6 + Y_out_real;
   assign b7n = b7 + Y_out_real;
   assign b8n = b8 + Y_out_real;

   assign b9n = b9 + Y_out_real;
   assign b10n = b10 + Y_out_real;
   assign b11n = b11 + Y_out_real;
   assign b12n = b12 + Y_out_real;
   assign b13n = b13 + Y_out_real;
   assign b14n = b14 + Y_out_real;
   assign b15n = b15 + Y_out_real;
   assign b16n = b16 + Y_out_real;
   assign b17n = b17 + Y_out_real;
   assign b18n = b18 + Y_out_real;
   assign b19n = b19 + Y_out_real;
   assign b20n = b20 + Y_out_real;
   assign b21n = b21 + Y_out_real;
   assign b22n = b22 + Y_out_real;
   assign b23n = b23 + Y_out_real;   
   rx rec (clk, b0n, b1n, b2n, b3n, b4n, b5n, b6n, b7n, b8n, b9n, b10n, b11n, b12n, b13n, b14n, b15n, b16n, b17n, b18n, b19n, b20n, b21n, b22n, b23n,  data_out);
   endmodule
