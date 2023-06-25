`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.03.2023 09:22:30
// Design Name: 
// Module Name: serial_adde
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module serial_adde(In,load1,load2,reset,start,clk,A,B,clkout);
input [3:0]In;
input load1,load2,reset,start,clk;
output reg [3:0]A,B;
output clkout;
reg c = 0;
reg [2:0]counter;
ClockDivider cl(clk,clkout);
wire sl,c_l;

full_adder F1(A[0],B[0],c,sl,c_l);
//always@(load1,load2,reset,In)
//begin 
//  if (load2 == 1)
//        B = In;
//    if(load1 == 1)
//        A = In;
    
//    if (reset == 1)
//        A = 4'b0000;
//    if (reset == 1)
//        B = 4'b0000;
    
//end
        
always@(posedge clkout)
begin 
    if(start == 1) 
    begin
         if(counter == 4'd0)
         begin
            c =0;
         end
        counter = counter+1;
        
        A[3] <= sl;
        A[2] <= A[3];
        A[1] <= A[2];
        A[0] <= A[1];
        
        B[3] <= 0;
        B[2] <= B[3];
        B[1] <= B[2];
        B[0] <= B[1];
        
        c = c_l;
        
        if(counter ==4'd4)
        begin
            counter = 4'd0;
        end
     end
     
     else 
     begin 
     if (load2 == 1)
        B = In;
     if(load1 == 1)
        A = In;
    
     if (reset == 1)
     begin
        A = 4'b0000;
        B = 4'b0000;
        c=0;
     
     end
    
    
     end
          

    
  
       
end

endmodule

//module sim();
//reg [3:0]I;
//reg load1,load2,reset,start,clk;
//wire clkout;
//wire [3:0]A,B;

//serial_adde a1(I,load1,load2,reset,start,clk,A,B,clkout);

//initial begin
//clk = 0;
//I = 4'd4;load1 = 1;start = 0;reset = 0; load2 = 0;
//#8
//I = 4'd3;load2 = 1;start = 0;reset = 0; load1 = 0;
//#8
//I = 4'd4;load1 = 0;load2=0;start = 1;
//#16
//start = 0; reset =1;
//#16
//$finish;
//end

//   always 
//         #1  clk =  ! clk; 
//endmodule

