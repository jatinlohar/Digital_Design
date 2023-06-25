`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.03.2023 17:06:53
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


module ClockDivider(input CLK_IN,output reg CLK_OUT);
    
    // For everyone rising edge, we will increment the counter variable
    reg[27:0] counter=28'd0;
    
    // parameters: They can be dynamically configured in the RTL diagram
    // Ideally: If you use DIVISOR=2, it will generate a frequency of CLK_IN/2 as the output
    // Use a divisor value that is perfectly divisble by 2. OTherwise you will have unexpected results
    parameter DIVISOR = 28'd125000000;
    
    //posedge: Perfoms some computation when the rising edge occurs at the CLK_IN
    always @(posedge CLK_IN)
    begin
        counter <= counter + 28'd1;   // At every rising edge, we increment counter variable by 1
        if(counter >= ( DIVISOR-1 ) ) // If the counter is equal or greater than DIVISOR - 1
            counter <= 28'd0;         // then reset the counter variable to 0.
        
        // For first half of the clock period, Set CLK_OUT to 1
        // For second half of the clock period, Set CLK_OUT to 0 
        // Use a divisor that can always be perfectly divided by 2

        CLK_OUT <= ( counter < DIVISOR >> 1 )? 1'b1 : 1'b0;  
    end
endmodule
