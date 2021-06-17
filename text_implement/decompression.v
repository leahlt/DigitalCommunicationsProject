module decompression(IN, OUT);
input [6:0] IN;
output [7:0] OUT;


assign OUT = (IN == 7'd95) ? 8'd130+ 6'b100_000 : //cent
						(IN == 7'd97) ? 8'd131 + 6'b100_000 : //euro
						(IN == 7'd109) ?  8'd133 + 6'b100_000: //yen
						(IN == 7'd111) ? 8'd137 + 6'b100_000: //copyright
						(IN == 7'd112) ? 8'd142 + 6'b100_000: //r in circle
						(IN ==  7'd125) ? 8'd144 + 6'b100_000: //degree
						(IN + 6'b100_000); //do nothing

						
endmodule