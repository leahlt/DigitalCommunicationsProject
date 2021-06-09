`timescale 1 ns / 100ps
`define Bi 	16	              // Input width
`define DATA 320000          // total input data  

module awgn_tb;
    
reg     clk1;
reg     reset1;
reg     read1;
reg     signed[`Bi-1:0]X_in1_real;
reg     signed[`Bi-1:0]X_in1_imag;
wire    busy1;
wire    [`Bi-1:0]Y_out1_real;
wire    [`Bi-1:0]Y_out1_imag;
wire    [11:0] sum_real_n_truncation1;

integer data_real_in, data_imag_in, data_real_out, data_imag_out, num, k;
integer Y_out1_real_temp, Y_out1_imag_temp, temp_real, temp_imag;
integer data_noise_real_n_out, sum_real_n_truncation1_temp;

awgn wgn_noise(.clk(clk1),
               .reset(reset1),
               .read(read1),
               .busy(busy1),
               .X_in_real(X_in1_real),
               .X_in_imag(X_in1_imag),
               .Y_out_real(Y_out1_real),
               .Y_out_imag(Y_out1_imag),
               .sum_real_n_truncation(sum_real_n_truncation1));

initial                                                        
begin
    data_real_in = $fopen("input_real_data_320000.txt","r");
    data_imag_in = $fopen("input_imag_data_320000.txt","r");
    data_real_out = $fopen("real_signal_with_awgn_output_8dB.txt");
    data_imag_out = $fopen("imag_signal_with_awgn_output_8dB.txt");
    data_noise_real_n_out = $fopen("data_noise_real_n_out.txt");
    #0  clk1 = 0;
    #0   num = 0;
    #0     k = 0;
    #0 reset1 = 1'b1;
    #15 reset1 = 1'b0;
    #20 read1 = 1'b1;
    #3300000 
    $finish;
end
   
always
begin
    #5 clk1 = 1'b1;
    #5 clk1 = 1'b0;
end
     
always@(posedge clk1)
begin
    if(read1==1 && num < `DATA)
    begin
        temp_real = $fscanf(data_real_in,"%d",X_in1_real);
        temp_imag = $fscanf(data_imag_in,"%d",X_in1_imag);
        num=num+1;                               
    end
    else                 
    begin                                                                  
        X_in1_real <= X_in1_real; 
        X_in1_imag <= X_in1_imag;                                                                           
    end
end      

always@(posedge clk1)
begin
    if(busy1==1 && k < `DATA)
    begin
        Y_out1_real_temp = Y_out1_real;
        Y_out1_imag_temp = Y_out1_imag;
        sum_real_n_truncation1_temp = sum_real_n_truncation1;
        $fdisplay(data_real_out, "%d",(Y_out1_real_temp < 32768?Y_out1_real_temp:Y_out1_real_temp-65536) );
        $fdisplay(data_imag_out, "%d",(Y_out1_imag_temp < 32768?Y_out1_imag_temp:Y_out1_imag_temp-65536) );
        $fdisplay(data_noise_real_n_out, "%d",(sum_real_n_truncation1_temp < 2048?sum_real_n_truncation1_temp:sum_real_n_truncation1_temp-4096) );
        k = k+1;
    end
end                                                                             
 	                                   
endmodule