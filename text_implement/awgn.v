/**********************************************************************************************/
// The f_x1 sequence is construncted using the primitive polynomial
// 1+ x^1 + x^5 + x^6 + x^8
// The f_x1 is initialized with f_x1=18'h3ffff

// The g_x2_cos sequence is construncted using the primitive polynomial
// 1+ x^1 + x^5 + x^6 + x^8
// The g_x2_cos is initialized with g_x2_cos=10'h3ff

// The g_x2_sin sequence is construncted using the primitive polynomial
//1+ x^1 + x^5 + x^6 + x^8
// The g_x2_sin is initialized with g_x2_cos=10'b1000000000

// The noise out n_real = sigma*(f_x1 * g_x2_cos)
// The noise out n_imag = sigma*(f_x1 * g_x2_sin)

// The Y_out_real = X_in_real + n_real
// The Y_out_imag = X_in_imag + n_imag
/**********************************************************************************************/


`timescale 1 ns / 100ps
`define Bi 	8	                 //Input data width
`define SNR_dB 8                //SNR_dB value
`define DATA 320000             //Total input data


module awgn(clk,reset,read,X_in_real,X_in_imag,busy,Y_out_real,Y_out_imag, sum_real_n_truncation);
    
input    clk;
input    reset;
input    read;
input    signed [`Bi-1:0] X_in_real;
input    signed [`Bi-1:0] X_in_imag;
output   busy;
output   [`Bi-1:0] Y_out_real = 0;  
output   [`Bi-1:0] Y_out_imag;
output   [11:0] sum_real_n_truncation;

reg signed     [`Bi-1:0] Y_out_real = 0;
reg signed     [`Bi-1:0] Y_out_imag = 0;
reg      busy;
reg      [7:0] f_x1_step1;
reg      [7:0] f_x1_step2;
reg      [7:0] f_x1_step3;
reg      [7:0] f_x1_step4;
reg      [7:0] f_x1_step5;
reg      [7:0] f_x1_step6;
reg      [7:0] f_x1_high_step;
reg      [9:0] f_x1_step1_out;
reg      [9:0] f_x1_step2_out;
reg      [9:0] f_x1_step3_out;
reg      [9:0] f_x1_step4_out;
reg      [10:0] f_x1_step5_out;
reg      [10:0] f_x1_step6_out;
reg      [9:0] f_x1_high_step_out;
reg      [16:0] f_x1_step1_out_temp;
reg      [15:0] f_x1_step2_out_temp;
reg      [15:0] f_x1_step3_out_temp;
reg      [15:0] f_x1_step4_out_temp;
reg      [15:0] f_x1_step5_out_temp;
reg      [15:0] f_x1_step6_out_temp;
reg      [15:0] f_x1_high_step_out_temp;

reg      signed [8:0] g_x2_cos;
reg      signed [8:0] g_x2_cos_step;
reg      signed [16:0] g_x2_cos_step_temp;
reg      signed [8:0] g_x2_cos_out;
reg      signed [16:0] g_x2_cos_out_temp;
reg      signed [8:0] g_x2_cos_step_out;
reg      signed [8:0] temp_g_x2_cos;
reg      signed [`Bi-1:0] temp_X_in_real;
reg      signed [`Bi-1:0] temp_X_in_imag;
reg      signed [27:0] sum_real_n_temp;
reg      signed [19:0] sum_real_n;
reg      signed [27:0] noise_real;
reg      signed [11:0] sum_real_n_truncation;
reg      signed [11:0] noise_real_truncation;

reg      [7:0] step_gap1;
reg      [7:0] step_gap2;
reg      [7:0] step_gap3;
reg      [7:0] step_gap4;
reg      [7:0] step_gap5;
reg      [7:0] g_x2_gap;

wire     [2:0] f_x1_step1_xor_out;
wire     [2:0] f_x1_step2_xor_out;
wire     [2:0] f_x1_step3_xor_out;
wire     [2:0] f_x1_step4_xor_out;
wire     [2:0] f_x1_step5_xor_out;
wire     [2:0] f_x1_step6_xor_out;
wire     [2:0] f_x1_high_step_xor_out;
wire     [1:0] g_xor_out_cos;
wire     [1:0] g_x2_cos_step_xor_out;

parameter step1 = 424; //step1=1.665*255
parameter step2 = 600; //step2=2.355*255
parameter step3 = 735; //step3=2.884*255
parameter step4 = 849; //step4=3.33*255
parameter step5 = 949; //step5=3.723*255
parameter high_step = 62; //high_step=0.246*255
parameter g_x2_step_high=242; //g_x2_step_high=0.95*255
parameter g_x2_step_low=-242; //g_x2_step_low=-0.95*255
parameter sqrt_2 = 360; //sqrt_2=1.414*255

