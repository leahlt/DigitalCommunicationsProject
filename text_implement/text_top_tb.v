`timescale 10 ns / 1 ps

module text_top_tb();

    reg clk;
    reg reset;
    reg[3:0] KEY;
    wire [7:0] data_out;
   reg [7:0] data_in;
    //text_top DUT(clk,reset, data_in,  data_out);
   text_top DUT(clk, KEY);

    initial begin
        clk = 0;
        forever begin
	        #1;
	        clk <= ~clk;
        end
    end

    initial begin
        $readmemh ("contents.txt", DUT.source.S.altsyncram_component.m_default.altsyncram_inst.mem_data);
        reset = 0;
        KEY[3:0] = 4'b0;
        #5;
        reset = 1;
        #10;
        KEY[0] = 1'b1;
      // data_in = 63;
        #10000;
        $stop;     
    end
	

endmodule 