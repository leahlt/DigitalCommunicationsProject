module Alaw_tb();

reg [11:0] IN;
wire [7:0] OUT;

Alaw dut(IN, OUT);


initial begin

$display("Starting Alaw Standalone testbench test...");

IN <= 12'b 1000_0000_1111; //0 input
#10;

end


endmodule
