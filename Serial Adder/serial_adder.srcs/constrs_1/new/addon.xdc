## This file is RPI Logic board .xdc for the PYNQ-Z2 ########################################
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports)
## - according to the top level signal names in the project
##
###########################Raspberry Digital I/O###############################################
## Clock signal 12 MHz  ##
#set_property -dict { PACKAGE_PIN Y9    IOSTANDARD LVCMOS33 } [get_ports { OSC_12MHz }]; #rpio_21

##Button #Active Low##
#set_property -dict { PACKAGE_PIN V7    IOSTANDARD LVCMOS33 } [get_ports { Button }]; #rpio_27  

## SSD(Seven Segment Display) x 4 ##
#set_property -dict { PACKAGE_PIN Y16   IOSTANDARD LVCMOS33 } [get_ports { SSD_CA }]; #rpio_sd
#set_property -dict { PACKAGE_PIN Y17   IOSTANDARD LVCMOS33 } [get_ports { SSD_CB }]; #rpio_sc 
#set_property -dict { PACKAGE_PIN W18   IOSTANDARD LVCMOS33 } [get_ports { SSD_CC }]; #rpio_02
#set_property -dict { PACKAGE_PIN W19   IOSTANDARD LVCMOS33 } [get_ports { SSD_CD }]; #rpio_03
#set_property -dict { PACKAGE_PIN Y18   IOSTANDARD LVCMOS33 } [get_ports { SSD_CE }]; #rpio_04
#set_property -dict { PACKAGE_PIN Y19   IOSTANDARD LVCMOS33 } [get_ports { SSD_CF }]; #rpio_05
#set_property -dict { PACKAGE_PIN U18   IOSTANDARD LVCMOS33 } [get_ports { SSD_CG }]; #rpio_06
#set_property -dict { PACKAGE_PIN U19   IOSTANDARD LVCMOS33 } [get_ports { SSD_CP }]; #rpio_07

#set_property -dict { PACKAGE_PIN F19   IOSTANDARD LVCMOS33 } [get_ports { SSD_A4 }]; #rpio_08
#set_property -dict { PACKAGE_PIN V10   IOSTANDARD LVCMOS33 } [get_ports { SSD_A3 }]; #rpio_09
#set_property -dict { PACKAGE_PIN V8    IOSTANDARD LVCMOS33 } [get_ports { SSD_A2 }]; #rpio_10
#set_property -dict { PACKAGE_PIN W10   IOSTANDARD LVCMOS33 } [get_ports { SSD_A1 }]; #rpio_11

##LED(GREEN)## 
set_property -dict { PACKAGE_PIN B20   IOSTANDARD LVCMOS33 } [get_ports { B[0] }]; #rpio_12
set_property -dict { PACKAGE_PIN W8    IOSTANDARD LVCMOS33 } [get_ports { B[1] }]; #rpio_13
set_property -dict { PACKAGE_PIN U8    IOSTANDARD LVCMOS33 } [get_ports { B[2] }]; #rpio_22
set_property -dict { PACKAGE_PIN W6    IOSTANDARD LVCMOS33 } [get_ports { B[3] }]; #rpio_23
#set_property -dict { PACKAGE_PIN Y7    IOSTANDARD LVCMOS33 } [get_ports { LEDE }]; #rpio_24
#set_property -dict { PACKAGE_PIN F20   IOSTANDARD LVCMOS33 } [get_ports { LEDF }]; #rpio_25

##Switches##
set_property -dict { PACKAGE_PIN V6    IOSTANDARD LVCMOS33 } [get_ports { load1 }]; #rpio_14
set_property -dict { PACKAGE_PIN Y6    IOSTANDARD LVCMOS33 } [get_ports { load2 }]; #rpio_15
#set_property -dict { PACKAGE_PIN B19   IOSTANDARD LVCMOS33 } [get_ports { SWC }]; #rpio_16
#set_property -dict { PACKAGE_PIN U7    IOSTANDARD LVCMOS33 } [get_ports { SWD }]; #rpio_17
#set_property -dict { PACKAGE_PIN C20   IOSTANDARD LVCMOS33 } [get_ports { SWE }]; #rpio_18
#set_property -dict { PACKAGE_PIN Y8    IOSTANDARD LVCMOS33 } [get_ports { SWF }]; #rpio_19
#set_property -dict { PACKAGE_PIN A20   IOSTANDARD LVCMOS33 } [get_ports { SWG }]; #rpio_20
#set_property -dict { PACKAGE_PIN W9    IOSTANDARD LVCMOS33 } [get_ports { SWH }]; #rpio_26



