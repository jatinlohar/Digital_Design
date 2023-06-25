`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.03.2023 09:09:09
// Design Name: 
// Module Name: input_loader
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


module input_loader(In,out,load,reset);
input [3:0]In;
input load,reset;
output reg [3:0]out;

always@(In,load,reset)
begin
    if(load == 1)
        out = In;
    if(reset == 1)
        out = 4'b0000;
end

endmodule
