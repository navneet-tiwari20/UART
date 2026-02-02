####################################################
## CLOCK (SP701, Bank 13, 1.8V)
####################################################
set_property PACKAGE_PIN AB21 [get_ports clk]
set_property IOSTANDARD LVCMOS18 [get_ports clk]
create_clock -period 5.000 [get_ports clk]

####################################################
## START BUTTON
####################################################
set_property PACKAGE_PIN AA17 [get_ports start]
set_property IOSTANDARD LVCMOS18 [get_ports start]

####################################################
## UART SIGNALS
####################################################
set_property PACKAGE_PIN AB2  [get_ports tx]
set_property PACKAGE_PIN A8   [get_ports rx]
set_property IOSTANDARD LVCMOS18 [get_ports {tx rx}]

####################################################
## STATUS SIGNALS
####################################################
set_property PACKAGE_PIN A12  [get_ports rx_done]
set_property PACKAGE_PIN AB26 [get_ports tx_done]
set_property IOSTANDARD LVCMOS18 [get_ports {rx_done tx_done}]

####################################################
## TX INPUT BUS tx_in[7:0]
####################################################
set_property PACKAGE_PIN AE17 [get_ports {tx_in[0]}]
set_property PACKAGE_PIN AF15 [get_ports {tx_in[1]}]
set_property PACKAGE_PIN A9   [get_ports {tx_in[2]}]   ;# FIXED
set_property PACKAGE_PIN AE16 [get_ports {tx_in[3]}]
set_property PACKAGE_PIN AD15 [get_ports {tx_in[4]}]
set_property PACKAGE_PIN AA18 [get_ports {tx_in[5]}]
set_property PACKAGE_PIN D10  [get_ports {tx_in[6]}]
set_property PACKAGE_PIN D15  [get_ports {tx_in[7]}]

set_property IOSTANDARD LVCMOS18 [get_ports {
    tx_in[0] tx_in[1] tx_in[2] tx_in[3]
    tx_in[4] tx_in[5] tx_in[6] tx_in[7]
}]

####################################################
## RX OUTPUT BUS rx_out[7:0]
####################################################
set_property PACKAGE_PIN AC19 [get_ports {rx_out[0]}]
set_property PACKAGE_PIN AC23 [get_ports {rx_out[1]}]
set_property PACKAGE_PIN AD4  [get_ports {rx_out[2]}]
set_property PACKAGE_PIN AD3  [get_ports {rx_out[3]}]
set_property PACKAGE_PIN AD5  [get_ports {rx_out[4]}]
set_property PACKAGE_PIN AA19 [get_ports {rx_out[5]}]
set_property PACKAGE_PIN AB19 [get_ports {rx_out[6]}]
set_property PACKAGE_PIN AB25 [get_ports {rx_out[7]}]

set_property IOSTANDARD LVCMOS18 [get_ports {
    rx_out[0] rx_out[1] rx_out[2] rx_out[3]
    rx_out[4] rx_out[5] rx_out[6] rx_out[7]
}]
