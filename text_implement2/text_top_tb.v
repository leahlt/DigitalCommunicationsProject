`timescale 10 ns / 1 ps

module text_top_tb();

    reg clk;
    reg reset;
    wire [7:0] data_out;
    reg [7:0] data_in;
    //text_top DUT(clk,reset, data_in,  data_out);
    text_top DUT(clk,reset,  data_out);

    initial begin
        clk = 0;
        forever begin
	        #1;
	        clk <= ~clk;
        end
    end

    initial begin
        $readmemh ("contents.txt", DUT.source.mem.altsyncram_component.m_default.altsyncram_inst.mem_data);
        reset = 1;
        #5;
        reset = 0;
        #10;
        //data_in = 61;
        #10000;
        $stop;     
    end
	

endmodule 