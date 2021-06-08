module Alaw(INPUT, OUTPUT);
input [11:0] INPUT;
output [7:0] OUTPUT;

wire [11:0] data1, data2, data3;
wire [2:0] x;
wire [4:0] w;
wire[7:0] y;
wire negative; 

//Convert to positive (via 2s complement) if the input is negative
assign negative = INPUT[11]; //hold the +/- value of the input
assign data1 = INPUT[11] ? ~INPUT + 1: INPUT;

//pseudo for-loop from 0 to 8 to find the variable x to multiply by
assign x = (data1<(32*(2**0)))?0:
			(data1<(32*(2**1)))?1:
			(data1<(32*(2**2)))?2:
			(data1<(32*(2**3)))?3:
			(data1<(32*(2**4)))?4:
			(data1<(32*(2**5)))?5:
			(data1<(32*(2**6)))?6:7;

assign data2 = data1-(16*(2**x));

//init variable y
assign y = (x!=0)?(2**x):2;

//pseudo for-loop from 1-32 to find variable w
assign w = (data2<(y*1))?0:
			(data2<(y*2))?1:
			(data2<(y*3))?2:
			(data2<(y*4))?3:
			(data2<(y*5))?4:
			(data2<(y*6))?5:
			(data2<(y*7))?6:
			(data2<(y*8))?7:
			(data2<(y*9))?8:
			(data2<(y*10))?9:
			(data2<(y*11))?10:
			(data2<(y*12))?11:
			(data2<(y*13))?12:
			(data2<(y*14))?13:
			(data2<(y*15))?14:
			(data2<(y*16))?15:
			(data2<(y*17))?16:
			(data2<(y*18))?17:
			(data2<(y*19))?18:
			(data2<(y*20))?19:
			(data2<(y*21))?20:
			(data2<(y*22))?21:
			(data2<(y*23))?22:
			(data2<(y*24))?23:
			(data2<(y*25))?24:
			(data2<(y*26))?25:
			(data2<(y*27))?26:
			(data2<(y*28))?27:
			(data2<(y*29))?28:
			(data2<(y*30))?29:
			(data2<(y*31))?30:31;

assign data3 = {x,w};

//check and make negative again if needed

assign OUTPUT = negative? ~data3 + 1: data3;		
			

endmodule
