module compression_tb();
reg [7:0] IN;
reg CLK;
wire [7:0] OUT;

topTest dut (IN, OUT);

initial forever begin
	   CLK = 0; 
		#10
		CLK = 1;
		#10;
end 

initial begin


$display("Starting Compression testbench test...");
IN <= 8'b01000010; //B input
#10;
IN <= 8'b10101110; //A input
#10;
IN <= 8'b01000100; //D input
#10;
IN <= 8'b00100000; //  input
#10;
IN <= 8'b01000010; // B input
#10;
IN <= 8'b01101001; // i input
#10;
IN <= 8'b01110100; // t input
#10;
IN <= 8'b01100011; // c input
#10;
IN <= 8'b01101000; // h input
#10;
IN <= 8'b10100101; // ! input
#10;
IN <= 8'b01000000; // @ input
#10;
IN <= 8'b10010010; // deg input
#10;
IN <= 8'b10100011; // cent input
#10;
IN <= 8'b10000000; // ~ input
#10;
end
endmodule