parameter sigma_0dB=180; //sigma_0dB=0.707*255
parameter sigma_1dB=161; //sigma_1dB=0.63*255
parameter sigma_2dB=143; //sigma_2dB=0.562*255
parameter sigma_3dB=128; //sigma_3dB=0.5*255
parameter sigma_4dB=114; //sigma_4dB=0.4462*255
parameter sigma_5dB=102; //sigma_5dB=0.398*255
parameter sigma_6dB=90; //sigma_6dB=0.354*255
parameter sigma_7dB=81; //sigma_7dB=0.316*255
parameter sigma_8dB=72; //sigma_8dB=0.2815*255
parameter sigma_9dB=64; //sigma_9dB=0.251*255

integer i, j, temp_f_x1,sin, temp_noise_real_integer, temp_noise_imag_integer;
integer sum_real_n_temp_integer, g_x2_cos_out_integer;

//real sigma_0dB=0.7071;
//real sigma_1dB=0.63, sigma_2dB=0.562, sigma_3dB=0.5,sigma_4dB=0.4462,
//     sigma_5dB=0.398, sigma_6dB=0.354, sigma_7dB=0.316, sigma_8dB=0.2815, sigma_9dB=0.251;
//real step_gap1=0.69, step_gap2=0.529, step_gap3=0.446, step_gap4=0.393, step_gap5=0.356;
//real high_step=0.246;
//real step1=1.665, step2=2.355, step3=2.884, step4=3.33, step5=3.723;
//real g_x2_step_high=0.95, g_x2_step_low=-0.95;
//real g_x2_gap=0.05;
//real sqrt_2=1.414;


initial
begin
    step_gap1 = 8'b10110000; //step_gap1=0.69
    step_gap2 = 8'b10000111; //step_gap1=0.529
    step_gap3 = 8'b01110010; //step_gap1=0.446
    step_gap4 = 8'b01100100; //step_gap1=0.393
    step_gap5 = 8'b01011011; //step_gap1=0.356
    g_x2_gap = 8'b00001100; //g_x2_gap=0.05
    busy=0;
    i=0;
    j=1;
end

