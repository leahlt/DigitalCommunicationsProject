module BER_tb();
reg [11:0] IN;
reg CLK, reset;
wire [49:0] Errors;
wire [11:0] OUT;
wire Error_flag;


topTest dut (IN, OUT, CLK, Errors, Error_flag, reset); 

initial forever begin
	   CLK = 0; 
		#10
		CLK = 1;
		#10;
end 

initial begin

reset <=1;
#30;
reset <=0;
#30;
$display("Starting BER testbench test...");
IN <= 12'b011001101010; //B input
#20;
IN <= 12'b1110_0110_1010; //B input
#20; //A input
IN <= 12'b1110_1111_1010; //B input
#20; //A input
IN <= 12'b1110_0100_11010; //B input
#20; //A input
IN <= 12'b1010_0110_1010; //B input
#20; //A input
IN <= 12'b1110_0010_1110; //B input
#20; //A input
IN <= 12'b0010_0110_1010; //B input
#20; //A input
IN <= 12'b0000_0110_1000; //B input
#20; //A input
IN <= 12'b0000_1111_1000; //B input
#20; //A input
IN <= 12'b0001_0100_1001; //B input
#20; //A input
IN <= 12'b0001_1110_1100; //B input
#20; //A input
IN <= 12'b011001101010; //B input
#20;
IN <= 12'b1110_0110_1010; //B input
#20; //A input
IN <= 12'b1110_1111_1010; //B input
#20; //A input
IN <= 12'b1110_0100_11010; //B input
#20; //A input
IN <= 12'b1010_0110_1010; //B input
#20; //A input
IN <= 12'b1110_0010_1110; //B input
#20; //A input
IN <= 12'b0010_0110_1010; //B input
#20; //A input
IN <= 12'b0000_0110_1000; //B input
#20; //A input
IN <= 12'b0000_1111_1000; //B input
#20; //A input
IN <= 12'b0001_0100_1001; //B input
#20; //A input
IN <= 12'b0001_1110_1100; //B input
#20; //A input
IN <= 12'b011001101010; //B input
#20;
IN <= 12'b1110_0110_1010; //B input
#20; //A input
IN <= 12'b1110_1111_1010; //B input
#20; //A input
IN <= 12'b1110_0100_11010; //B input
#20; //A input
IN <= 12'b1010_0110_1010; //B input
#20; //A input
IN <= 12'b1110_0010_1110; //B input
#20; //A input
IN <= 12'b0010_0110_1010; //B input
#20; //A input
IN <= 12'b0000_0110_1000; //B input
#20; //A input
IN <= 12'b0000_1111_1000; //B input
#20; //A input
IN <= 12'b0001_0100_1001; //B input
#20; //A input
IN <= 12'b0001_1110_1100; //B input
#20; //A input
IN <= 12'b011001101010; //B input
#20;
IN <= 12'b1110_0110_1010; //B input
#20; //A input
IN <= 12'b1110_1111_1010; //B input
#20; //A input
IN <= 12'b1110_0100_11010; //B input
#20; //A input
IN <= 12'b1010_0110_1010; //B input
#20; //A input
IN <= 12'b1110_0010_1110; //B input
#20; //A input
IN <= 12'b0010_0110_1010; //B input
#20; //A input
IN <= 12'b0000_0110_1000; //B input
#20; //A input
IN <= 12'b0000_1111_1000; //B input
#20; //A input
IN <= 12'b0001_0100_1001; //B input
#20; //A input
IN <= 12'b0001_1110_1100; //B input
#20; //A input


end

endmodule
