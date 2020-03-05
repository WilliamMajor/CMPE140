# Clock signal
set_property -dict {PACKAGE_PIN W5 IOSTANDARD LVCMOS33}           [get_ports {clk100MHz}];
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports {clk100MHz}];
# Buttons
set_property -dict {PACKAGE_PIN U18 IOSTANDARD LVCMOS33} [get_ports {rst}]; # Center Button
set_property -dict {PACKAGE_PIN T17 IOSTANDARD LVCMOS33} [get_ports {push_button_input}]; # Right Button
#set_property -dict {PACKAGE_PIN T17 IOSTANDARD LVCMOS33} [get_ports {Carry_out}]; # Left Button


# Switches
set_property -dict {PACKAGE_PIN V17 IOSTANDARD LVCMOS33} [get_ports {N_in[0]}];  # Switch 0
set_property -dict {PACKAGE_PIN V16 IOSTANDARD LVCMOS33} [get_ports {N_in[1]}];  # Switch 1
set_property -dict {PACKAGE_PIN W16 IOSTANDARD LVCMOS33} [get_ports {N_in[2]}];  # Switch 2
set_property -dict {PACKAGE_PIN W17 IOSTANDARD LVCMOS33} [get_ports {N_in[3]}];  # Switch 3
#set_property -dict {PACKAGE_PIN W15 IOSTANDARD LVCMOS33} [get_ports {go}];       # Switch 4
set_property -dict {PACKAGE_PIN V15 IOSTANDARD LVCMOS33} [get_ports {go}];  # Switch 5
set_property -dict {PACKAGE_PIN W14 IOSTANDARD LVCMOS33} [get_ports {switch}];  # Switch 6
#set_property -dict {PACKAGE_PIN W13 IOSTANDARD LVCMOS33} [get_ports {B_in[2]}];  # Switch 7 
#set_property -dict {PACKAGE_PIN V2 IOSTANDARD LVCMOS33} [get_ports {B_in[3]}];    # Switch 8 
#set_property -dict {PACKAGE_PIN W2 IOSTANDARD LVCMOS33} [get_ports {A[0]}];     # Switch 12
#set_property -dict {PACKAGE_PIN U1 IOSTANDARD LVCMOS33} [get_ports {F[0]}];    # Switch 13 
#set_property -dict {PACKAGE_PIN T1 IOSTANDARD LVCMOS33} [get_ports {F[1]}];     # Switch 14 
#set_property -dict {PACKAGE_PIN R2 IOSTANDARD LVCMOS33} [get_ports {F[2]}];     # Switch 15 

# LEDs
set_property -dict {PACKAGE_PIN U16 IOSTANDARD LVCMOS33} [get_ports {N_led[0]}];  # LED 0
set_property -dict {PACKAGE_PIN E19 IOSTANDARD LVCMOS33} [get_ports {N_led[1]}];  # LED 1
set_property -dict {PACKAGE_PIN U19 IOSTANDARD LVCMOS33} [get_ports {N_led[2]}];  # LED 2
set_property -dict {PACKAGE_PIN V19 IOSTANDARD LVCMOS33} [get_ports {N_led[3]}];  # LED 3
#set_property -dict {PACKAGE_PIN W18 IOSTANDARD LVCMOS33} [get_ports {go_led}];       # LED 4
set_property -dict {PACKAGE_PIN U15 IOSTANDARD LVCMOS33} [get_ports {go_led}];  # LED 5
set_property -dict {PACKAGE_PIN U14 IOSTANDARD LVCMOS33} [get_ports {switch_led}];  # LED 6
#set_property -dict {PACKAGE_PIN V14 IOSTANDARD LVCMOS33} [get_ports {B_in_led[2]}];  # LED 7
#set_property -dict {PACKAGE_PIN V13 IOSTANDARD LVCMOS33} [get_ports {B_in_led[3]}];  # LED 8
#set_property -dict {PACKAGE_PIN V3 IOSTANDARD LVCMOS33} [get_ports {done_led}];     # LED 9
set_property -dict {PACKAGE_PIN W3 IOSTANDARD LVCMOS33}  [get_ports {error_led}];    # LED 10
set_property -dict {PACKAGE_PIN U3 IOSTANDARD LVCMOS33}  [get_ports {done_led}];    # LED 11
#set_property -dict {PACKAGE_PIN P3 IOSTANDARD LVCMOS33}  [get_ports {CS_led[2]}];    # LED 12
#set_property -dict {PACKAGE_PIN N3 IOSTANDARD LVCMOS33}  [get_ports {F_led[0]}];      # LED 13
#set_property -dict {PACKAGE_PIN P1 IOSTANDARD LVCMOS33}  [get_ports {F_led[1]}];    # LED 14
#set_property -dict {PACKAGE_PIN L1 IOSTANDARD LVCMOS33}  [get_ports {F_led[2]}];    # LED 15

#7 Segment Display
set_property -dict {PACKAGE_PIN W7 IOSTANDARD LVCMOS33} [get_ports {LEDOUT[0]}]; # CA
set_property -dict {PACKAGE_PIN W6 IOSTANDARD LVCMOS33} [get_ports {LEDOUT[1]}]; # CB
set_property -dict {PACKAGE_PIN U8 IOSTANDARD LVCMOS33} [get_ports {LEDOUT[2]}]; # CC
set_property -dict {PACKAGE_PIN V8 IOSTANDARD LVCMOS33} [get_ports {LEDOUT[3]}]; # CD
set_property -dict {PACKAGE_PIN U5 IOSTANDARD LVCMOS33} [get_ports {LEDOUT[4]}]; # CE
set_property -dict {PACKAGE_PIN V5 IOSTANDARD LVCMOS33} [get_ports {LEDOUT[5]}]; # CF
set_property -dict {PACKAGE_PIN U7 IOSTANDARD LVCMOS33} [get_ports {LEDOUT[6]}]; # CG
set_property -dict {PACKAGE_PIN V7 IOSTANDARD LVCMOS33} [get_ports {LEDOUT[7]}]; # DP

set_property -dict {PACKAGE_PIN U2 IOSTANDARD LVCMOS33} [get_ports {LEDSEL[0]}]; # AN0
set_property -dict {PACKAGE_PIN U4 IOSTANDARD LVCMOS33} [get_ports {LEDSEL[1]}]; # AN1
set_property -dict {PACKAGE_PIN V4 IOSTANDARD LVCMOS33} [get_ports {LEDSEL[2]}]; # AN2
set_property -dict {PACKAGE_PIN W4 IOSTANDARD LVCMOS33} [get_ports {LEDSEL[3]}]; # AN3