always@ (posedge clk)
begin
    if(reset==1'b0 && read==1'b1 && i < `DATA)
    begin
        temp_X_in_real=X_in_real;
        temp_X_in_imag=X_in_imag;
        i=i+1;
        busy=1;
    end
end

assign f_x1_step1_xor_out = f_x1_step1[0] + f_x1_step1[1] + f_x1_step1[5] +f_x1_step1[6];
assign f_x1_step2_xor_out = f_x1_step2[0] + f_x1_step2[1] + f_x1_step2[5] +f_x1_step2[6];
assign f_x1_step3_xor_out = f_x1_step3[0] + f_x1_step3[1] + f_x1_step3[5] +f_x1_step3[6];
assign f_x1_step4_xor_out = f_x1_step4[0] + f_x1_step4[1] + f_x1_step4[5] +f_x1_step4[6];
assign f_x1_step5_xor_out = f_x1_step5[0] + f_x1_step5[1] + f_x1_step5[5] +f_x1_step5[6];
assign f_x1_step6_xor_out = f_x1_step6[0] + f_x1_step6[1] + f_x1_step6[5] +f_x1_step6[6];
assign f_x1_high_step_xor_out = f_x1_high_step[0] + f_x1_high_step[1] + f_x1_high_step[5] +f_x1_high_step[6];

assign g_xor_out_cos = g_x2_cos[0] + g_x2_cos[4];
assign g_x2_cos_step_xor_out = g_x2_cos[0] + g_x2_cos[4];


always@ (posedge clk)
begin
    if(reset==1'b1)
    begin
        f_x1_step1 <= 8'hff;
        f_x1_step2 <= 8'hff;
        f_x1_step3 <= 8'hff;
        f_x1_step4 <= 8'hff;
        f_x1_step5 <= 8'hff;
        f_x1_step6 <= 8'hff;
        f_x1_high_step <= 8'hff;
        g_x2_cos <= 9'h1ff;
        g_x2_cos_step <= 9'h1ff;
    end
    else begin
        if(busy==1'b1 && j<=`DATA)
        begin
            
            //**********f(x1)=sqrt(-exp(x1))***********
            
            f_x1_step1[6:0] <= f_x1_step1[7:1];
            f_x1_step1[7] <= f_x1_step1_xor_out[0];
            f_x1_step1_out_temp = f_x1_step1 * step1;
            f_x1_step1_out = f_x1_step1_out_temp[16:8];
            
            if((j%16) == 0)
            begin
                f_x1_step2[6:0] <= f_x1_step2[7:1];
                f_x1_step2[7] <= f_x1_step2_xor_out[0];
                f_x1_step2_out_temp = f_x1_step2 * step_gap1;
                f_x1_step2_out = f_x1_step2_out_temp[15:8] + step1;
            end
            
            if((j%17) == 0)
            begin
                f_x1_high_step[6:0] <= f_x1_high_step[7:1];
                f_x1_high_step[7] <= f_x1_high_step_xor_out[0];
                f_x1_high_step_out_temp = f_x1_high_step * high_step;
                f_x1_high_step_out = f_x1_high_step_out_temp[15:8];
            end            
            
            if((j%256) == 0)
            begin
                f_x1_step3[6:0] <= f_x1_step3[7:1];
                f_x1_step3[7] <= f_x1_step3_xor_out[0];
                f_x1_step3_out_temp = f_x1_step3 * step_gap2;
                f_x1_step3_out = f_x1_step3_out_temp[15:8] + step2;
            end
            
            if((j%4096) == 0)
            begin
                f_x1_step4[6:0] <= f_x1_step4[7:1];
                f_x1_step4[7] <= f_x1_step4_xor_out[0];
                f_x1_step4_out_temp = f_x1_step4 * step_gap3;
                f_x1_step4_out = f_x1_step4_out_temp[15:8] + step3;
            end
            
            if((j%65536) == 0)
            begin
                f_x1_step5[6:0] <= f_x1_step5[7:1];
                f_x1_step5[7] <= f_x1_step5_xor_out[0];
                f_x1_step5_out_temp = f_x1_step5 * step_gap4;
                f_x1_step5_out = f_x1_step5_out_temp[15:8] + step4;
            end
            
            if((j%1048576) == 0)
            begin
                f_x1_step6[6:0] <= f_x1_step6[7:1];
                f_x1_step6[7] <= f_x1_step6_xor_out[0];
                f_x1_step6_out_temp = f_x1_step6 * step_gap5;
                f_x1_step6_out = f_x1_step6_out_temp[15:8] + step5;
            end
            
            //*************g(x2)=cos(2*pi*x2)****************
            
            g_x2_cos[7:0] <= g_x2_cos[8:1];
            g_x2_cos[8] <= g_xor_out_cos[0];
            g_x2_cos_out_temp = g_x2_cos * g_x2_step_high ;
            g_x2_cos_out = g_x2_cos_out_temp[16:8];
 
            if((j%5) == 0)
            begin
                g_x2_cos_step[7:0] <= g_x2_cos_step[8:1];
                g_x2_cos_step[8] <= g_x2_cos_step_xor_out[0];
                g_x2_cos_step_temp = g_x2_cos_step * g_x2_gap;
                temp_g_x2_cos = g_x2_cos_step_temp[16:8];
                if(temp_g_x2_cos > 0)
                begin
                    g_x2_cos_out = temp_g_x2_cos + g_x2_step_high;
                end
                if(temp_g_x2_cos < 0)
                begin
                    g_x2_cos_out = temp_g_x2_cos + g_x2_step_low;
                end
            end
            
            //**************n=f(x1)*sqrt(2)*g(x2)***************
            
            if((i%1048576) == 0)
            begin
// 			       sum_real_n = f_x1_step6_out * sqrt_2 * g_x2_cos_out;
                g_x2_cos_out_integer = g_x2_cos_out;
 			       sum_real_n_temp_integer = f_x1_step6_out * sqrt_2 * g_x2_cos_out_integer;
                sum_real_n_temp = sum_real_n_temp_integer;
 			       sum_real_n = sum_real_n_temp[27:8];
		      end
		      else if((i%65536) == 0)
            begin
// 			       sum_real_n = f_x1_step5_out * sqrt_2 * g_x2_cos_out;
                g_x2_cos_out_integer = g_x2_cos_out;
 			       sum_real_n_temp_integer = f_x1_step5_out * sqrt_2 * g_x2_cos_out_integer;
 			       sum_real_n_temp = sum_real_n_temp_integer;
 			       sum_real_n = sum_real_n_temp[27:8];
		      end
		      else if((i%4096) == 0)
            begin
// 			       sum_real_n = f_x1_step4_out * sqrt_2 * g_x2_cos_out;
                g_x2_cos_out_integer = g_x2_cos_out;
 			       sum_real_n_temp_integer = f_x1_step4_out * sqrt_2 * g_x2_cos_out_integer;
 			       sum_real_n_temp = sum_real_n_temp_integer;
 			       sum_real_n = sum_real_n_temp[27:8];
		      end
		      else if((i%256) == 0)
            begin
// 			       sum_real_n = f_x1_step3_out * sqrt_2 * g_x2_cos_out;
                g_x2_cos_out_integer = g_x2_cos_out;
 			       sum_real_n_temp_integer = f_x1_step3_out * sqrt_2 * g_x2_cos_out_integer;
 			       sum_real_n_temp = sum_real_n_temp_integer;
 			       sum_real_n = sum_real_n_temp[27:8];
		      end
		      else if((i%16) == 0)
            begin
