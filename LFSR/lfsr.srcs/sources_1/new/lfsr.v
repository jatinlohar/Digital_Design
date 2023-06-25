`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.03.2023 14:18:55
// Design Name: 
// Module Name: lfsr
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


module lfsr( sysclk , divclk , op , start );

    reg [7:0]s = 8'b10101010;
    output reg op;
    input start;

    input sysclk;
    output divclk;
                
    reg [27:0] count = 0;    
    always @( posedge sysclk )
        count = count + 1;
        
    assign divclk = count[27];
    
    always @( posedge divclk )
        if( start == 1)
        begin
            s[0] <= s[1];
            s[1] <= s[2];
            s[2] <= s[3];
            s[3] <= s[4];
            s[4] <= s[5];
            s[5] <= s[6];
            s[6] <= s[7];
            s[7] <= ((s[0]^s[2])^s[3])^s[4]; 
            
            op <= s[0];
        end
        
endmodule
