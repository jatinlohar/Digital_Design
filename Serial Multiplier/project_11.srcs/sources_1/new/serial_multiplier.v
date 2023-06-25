`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.03.2023 13:29:43
// Design Name: 
// Module Name: serial_multiplier
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.03.2023 02:50:41
// Design Name: 
// Module Name: serial_multiplier
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


module serial_multiplier( btn , sysclk , divclk , B , C , A , SWB , SWC , start , reset );
    output reg [3:0]B,C = 4'b0000;
    output reg [3:0]A = 4'b0000;
    input [3:0] btn;
    input SWB,SWC;
    input start,reset;
    
    wire [3:0]S ;
    wire [3:0]temp = 4'b0000;
    wire cout;
    
    input sysclk;
    output divclk;
                
    reg [26:0] count = 0;    
    always @( posedge sysclk )
        count = count + 1;
        
    assign divclk = count[26];  
     
    assign {cout,S} = (A + temp);
    assign temp = B[0]? C:4'b0000;
    
    always @( posedge divclk )
//        and (temp[3],B[0],C[3]);
//        temp[3] = B[0]&C[3];
//        temp[2] = B[0]&C[2];
//        temp[1] = B[0]&C[1];
//        temp[0] = B[0]&C[0];

        begin
            
            if( reset == 1 )
                begin
                    A = 4'b0000;
                    B = 4'b0000;
                    C = 4'b0000;
                end
                
            else if( SWB == 1 )
                B = btn;
                
            else if( SWC == 1 )
                C = btn;           
                
            else if( start == 1 )
                begin
                    B[0] <= B[1]; 
                    B[1] <= B[2]; 
                    B[2] <= B[3]; 
                    B[3] <= S[0];
                
                    A[0] <= S[1]; 
                    A[1] <= S[2]; 
                    A[2] <= S[3]; 
                    A[3] <= cout;     
                end
        end      
            
    
endmodule
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module serial_multiplier(

    );
endmodule
