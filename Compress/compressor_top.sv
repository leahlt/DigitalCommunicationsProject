module binaryToStr(binary, CLK, compressed);
input [511:0] binary;
input CLK;
output [1535:0] compressed;


reg [192-1:0] comp;
reg [64*8-1:0] text;

string textString ;
string compressedString;

stringTobin dut(binary, text); //convert binary input to a string

//assign textString = string'(text);
Compressor u1 (.CLK(CLK), .Input(binary), .Output(compressed)); //compress

//assign compressedString = string'(comp);
assign compressed = compressedString.atobin(); //convert compressed string into binary
 


endmodule
