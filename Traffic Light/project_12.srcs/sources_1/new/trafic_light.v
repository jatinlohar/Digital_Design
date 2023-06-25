`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.04.2023 13:15:14
// Design Name: 
// Module Name: traffic_light
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

module BCD(A,B,C,D,a,b,c,d,e,f,g);
    input A,B,C,D;
    output a,b,c,d,e,f,g;
    
    assign a = ~(A|C|(B&D)|(~B&~D));
    assign b = ~(~B|(~C&~D)|(C&D));
    assign c = ~(~C|D|B);
    assign d = ~((~B&~D)|(~B&C)|(B&~C&D)|(C&~D)|A);
    assign e = ~((~B&~D)|(C&~D));
    assign f = ~((~C&~D)|(B&~C)|(B&~D)|A);
    assign g = ~((~B&C)|(B&~C)|A|(B&~D));    
endmodule

module trafic_light(sysclk,r,g,y,bcd,enable, clk);
output wire[3:0]enable;
assign enable=4'b0111;
input sysclk;
output reg[3:0] r,g,y;
output wire[6:0]bcd;
output reg clk = 1'b1;
reg[25:0] count = 0;

always@(posedge sysclk)
begin
    if(count==26'b11101110011010110010100000 && clk==1'b1)
    begin
        clk=1'b0;
        count=0;
    end
    else if(count==26'b11101110011010110010100000 && clk==1'b0)
    begin
        clk=1'b1;
        count=0;
    end
    else
    begin
        count=count+1;
    end
end

reg [2:0]counter = 0;

always@(posedge clk)
begin
    counter=counter+1;
end

parameter[2:0]N=3'b000,NY=3'b001,E=3'b010,EY=3'b011,S=3'b100,SY=3'b101,W=3'b110,WY=3'b111;
reg[2:0]PS=N;

always@(posedge clk)
begin
    case(PS)
    N: begin
        r<=4'b0111;
        g<=4'b1000;
        y<=4'b0000;
        
        if(counter==3'b101)
        PS<=NY;
       end
    NY: begin
        r<=4'b0111;
        g<=4'b0000;
        y<=4'b1000;
        
        if(counter==3'b111)
        PS<=E;
       end
    E: begin
        r<=4'b1011;
        g<=4'b0100;
        y<=4'b0000;
        
        if(counter==3'b101)
        PS<=EY;
       end
    EY: begin
        r<=4'b1011;
        g<=4'b0000;
        y<=4'b0100;
        
        if(counter==3'b111)
        PS<=S;
       end
    S: begin
        r<=4'b1101;
        g<=4'b0010;
        y<=4'b0000;
        
        if(counter==3'b101)
        PS<=SY;
       end
    SY: begin
        r<=4'b1101;
        g<=4'b0000;
        y<=4'b0010;
        
        if(counter==3'b111)
        PS<=W;
       end
    W: begin
        r<=4'b1110;
        g<=4'b0001;
        y<=4'b0000;
        
        if(counter==3'b101)
        PS<=WY;
       end
    WY: begin
        r<=4'b1110;
        g<=4'b0000;
        y<=4'b0001;
        
        if(counter==3'b111)
        PS<=N;
       end
   endcase
end
BCD b(0,counter[2],counter[1],counter[0],bcd[6],bcd[5],bcd[4],bcd[3],bcd[2],bcd[1],bcd[0]);
endmodule