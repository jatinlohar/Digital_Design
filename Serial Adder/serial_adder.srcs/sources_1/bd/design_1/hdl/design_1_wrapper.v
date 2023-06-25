//Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
//Date        : Fri Mar 10 17:29:52 2023
//Host        : DESKTOP-DKR4IP8 running 64-bit major release  (build 9200)
//Command     : generate_target design_1_wrapper.bd
//Design      : design_1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module design_1_wrapper
   (CLK_OUT,
    clk);
  output CLK_OUT;
  input clk;

  wire CLK_OUT;
  wire clk;

  design_1 design_1_i
       (.CLK_OUT(CLK_OUT),
        .clk(clk));
endmodule
