`timescale 10 ns / 1 ps

module mycircuit_tb();

    reg CLOCK_50, read_ready, write_ready, reset;
    wire read, write;
    reg [23:0] readdata_left, readdata_right;
    wire [23:0] writedata_left, writedata_right;
	mycircuit DUT(CLOCK_50, read_ready, write_ready, read, write, readdata_left, readdata_right, writedata_left, writedata_right, reset);

    initial begin
        CLOCK_50 = 0;
        forever begin
	        #1;
	        CLOCK_50 = ~CLOCK_50;
        end
    end

    initial begin
        read_ready = 0;
        write_ready = 0;
        readdata_left = 0;
        readdata_right = 0;
        #4;
        reset = 1;
        #6;
        reset = 0;
        #10;
        read_ready =1;
        write_ready = 1;
        readdata_left = 64;
        readdata_right =64;
        #10;
        write_ready = 1;
        readdata_left = 128;
        readdata_right =128;
        #10;
        write_ready = 1;
        readdata_left = 192;
        readdata_right =192;    
        #10;
        write_ready = 1;
        readdata_left = 256;
        readdata_right = 256;  

                #10;
        read_ready =1;
        write_ready = 1;
        readdata_left = 64;
        readdata_right =64;
        #10;
        write_ready = 1;
        readdata_left = 128;
        readdata_right =128;
        #10;
        write_ready = 1;
        readdata_left = 192;
        readdata_right =192;    
        #10;
        write_ready = 1;
        readdata_left = 256;
        readdata_right = 256; 
                #10;
        read_ready =1;
        write_ready = 1;
        readdata_left = 64;
        readdata_right =64;
        #10;
        write_ready = 1;
        readdata_left = 128;
        readdata_right =128;
        #10;
        write_ready = 1;
        readdata_left = 192;
        readdata_right =192;    
        #10;
        write_ready = 1;
        readdata_left = 256;
        readdata_right = 256; 
                #10;
        read_ready =1;
        write_ready = 1;
        readdata_left = 64;
        readdata_right =64;
        #10;
        write_ready = 1;
        readdata_left = 128;
        readdata_right =128;
        #10;
        write_ready = 1;
        readdata_left = 192;
        readdata_right =192;    
        #10;
        write_ready = 1;
        readdata_left = 256;
        readdata_right = 256; 

        #10000;
        $stop;     
    end
	

endmodule 