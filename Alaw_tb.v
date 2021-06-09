module Alaw_tb();

reg [11:0] IN;
wire [11:0] OUT;

topTest dut(IN, OUT);


initial begin

$display("Starting Alaw Standalone testbench test...");

IN <= 12'b 0010_0000_1100; //0 input
#50;

end


endmodule
