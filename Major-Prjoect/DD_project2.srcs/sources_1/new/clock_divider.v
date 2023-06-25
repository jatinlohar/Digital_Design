`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.04.2023 17:35:12
// Design Name: 
// Module Name: clock_divider
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


module clock_divider(input clk_in, output reg clk_out);

reg [25:0] counter = 26'd0;
parameter DIVISOR = 26'd625000;

    always @(posedge clk_in)
    begin
        counter <= counter + 26'd1;   // At every rising edge, we increment counter variable by 1
        if(counter >= ( DIVISOR-1 ) ) // If the counter is equal or greater than DIVISOR - 1
            counter <= 26'd0;  
       
        clk_out <= ( counter < DIVISOR >> 1 )? 1'b1 : 1'b0;  
    end
endmodule
