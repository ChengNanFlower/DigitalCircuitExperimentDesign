# XDC constraints for 8-to-3 Priority Encoder

# =============================================================
# Inputs: Switches
# IMPORTANT: Verify these pin assignments with your board's documentation!
# =============================================================
# Assign 8-bit input I[7:0] to switches SW7-SW0
# NOTE: According to the design, I[0] (mapped to SW0) has the HIGHEST priority.
set_property -dict {PACKAGE_PIN P17 IOSTANDARD LVCMOS33} [get_ports {I[0]}]  ; # SW0 (Highest Priority)
set_property -dict {PACKAGE_PIN T18 IOSTANDARD LVCMOS33} [get_ports {I[1]}]  ; # SW1
set_property -dict {PACKAGE_PIN U17 IOSTANDARD LVCMOS33} [get_ports {I[2]}]  ; # SW2
set_property -dict {PACKAGE_PIN U16 IOSTANDARD LVCMOS33} [get_ports {I[3]}]  ; # SW3
set_property -dict {PACKAGE_PIN V14 IOSTANDARD LVCMOS33} [get_ports {I[4]}]  ; # SW4
set_property -dict {PACKAGE_PIN U13 IOSTANDARD LVCMOS33} [get_ports {I[5]}]  ; # SW5
set_property -dict {PACKAGE_PIN U12 IOSTANDARD LVCMOS33} [get_ports {I[6]}]  ; # SW6
set_property -dict {PACKAGE_PIN U11 IOSTANDARD LVCMOS33} [get_ports {I[7]}]  ; # SW7 (Lowest Priority)

# Assign Enable signal EN_n to switch SW8
set_property -dict {PACKAGE_PIN U9  IOSTANDARD LVCMOS33} [get_ports EN_n]   ; # SW8

# =============================================================
# Outputs: LEDs
# =============================================================
# Assign 3-bit output Y[2:0] to LEDs LED2-LED0
set_property -dict {PACKAGE_PIN R15 IOSTANDARD LVCMOS33} [get_ports {Y[2]}]  ; # LED2
set_property -dict {PACKAGE_PIN T15 IOSTANDARD LVCMOS33} [get_ports {Y[1]}]  ; # LED1
set_property -dict {PACKAGE_PIN T14 IOSTANDARD LVCMOS33} [get_ports {Y[0]}]  ; # LED0

# Assign Done signal to LED3
set_property -dict {PACKAGE_PIN T16 IOSTANDARD LVCMOS33} [get_ports Done]   ; # LED3
