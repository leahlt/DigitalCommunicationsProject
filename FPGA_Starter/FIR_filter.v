module FIRfilter(IN, CLK, OUT);
input CLK;
input signed [23:0] IN;
output signed[23:0] OUT; //making this signed helped reduce white noise

wire signed [23:0] F1, F2, F3, F4, F5, F6, F7, D1, D2, D3, D4, D5, D6, D7, D8, A1, A2, A3, A4, A5, A6, A7;

//1
VariableDivider #(3) d1(IN, D1); 
VariableFlipFlop #(24) f1(IN, CLK, F1);

//2
VariableDivider #(3) d2(F1, D2);
VariableFlipFlop #(24) f2(F1, CLK, F2);
adder #(24) a1(D1,D2,A1);

//3
VariableDivider #(3) d3(F2, D3);
VariableFlipFlop #(24) f3(F2, CLK, F3);
adder #(24) a2(A1,D3,A2);

//4
VariableDivider #(3) d4(F3, D4);
VariableFlipFlop #(24) f4(F3, CLK, F4);
adder #(24) a3(A2,D4,A3);

//5
VariableDivider #(3) d5(F4, D5);
VariableFlipFlop #(24) f5(F4, CLK, F5);
adder #(24) a4(A3,D5,A4);

//6
VariableDivider #(3) d6(F5, D6);
VariableFlipFlop #(24) f6(F5, CLK, F6);
adder #(24) a5(A4,D6,A5);

//7
VariableDivider #(3) d7(F6, D7);
VariableFlipFlop #(24) f7(F6, CLK, F7);
adder #(24) a6(A5,D7,A6);

//last divider (8)
VariableDivider #(3) d8(F7, D8);
adder #(24) a7(A6,D8,A7);

assign OUT=A7;

endmodule
