module mycircuit(CLOCK_50, read_ready, write_ready, read, write, readdata_left, readdata_right, writedata_left, writedata_right, reset);

	wire signed [23:0] noise;
	//noise_generator ng(.clk(CLOCK_50), .enable(1), .Q(noise));

    input wire CLOCK_50, read_ready, write_ready,reset;
    output wire read, write;
    input wire [23:0] readdata_left, readdata_right;
    output wire signed [23:0] writedata_left, writedata_right;

    wire signed [23:0] s_readdata_left;
    wire signed [23:0] s_readdata_right;


    wire signed [23:0] temp_left_in;
	wire signed [23:0] temp_right_in;

	wire [5:0] addr;
	reg signed [23:0] ldata_in;
	wire signed [23:0] ldata_out;
	reg lren, lwren;
	wire lempty, lfull;

	reg signed [23:0] rdata_in;
	wire signed [23:0] rdata_out;
	reg rren, rwren;
	wire rempty, rfull;
	reg signed [23:0] laccum, raccum;

	reg signed [23:0] lsum2, rsum2;
    wire signed [23:0] lsum1, rsum1;


	ram2 lfifo(.clock(CLOCK_50), .data(ldata_in), .rdreq(lren), .wrreq(lwren), .empty(lempty), .full(lfull), .q(ldata_out));
	ram2 rfifo(.clock(CLOCK_50), .data(rdata_in), .rdreq(rren), .wrreq(rwren), .empty(rempty), .full(rfull), .q(rdata_out));

    assign s_readdata_left = readdata_left; //+ noise;
    assign s_readdata_right = readdata_right; // + noise;
//---------------adjust here for n---------------------------------------------





    assign temp_left_in = s_readdata_left >>> 8;
    assign temp_right_in = s_readdata_right >>> 8;  




	
//-----------------------------------------------------------------------

	always @(posedge CLOCK_50) begin
        lren <= 0;
        rren <= 0;
        lwren <= 0;
        rwren <= 0;      
		if(read_ready) begin
            
		    if (!lfull && !rfull) begin
				lren <= 0;
				rren <= 0;
				lwren <= 1;
				rwren <= 1;
				ldata_in <= temp_left_in;
				rdata_in <= temp_right_in; 
			end
			if( lfull) begin
				lwren <= 0;
				rwren <= 0;
				lren <= 1;
				rren <= 1;
			end
		end
	end

	assign lsum1 = (read_ready) ? temp_left_in - ldata_out : 0;
	assign rsum1 = (read_ready) ? temp_right_in - rdata_out : 0;

	always @(posedge CLOCK_50) begin

        if(reset) begin
            raccum <= 0;
            laccum <= 0;
            lsum2 <= 0;
            rsum2 <= 0;
            
        end
        else begin 
            if(read_ready) begin
                laccum <= lsum2;
                raccum <= rsum2;
                lsum2 <= laccum + lsum1;
                rsum2 <= raccum + rsum1;
            end
        end
	end

	assign writedata_left = lsum2;
	assign writedata_right =  rsum2;

    assign write = (write_ready) ? 1 : 0;
	assign read = (read_ready) ? 1 : 0;
	
	
endmodule