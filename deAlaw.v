module deAlaw(INPUT, OUTPUT);
input [7:0] INPUT;
output [11:0] OUTPUT;

wire [11:0] y, data2;
wire [7:0] data1, x;
wire [2:0] a;
wire [4:0] b;
wire negative;


//Convert to positive (via 2s complement) if the input is negative
assign negative = INPUT[7]; //hold the +/- value of the input
assign data1 = INPUT[7] ? ~INPUT + 1: INPUT;

assign a = data1[2:0]; //get last 3 bits not including sign xxx
assign b = data1[7:3]; //gets the first 4 bits

assign x = (a!=0) ? (2**a) : 2;
assign y = x * (b+1);
assign data2 = y + (16*(2**a));

assign OUTPUT = negative? ~data2 + 1: data2;	


endmodule