// 			       sum_real_n = f_x1_step2_out * sqrt_2 * g_x2_cos_out;
                g_x2_cos_out_integer = g_x2_cos_out;
 			       sum_real_n_temp_integer = f_x1_step2_out * sqrt_2 * g_x2_cos_out_integer;
 			       sum_real_n_temp = sum_real_n_temp_integer;
 			       sum_real_n = sum_real_n_temp[27:8];
		      end
		      else if((i%17) == 0)
            begin
// 			       sum_real_n = f_x1_high_step_out * sqrt_2 * g_x2_cos_out;
                g_x2_cos_out_integer = g_x2_cos_out;
 			       sum_real_n_temp_integer = f_x1_high_step_out * sqrt_2 * g_x2_cos_out_integer;
                sum_real_n_temp = sum_real_n_temp_integer;
 			       sum_real_n = sum_real_n_temp[27:8];
		      end
		      else
            begin
// 			       sum_real_n = f_x1_step1_out * sqrt_2 * g_x2_cos_out;
                g_x2_cos_out_integer = g_x2_cos_out;
 			       sum_real_n_temp_integer = f_x1_step1_out * sqrt_2 * g_x2_cos_out_integer;
                sum_real_n_temp = sum_real_n_temp_integer;
 			       sum_real_n = sum_real_n_temp[27:8];
		      end
		      
		      sum_real_n_truncation[11:0] = sum_real_n[19:8];
        
            
            //*************** Y=X+(sigma*n) *******************
            if(`SNR_dB==0)
            begin
                noise_real = sigma_0dB * sum_real_n;
                noise_real_truncation[11:0] = noise_real[27:16];
                temp_noise_real_integer = noise_real_truncation;
                Y_out_real = (temp_X_in_real + temp_noise_real_integer); 
            end
            if(`SNR_dB==1)
            begin
                noise_real = sigma_1dB * sum_real_n;
                noise_real_truncation[11:0] = noise_real[27:16];
                temp_noise_real_integer = noise_real_truncation;
                Y_out_real = (temp_X_in_real + temp_noise_real_integer); 
            end
            if(`SNR_dB==2)
            begin
                noise_real = sigma_2dB * sum_real_n;
                noise_real_truncation[11:0] = noise_real[27:16];
                temp_noise_real_integer = noise_real_truncation;
                Y_out_real = (temp_X_in_real + temp_noise_real_integer); 
            end
            if(`SNR_dB==3)
            begin
                noise_real = sigma_3dB * sum_real_n;
                noise_real_truncation[11:0] = noise_real[27:16];
                temp_noise_real_integer = noise_real_truncation;
                Y_out_real = (temp_X_in_real + temp_noise_real_integer); 
            end
            if(`SNR_dB==4)
            begin
                noise_real = sigma_4dB * sum_real_n;
                noise_real_truncation[11:0] = noise_real[27:16];
                temp_noise_real_integer = noise_real_truncation;
                Y_out_real = (temp_X_in_real + temp_noise_real_integer); 
            end
            if(`SNR_dB==5)
            begin
                noise_real = sigma_5dB * sum_real_n;
                noise_real_truncation[11:0] = noise_real[27:16];
                temp_noise_real_integer = noise_real_truncation;
                Y_out_real = (temp_X_in_real + temp_noise_real_integer); 
            end
            if(`SNR_dB==6)
            begin
                noise_real = sigma_6dB * sum_real_n;
                noise_real_truncation[11:0] = noise_real[27:16];
                temp_noise_real_integer = noise_real_truncation;
                Y_out_real = (temp_X_in_real + temp_noise_real_integer); 
            end
            if(`SNR_dB==7)
            begin
                noise_real = sigma_7dB * sum_real_n;
                noise_real_truncation[11:0] = noise_real[27:16];
                temp_noise_real_integer = noise_real_truncation;
                Y_out_real = (temp_X_in_real + temp_noise_real_integer); 
            end
            if(`SNR_dB==8)
            begin
                noise_real = sigma_8dB * sum_real_n;
                noise_real_truncation[11:0] = noise_real[27:16];
                temp_noise_real_integer = noise_real_truncation;
                Y_out_real = (temp_X_in_real + temp_noise_real_integer); 
            end
            if(`SNR_dB==9)
            begin
                noise_real = sigma_9dB * sum_real_n;
                noise_real_truncation[11:0] = noise_real[27:16];
                temp_noise_real_integer = noise_real_truncation;
                Y_out_real = (temp_X_in_real + temp_noise_real_integer); 
            end
            j=j+1;
                
        end
    end
end

endmodule