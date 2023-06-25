`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.04.2023 17:26:42
// Design Name: 
// Module Name: digital_safe
// Project Name: Digital Design Project
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


module give_bcd(num, seven_segment);

input [3:0] num;
output reg[6:0] seven_segment;

always @ (num)
begin
    case(num)
    4'b0000: seven_segment <= 7'b1000000; // 0
    4'b0001: seven_segment <= 7'b1111001; // 1
    4'b0010: seven_segment = 7'b0100100; // 2
    4'b0011: seven_segment<= 7'b0110000; // 3
    4'b0100: seven_segment<= 7'b0011001; // 4
    4'b0101: seven_segment<= 7'b0010010; // 5
    4'b0110: seven_segment<= 7'b0000010; // 6
    4'b0111: seven_segment<= 7'b1111000; // 7
    4'b1000: seven_segment<= 7'b0000000; // 8
    4'b1001: seven_segment<= 7'b0010000; // 9
    default: seven_segment <= 7'b0111111;
    endcase
end

endmodule




module digital_safe(keys, update,sysclk, update_led, wrong_count, lock, lock_led, unlock_led, perm_lock_count, temp_lock_led, back_space, reset, enter, seven_segment, gpio);

input [9:0] keys;
input update, sysclk, lock, back_space, reset, enter;
output reg lock_led, unlock_led, temp_lock_led, update_led;
output reg [3:0] gpio;
output reg[6:0] seven_segment;
wire clk;

reg [3:0] inpnum1 = 4'b1111;
reg [3:0] inpnum2 = 4'b1111;
reg [3:0] inpnum3 = 4'b1111;
reg [3:0] inpnum4 = 4'b1111;

reg [3:0] pass1 = 4'b0111;
reg [3:0] pass2 = 4'b0111;
reg [3:0] pass3 = 4'b0111;
reg [3:0] pass4 = 4'b0111;

parameter locked = 3'b010, unlocked = 3'b000, updating = 3'b001, temp_locked = 3'b011;

reg [7:0] unlock_timer = 0;
reg [7:0] temp_lock_timer = 0; 
reg [2:0] upd_counter = 3'b000;
reg [2:0] ent_counter = 3'b000;

output reg [1:0] perm_lock_count = 2'b00;


reg [1:0] ps = 3'b010;

reg [3:0] input_num;
output reg [1:0] wrong_count = 2'b00;
reg back_pressed, enter_pressed;


clock_divider cd(sysclk, clk);

reg input_taken = 0;

wire [6:0]seven_segment1;
wire [6:0]seven_segment2;
wire [6:0]seven_segment3;
wire [6:0]seven_segment4;

give_bcd BCD_DECODER1(inpnum1,seven_segment1);
give_bcd BCD_DECODER2(inpnum2,seven_segment2);
give_bcd BCD_DECODER3(inpnum3,seven_segment3);
give_bcd BCD_DECODER4(inpnum4,seven_segment4);

reg [9:0] prev_keys = 10'b0000000000;

reg [2:0] coun=3'b000;
reg [5:0] temp = 0;

always @(posedge clk) 
begin
    case(coun)
        3'b000: begin
            seven_segment <= seven_segment1; // L
            gpio <= ~4'b0001;
            coun <= 3'b001;
        end
        3'b001: begin
            seven_segment =seven_segment2; // O
            gpio = ~4'b0010;
            coun <= 3'b010;
        end
        3'b010: begin
            seven_segment <= seven_segment3; // C
            gpio <= ~4'b0100;
            coun <= 3'b011;
        end
        3'b011: begin
            seven_segment <= seven_segment4; // K
            gpio <= ~4'b1000;
            coun <= 3'b000;
        end
        default: coun <=3'b000;
    endcase
end

wire clk2;

clock_divider2 cd2(sysclk, clk2);

always @ (posedge clk2)
begin
    if(prev_keys != keys)
    begin
        prev_keys <= keys;
        input_taken = 1;
        casex (keys)
            10'b1xxxxxxxxx : input_num <= 4'b1001;
            10'b01xxxxxxxx : input_num <= 4'b1000;
            10'b001xxxxxxx : input_num <= 4'b0111;
            10'b0001xxxxxx : input_num <= 4'b0110;
            10'b00001xxxxx : input_num <= 4'b0101;
            10'b000001xxxx : input_num <= 4'b0100;
            10'b0000001xxx : input_num <= 4'b0011;
            10'b00000001xx : input_num <= 4'b0010;
            10'b000000001x : input_num <= 4'b0001;
            10'b0000000001 : input_num <= 4'b0000;
            10'b0000000000 : input_num <= 4'b1111;
        endcase
    end

    else
    begin
        input_taken = 0;
    end
end

always @ (negedge clk2)
begin

    
    if(wrong_count == 2'b11)
    begin
        perm_lock_count = perm_lock_count + 1;
        
        ps <= temp_locked;
        wrong_count = 2'b00;
    
        
        
        
        temp_lock_timer = 8'b00000000;
    end
    


        if(perm_lock_count >= 2'b11)
        begin
                                                                    
            ps <= 3'b111;
            unlock_led = 1;
            update_led = 1;
            lock_led = 1;
            temp_lock_led = 1;
        
            if(update == 1 && lock == 1 && back_space == 1 && enter == 1)
            begin
                if(temp == 6'b111111)
                begin
                    ps <= unlocked;
                    perm_lock_count <= 2'b00;
                    temp = 6'b000000;
                    perm_lock_count <= 2'b00;
//                    pass1 = 4'b
                    
                end
                else
                begin
                    temp = temp + 1;
                end
               
                
            end
            else
            begin
                temp = 0;
           end
        end
    if((lock == 1) && (ps != temp_locked) && (ps != 3'b111))
    begin
        inpnum1 <= 4'b1111;
        inpnum2 <= 4'b1111;
        inpnum3 <= 4'b1111;
        inpnum4 <= 4'b1111;
        ent_counter = 3'b000;
        upd_counter = 3'b000;
        unlock_timer <= 8'b00000000;
        ps <= locked;
    end

    if((back_space == 1))
    begin
        back_pressed <= 1;
    end

    if(enter == 1)
    begin
        enter_pressed <= 1;
    end

    if((update == 1) && ps == unlocked)
    begin
        unlock_timer <= 8'b00000000;
        ps <= updating;

    end

    case(ps)
        locked : 
            begin
                lock_led <= 1;
                update_led <= 0;
                unlock_led <= 0;
                temp_lock_led <= 0;
                if(reset == 0 || ent_counter == 3'b000)
                begin
                    ent_counter <= 3'b000;
                    inpnum1 <= 4'b1111;
                    inpnum2 <= 4'b1111;
                    inpnum3 <= 4'b1111;
                    inpnum4 <= 4'b1111;
                end

                if((input_taken == 1) && (input_num != 4'b1111))
                begin
                    // input_taken = 0;
                    case(ent_counter)
                        3'b000 : inpnum1 <= input_num;
                        3'b001 : inpnum2 <= input_num;
                        3'b010 : inpnum3 <= input_num;
                        3'b011 : inpnum4 <= input_num;

//                        default : input_num <= 4'b1111;

                    endcase

                    ent_counter <= ent_counter + 1;
                end

                if((enter ==  0) && (enter_pressed == 1) && (ent_counter >= 3'b100))
                begin
                    enter_pressed <= 0;
                    if((pass1 == inpnum1) && (pass2 == inpnum2) && (pass3 == inpnum3) && (pass4 == inpnum4))
                    begin
                        inpnum1 <= 4'b1111;
                        inpnum2 <= 4'b1111;
                        inpnum3 <= 4'b1111;
                        inpnum4 <= 4'b1111;
                        ps <= unlocked;
                        wrong_count <= 2'b00;
                        ent_counter <= 3'b000;
                        unlock_timer <= 8'b00000000;
                    end

                    else
                    begin
                        inpnum1 <= 4'b1111;
                        inpnum2 <= 4'b1111;
                        inpnum3 <= 4'b1111;
                        inpnum4 <= 4'b1111;
                        wrong_count <= wrong_count + 1;
                        ent_counter <= 3'b000;

                    end
                end

                if((back_space == 0) && (back_pressed == 1) && ent_counter > 3'b000)
                begin
                    back_pressed <= 0;
                    case (ent_counter)
                        3'b001: inpnum1 <= 4'b1111;
                        3'b010: inpnum2 <= 4'b1111;
                        3'b011: inpnum3 <= 4'b1111;
                        3'b100: inpnum4 <= 4'b1111;
                        default : ent_counter <= 3'b001;
                    endcase
                    ent_counter <= ent_counter - 1;
                end

            end   
        
        updating :
            begin
                update_led = 1;
                lock_led = 0;
                unlock_led = 0;
                temp_lock_led = 0;
                
                if(reset == 0 || upd_counter == 3'b000)
                begin
                    upd_counter <= 3'b000;
                    inpnum1 <= 4'b1111;
                    inpnum2 <= 4'b1111;
                    inpnum3 <= 4'b1111;
                    inpnum4 <= 4'b1111;
                end

                if((input_taken == 1) && (input_num != 4'b1111))
                begin

                    case(upd_counter)
                        3'b000 : inpnum1 <= input_num;
                        3'b001 : inpnum2 <= input_num;
                        3'b010 : inpnum3 <= input_num;
                        3'b011 : inpnum4 <= input_num;

                        // default : input_num <= 4'b1111;

                    endcase
                    upd_counter <= upd_counter + 1;

                end

                if((enter == 0) && (enter_pressed == 1) && (upd_counter >= 3'b100))
                begin
                    enter_pressed <= 0;
                    upd_counter <= 3'b000;
                    pass1 <= inpnum1;
                    pass2 <= inpnum2;
                    pass3 <= inpnum3;
                    pass4 <= inpnum4;
                    ps <= unlocked;
                    
                    inpnum1 <= 4'b1111;
                    inpnum2 <= 4'b1111;
                    inpnum3 <= 4'b1111;
                    inpnum4 <= 4'b1111;
                    
                    unlock_timer <= 8'b00000000;
                    upd_counter <= 3'b000;

                end

                if((back_space == 0) && (back_pressed == 1))
                begin
                    back_pressed <= 0;
                    case (upd_counter)
                        3'b001: inpnum1 <= 4'b1111;
                        3'b010: inpnum2 <= 4'b1111;
                        3'b011: inpnum3 <= 4'b1111;
                        3'b100 : inpnum4 <= 4'b1111;
                        default : upd_counter <= 3'b001;
                    endcase
                    upd_counter <= upd_counter - 1;
                end
            end

        temp_locked :
            begin
                update_led = 0;
                lock_led = 0;
                unlock_led = 0;
                temp_lock_led = 1;
                
                if(temp_lock_timer == 8'b10010110)
                begin
                    temp_lock_timer <= 8'b00000000;
                    ps <= locked;
                end
                else
                begin
                    temp_lock_timer <= temp_lock_timer + 1;
                end
            end

        unlocked:
            begin
                
                update_led = 0;
                lock_led = 0;
                unlock_led = 1;
                temp_lock_led = 0;
     
                perm_lock_count = 0;
                
                wrong_count <= 2'b00;
                if(reset == 0)
                begin
                    unlock_timer <= 8'b00000000;
                end

                if(unlock_timer == 8'b10010110)
                begin
                    unlock_timer <= 8'b00000000;
                    ps <= locked;
                end
                else
                begin
                    unlock_timer <= unlock_timer + 1;
                end
            end
               
    endcase

end

endmodule
