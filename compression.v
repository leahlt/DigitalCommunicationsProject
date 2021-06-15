module compression(IN, OUT);
input [7:0] IN;
output [6:0] OUT;


assign OUT = ((IN - 6'b100_000) == 8'd130) ? 7'd95 : //cent
						((IN - 6'b100_000) == 8'd131) ? 7'd97 : //euro
						((IN - 6'b100_000) == 8'd133) ? 7'd109 : //yen
						((IN - 6'b100_000) == 8'd137) ? 7'd111 : //copyright
						((IN - 6'b100_000) == 8'd142) ? 7'd112 : //r in circle
						((IN - 6'b100_000) == 8'd144) ? 7'd125 : //degree
						(IN < 8'd32) ? 7'd0:
						(IN > 8'd159) ? 7'd0:
						(IN - 6'b100_000); //do nothing

						
endmodule
