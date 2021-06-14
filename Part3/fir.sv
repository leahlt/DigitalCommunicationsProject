module fir_filter
               (
                clk ,
                rst    ,
                data_in,
                data_out
                );

input                   clk  ; 
  input                   rst     ;
  input       [7:0] data_in ; //input data(deal with 8 bits at a time)
  output      [7:0] data_out; //output data

//8 stages Fir filter, since all parameters are symmetric(e.g. para6=para4) 
//so save space only list out 5 of parameters
  wire signed[15:0] para1 = 16'd239 ;
  wire signed[15:0] para2 = 16'd1507;
  wire signed[15:0] para3 = 16'd4397;
  wire signed[15:0] para4 = 16'd7880;
  wire signed[15:0] para5 = 16'd9493;

//dalays from 1-8
reg signed [7:0] delay_1 ;
reg signed [7:0] delay_2 ;
reg signed [7:0] delay_3 ;
reg signed [7:0] delay_4 ;
reg signed [7:0] delay_5 ;
reg signed [7:0] delay_6 ;
reg signed [7:0] delay_7 ;
reg signed [7:0] delay_8 ;

always@(posedge clk or negedge rst)
       if(!rst)
                begin
                    delay_1 <= 8'b0 ;
                     delay_2 <= 8'b0 ;
                     delay_3 <= 8'b0 ;
                     delay_4 <= 8'b0 ;
                     delay_5 <= 8'b0 ;
                     delay_6 <= 8'b0 ;
                     delay_7 <= 8'b0 ;
                     delay_8 <= 8'b0 ;
                end
       else
                begin
                    delay_1 <= data_in     ;
                     delay_2 <= delay_1 ;
                     delay_3 <= delay_2 ;
                     delay_4 <= delay_3 ;
                     delay_5 <= delay_4 ;
                     delay_6 <= delay_5 ;
                     delay_7 <= delay_6 ;
                     delay_8 <= delay_7 ;
                end
     
//Adder used to add data_in after delay
reg signed [8:0] add_data1 ;
reg signed [8:0] add_data2 ;
reg signed [8:0] add_data3 ;
reg signed [8:0] add_data4 ;
reg signed [8:0] add_data5 ;

always@(posedge clk or negedge rst) //x(0)+x(8)
       if(!rst)                                   
           add_data1 <= 9'b0 ;
       else
           add_data1 <= data_in + delay_8 ;

always@(posedge clk or negedge rst) //x(1)+x(7) 
       if(!rst)                                        
           add_data2 <= 9'b0 ;                             
       else                                                
           add_data2 <= delay_1 + delay_7 ;

always@(posedge clk or negedge rst) //x(2)+x(6) 
       if(!rst)                                        
           add_data3 <= 9'b0 ;                             
       else                                                
           add_data3 <= delay_2 + delay_6 ;


always@(posedge clk or negedge rst) //x(3)+x(5) 
       if(!rst)                                        
           add_data4 <= 9'b0 ;                             
       else                                                
           add_data4 <= delay_3 + delay_5 ;

always@(posedge clk or negedge rst) //x(4) 
       if(!rst)                                        
           add_data5 <= 9'b0 ;                             
       else                                                
           add_data5 <= {delay_4[7],delay_4} ;
//multiply use data to multiply with parameters
reg signed [24:0] multi_data1 ;
reg signed [24:0] multi_data2 ;
reg signed [24:0] multi_data3 ;
reg signed [24:0] multi_data4 ;
reg signed [24:0] multi_data5 ;

always@(posedge clk or negedge rst) //（x(0)+x(8)）*h(0)
       if(!rst)                                   
           multi_data1 <= 24'b0 ;
       else
           multi_data1 <= add_data1*para1 ;

always@(posedge clk or negedge rst) //（x(1)+x(7)）*h(1)
       if(!rst)                                   
           multi_data2 <= 24'b0 ;
       else
           multi_data2 <= add_data2*para2 ;

always@(posedge clk or negedge rst) //（x(2)+x(6)）*h(2)
       if(!rst)                                   
           multi_data3 <= 24'b0 ;
       else
           multi_data3 <= add_data3*para3 ;

always@(posedge clk or negedge rst) //（x(0)+x(8)）*h(3)
       if(!rst)                                   
           multi_data4 <= 24'b0 ;
       else
           multi_data4 <= add_data4*para4 ;

always@(posedge clk or negedge rst) //x(4)*h(4)
       if(!rst)                                   
           multi_data5 <= 24'b0 ;
       else
           multi_data5 <= add_data5*para5 ;


//more adders used to add up results to get final output
reg signed[25:0] adder_1_1;
reg signed[25:0] adder_1_2;
reg signed[25:0] adder_1_3;

always@(posedge clk or negedge rst) //（x(0)+x(8)）*h(0)+（x(1)+x(7)）*h(1)
       if(!rst)                                   
           adder_1_1 <= 26'b0 ;
       else
           adder_1_1 <= multi_data1+multi_data2 ;

always@(posedge clk or negedge rst) //（x(2)+x(6)）*h(2)+（x(3)+x(5)）*h(3)
       if(!rst)                                   
           adder_1_2 <= 26'b0 ;
       else
           adder_1_2 <= multi_data3+multi_data4 ;

always@(posedge clk or negedge rst) //x(4)*h(4)
       if(!rst)                                   
           adder_1_3 <= 26'b0 ;
       else
           adder_1_3 <= {multi_data5[24],multi_data5}   ;

reg signed [26:0] adder_2_1 ;
reg signed [26:0] adder_2_2 ;
always@(posedge clk or negedge rst) //（x(0)+x(8)）*h(0)+（x(1)+x(7)）*h(1)+（x(2)+x(6)）*h(2)+（x(3)+x(5)）*h(3)
       if(!rst)                                   
           adder_2_1 <= 27'b0 ;
       else
           adder_2_1 <= adder_1_1+adder_1_2 ;

always@(posedge clk or negedge rst) //x(4)*h(4)
       if(!rst)                                   
           adder_2_2 <= 27'b0 ;
       else
           adder_2_2 <= {adder_1_3[25],adder_1_3} ;


reg signed [27:0] adder_3 ;
always@(posedge clk or negedge rst)
       if(!rst)                                   
           adder_3 <= 27'b0 ;
       else
           adder_3 <= adder_2_1+adder_2_2 ;

//start output here
 reg signed  [22:0]  filter_out ;
always@(posedge clk or negedge rst)
 if(!rst)                                   
  filter_out <= 23'b0 ;
 else
  filter_out <= (adder_3[22:0]+{!adder_3[22],{14{adder_3[22]}}})>>15 ;
  
//take the lower 8 bits so output is also 8 bits
 assign data_out  = filter_out[7:0] ;

endmodule