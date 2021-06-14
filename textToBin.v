module textToBin(string, binary);
input [7:0] string;
output [7:0] binary;

 
assign binary = (string == "A") ? 8'b0100_0001:
				(string == "B") ? 8'b01000010:
				(string == "C") ? 8'b01000011:
				(string == "D") ? 8'b01000100:
				(string == "E") ? 8'b01000101:
				(string == "F") ? 8'b01000110:
				(string == "G") ? 8'b01000111:
				(string == "H") ? 8'b01001000:
				(string == "I") ? 8'b01001001:
				(string == "J") ? 8'b01001010:
				(string == "K") ? 8'b01001011:
				(string == "L") ? 8'b01001100:
				(string == "M") ? 8'b01001101:
				(string == "N") ? 8'b01001110:
				(string == "O") ? 8'b01001111:
				(string == "P") ? 8'b01010000:
				(string == "Q") ? 8'b01010001:
				(string == "R") ? 8'b01010010:
				(string == "S") ? 8'b01010011:
				(string == "T") ? 8'b01010100:
				(string == "U") ? 8'b01010101:
				(string == "V") ? 8'b01010110:
				(string == "W") ? 8'b01010111:
				(string == "X") ? 8'b01011000:
				(string == "Y") ? 8'b01011001:
				(string == "Z") ? 8'b01011010:
				(string == "a") ? 8'b01100001:
				(string == "b") ? 8'b01100010:
				(string == "c") ? 8'b01100011:
				(string == "d") ? 8'b01100100:
				(string == "e") ? 8'b01100101:
				(string == "f") ? 8'b01100110:
				(string == "g") ? 8'b01100111:
				(string == "h") ? 8'b01101000:
				(string == "i") ? 8'b01101001:
				(string == "j") ? 8'b01101010:
				(string == "k") ? 8'b01101011:
				(string == "l") ? 8'b01101100:
				(string == "m") ? 8'b01101101:
				(string == "n") ? 8'b01101110:
				(string == "o") ? 8'b01101111:
				(string == "p") ? 8'b01110000:
				(string == "q") ? 8'b01110001:
				(string == "r") ? 8'b01110010:
				(string == "s") ? 8'b01110011:
				(string == "t") ? 8'b01110100:
				(string == "u") ? 8'b01110101:
				(string == "v") ? 8'b01110110:
				(string == "w") ? 8'b01110111:
				(string == "x") ? 8'b01111000:
				(string == "y") ? 8'b01111001:
				(string == "z") ? 8'b01111010:
				(string == " ") ? 8'b00100000:
				(string == "1") ? 8'b00110001:
				(string == "2") ? 8'b00110010:
				(string == "3") ? 8'b00110011:
				(string == "4") ? 8'b00110100:
				(string == "5") ? 8'b00110101:
				(string == "6") ? 8'b00110110:
				(string == "7") ? 8'b00110111:
				(string == "8") ? 8'b00111000:
				(string == "9") ? 8'b00111001:
				(string == "0") ? 8'b00110000:
				(string == "-") ? 8'b00101101:
				(string == "=") ? 8'b00111101:
				(string == "`") ? 8'b01100000:
				(string == "~") ? 8'b01111110:
				(string == "!") ? 8'b00100001:
				(string == "@") ? 8'b01000000:
				(string == "#") ? 8'b00100011:
				(string == "$") ? 8'b00100100:
				(string == "^") ? 8'b01011110:
				(string == "&") ? 8'b00100110:
				(string == "*") ? 8'b00101010:
				(string == "(") ? 8'b00101000:
				(string == ")") ? 8'b00101001:
				(string == "_") ? 8'b01011111:
				(string == "+") ? 8'b00101011:
				(string == "[") ? 8'b01011011:
				(string == "]") ? 8'b01011101:
				(string == "{") ? 8'b01111011:
				(string == "}") ? 8'b01111101:
				(string == "|") ? 8'b01111100:
				(string == ";") ? 8'b00111011:
				(string == ":") ? 8'b00111010:
				(string == "'") ? 8'b00100111:
				(string == "<") ? 8'b00111100:
				(string == ">") ? 8'b00111110:
				(string == ",") ? 8'b00101100:
				(string == ".") ? 8'b00101110:
				(string == "/") ? 8'b00101111:
				(string == "?") ? 8'b00111111:
				//(string == "\\") ? 8'b01011100:
				//(string == "\ "") ? 8'b00100010:
				(string == "\n") ? 8'b00001101:
				8'b00100000;
				


endmodule
