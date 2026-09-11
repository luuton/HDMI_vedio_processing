set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]
#############SPI Configurate Setting##################
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design] 
set_property CONFIG_MODE SPIx4 [current_design] 
set_property BITSTREAM.CONFIG.CONFIGRATE 50 [current_design] 
############## clock define##################
create_clock -period 5 [get_ports sys_clk_p]
set_property PACKAGE_PIN R4 [get_ports sys_clk_p]
set_property IOSTANDARD DIFF_SSTL15 [get_ports sys_clk_p]
####################hdmi_out hdmi_in########################
set_property PACKAGE_PIN Y22 [get_ports vout_clk]
set_property PACKAGE_PIN V22 [get_ports {vout_data[0]}]
set_property PACKAGE_PIN Y18 [get_ports {vout_data[1]}]
set_property PACKAGE_PIN Y19 [get_ports {vout_data[2]}]
set_property PACKAGE_PIN W19 [get_ports {vout_data[3]}]
set_property PACKAGE_PIN W20 [get_ports {vout_data[4]}]
set_property PACKAGE_PIN Y21 [get_ports {vout_data[5]}]
set_property PACKAGE_PIN U21 [get_ports {vout_data[6]}]
set_property PACKAGE_PIN T21 [get_ports {vout_data[7]}]
set_property PACKAGE_PIN W21 [get_ports {vout_data[8]}]
set_property PACKAGE_PIN W22 [get_ports {vout_data[9]}]
set_property PACKAGE_PIN T20 [get_ports {vout_data[10]}]
set_property PACKAGE_PIN AB18 [get_ports {vout_data[11]}]
set_property PACKAGE_PIN AA18 [get_ports {vout_data[12]}]
set_property PACKAGE_PIN AA19 [get_ports {vout_data[13]}]
set_property PACKAGE_PIN AB20 [get_ports {vout_data[14]}]
set_property PACKAGE_PIN AA20 [get_ports {vout_data[15]}]
set_property PACKAGE_PIN AA21 [get_ports {vout_data[16]}]
set_property PACKAGE_PIN AB22 [get_ports {vout_data[17]}]
set_property PACKAGE_PIN AB21 [get_ports {vout_data[18]}]
set_property PACKAGE_PIN W17 [get_ports {vout_data[19]}]
set_property PACKAGE_PIN V17 [get_ports {vout_data[20]}]
set_property PACKAGE_PIN V20 [get_ports {vout_data[21]}]
set_property PACKAGE_PIN U20 [get_ports {vout_data[22]}]
set_property PACKAGE_PIN V19 [get_ports {vout_data[23]}]
set_property PACKAGE_PIN U22 [get_ports vout_de]
set_property PACKAGE_PIN T18 [get_ports vout_hs]
set_property PACKAGE_PIN Y17 [get_ports hdmi_nreset_v10]
set_property PACKAGE_PIN L18 [get_ports hdmi_nreset]
set_property PACKAGE_PIN R18 [get_ports vout_vs]
set_property PACKAGE_PIN H13 [get_ports hdmi_scl]
set_property PACKAGE_PIN G13 [get_ports hdmi_sda]

set_property IOSTANDARD LVCMOS33 [get_ports vout_clk]
set_property IOSTANDARD LVCMOS33 [get_ports {vout_data[*]}]
set_property IOSTANDARD LVCMOS33 [get_ports vout_de]
set_property IOSTANDARD LVCMOS33 [get_ports vout_hs]
set_property IOSTANDARD LVCMOS33 [get_ports hdmi_nreset]
set_property IOSTANDARD LVCMOS33 [get_ports hdmi_nreset_v10]
set_property IOSTANDARD LVCMOS33 [get_ports vout_vs]
set_property IOSTANDARD LVCMOS33 [get_ports hdmi_scl]
set_property IOSTANDARD LVCMOS33 [get_ports hdmi_sda]

set_property IOB TRUE [get_ports {vout_data[*]}]
set_property IOB TRUE [get_ports vout_de]
set_property IOB TRUE [get_ports vout_hs]
set_property IOB TRUE [get_ports vout_vs]

set_property SLEW FAST [get_ports {vout_data[*]}]
set_property SLEW FAST [get_ports vout_de]
set_property SLEW FAST [get_ports vout_hs]
set_property SLEW FAST [get_ports vout_vs]

set_property PACKAGE_PIN K18 [get_ports vin_clk]
set_property PACKAGE_PIN M20 [get_ports {vin_data[0]}]
set_property PACKAGE_PIN N20 [get_ports {vin_data[1]}]
set_property PACKAGE_PIN L21 [get_ports {vin_data[2]}]
set_property PACKAGE_PIN M21 [get_ports {vin_data[3]}]
set_property PACKAGE_PIN K19 [get_ports {vin_data[4]}]
set_property PACKAGE_PIN H17 [get_ports {vin_data[5]}]
set_property PACKAGE_PIN H18 [get_ports {vin_data[6]}]
set_property PACKAGE_PIN N22 [get_ports {vin_data[7]}]
set_property PACKAGE_PIN M22 [get_ports {vin_data[8]}]
set_property PACKAGE_PIN K22 [get_ports {vin_data[9]}]
set_property PACKAGE_PIN K21 [get_ports {vin_data[10]}]
set_property PACKAGE_PIN J22 [get_ports {vin_data[11]}]
set_property PACKAGE_PIN H22 [get_ports {vin_data[12]}]
set_property PACKAGE_PIN H20 [get_ports {vin_data[13]}]
set_property PACKAGE_PIN G20 [get_ports {vin_data[14]}]
set_property PACKAGE_PIN M17 [get_ports {vin_data[15]}]
set_property PACKAGE_PIN J16 [get_ports {vin_data[16]}]
set_property PACKAGE_PIN G17 [get_ports {vin_data[17]}]
set_property PACKAGE_PIN G18 [get_ports {vin_data[18]}]
set_property PACKAGE_PIN G15 [get_ports {vin_data[19]}]
set_property PACKAGE_PIN G16 [get_ports {vin_data[20]}]
set_property PACKAGE_PIN J19 [get_ports {vin_data[21]}]
set_property PACKAGE_PIN H19 [get_ports {vin_data[22]}]
set_property PACKAGE_PIN J20 [get_ports {vin_data[23]}]
set_property PACKAGE_PIN N19 [get_ports vin_de]
set_property PACKAGE_PIN N18 [get_ports vin_hs]
set_property PACKAGE_PIN J21 [get_ports hdmi_in_nreset]
set_property PACKAGE_PIN M18 [get_ports vin_vs]

set_property IOSTANDARD LVCMOS33 [get_ports vin_clk]
set_property IOSTANDARD LVCMOS33 [get_ports {vin_data[*]}]
set_property IOSTANDARD LVCMOS33 [get_ports vin_de]
set_property IOSTANDARD LVCMOS33 [get_ports vin_hs]
set_property IOSTANDARD LVCMOS33 [get_ports vin_vs]
set_property IOSTANDARD LVCMOS33 [get_ports hdmi_in_nreset]

set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets vout_clk_OBUF]

set_property DRIVE 12 [get_ports {vout_data[12]}]
set_property DRIVE 16 [get_ports vout_clk]
set_property DRIVE 12 [get_ports vout_de]
set_property DRIVE 12 [get_ports vout_hs]

############## key define#################################
set_property PACKAGE_PIN L19 [get_ports {key_in[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {key_in[0]}]

set_property PACKAGE_PIN L20 [get_ports {key_in[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {key_in[1]}]
set_property PACKAGE_PIN K17 [get_ports {key_in[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {key_in[2]}]

set_property PACKAGE_PIN J17 [get_ports {key_in[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {key_in[3]}]

create_clock -period 6.734 -name vin_clk -waveform {0.000 3.367} [get_ports vin_clk]

###############################################################################
# Video over Ethernet -- RGMII PHY
#
# Pinout copied from 26_video_ethernet/auto_create_project/src/constraints/top.xdc
# and checked pin-by-pin against everything above: no conflicts.
#
# NOTE: no `IOB TRUE` here, deliberately. Unlike the vout_* parallel RGB bus,
# the RGMII pins are driven/received through ODDR/IDDR primitives, which already
# specify the IOLOGIC site. Adding IOB TRUE on top makes the placer reject the
# ODDR/IDDR placement.
###############################################################################
create_clock -period 8.000 -name rgmii_rxc [get_ports rgmii_rxc]

set_property PACKAGE_PIN V18 [get_ports rgmii_rxc]
set_property PACKAGE_PIN R19 [get_ports rgmii_rxctl]
set_property PACKAGE_PIN P17 [get_ports {rgmii_rxd[3]}]
set_property PACKAGE_PIN U17 [get_ports {rgmii_rxd[2]}]
set_property PACKAGE_PIN U18 [get_ports {rgmii_rxd[1]}]
set_property PACKAGE_PIN P19 [get_ports {rgmii_rxd[0]}]
set_property PACKAGE_PIN P15 [get_ports rgmii_txc]
set_property PACKAGE_PIN N17 [get_ports rgmii_txctl]
set_property PACKAGE_PIN R16 [get_ports {rgmii_txd[3]}]
set_property PACKAGE_PIN R17 [get_ports {rgmii_txd[2]}]
set_property PACKAGE_PIN P16 [get_ports {rgmii_txd[1]}]
set_property PACKAGE_PIN N14 [get_ports {rgmii_txd[0]}]
set_property PACKAGE_PIN R14 [get_ports e_reset]
set_property PACKAGE_PIN N13 [get_ports e_mdc]
set_property PACKAGE_PIN P14 [get_ports e_mdio]

set_property IOSTANDARD LVCMOS33 [get_ports rgmii_rxc]
set_property IOSTANDARD LVCMOS33 [get_ports rgmii_rxctl]
set_property IOSTANDARD LVCMOS33 [get_ports {rgmii_rxd[*]}]
set_property IOSTANDARD LVCMOS33 [get_ports rgmii_txc]
set_property IOSTANDARD LVCMOS33 [get_ports rgmii_txctl]
set_property IOSTANDARD LVCMOS33 [get_ports {rgmii_txd[*]}]
set_property IOSTANDARD LVCMOS33 [get_ports e_reset]
set_property IOSTANDARD LVCMOS33 [get_ports e_mdc]
set_property IOSTANDARD LVCMOS33 [get_ports e_mdio]

# SLEW FAST on the transmit side only. The receive pins are inputs; SLEW has no
# meaning there and setting it produces a spurious critical warning.
set_property SLEW FAST [get_ports rgmii_txc]
set_property SLEW FAST [get_ports rgmii_txctl]
set_property SLEW FAST [get_ports {rgmii_txd[*]}]

# MDIO is never driven (e_mdio is parked at 1'bz). Without a board pull-up the
# pin would float, so enable the internal one.
set_property PULLUP TRUE [get_ports e_mdio]

# The reference design shipped these pins unconstrained, which is exactly where
# the timing budget actually lives:
#   - RX goes through a FIXED IDELAY of 30 taps (2.34 ns at the 200 MHz REFCLK,
#     ~78 ps/tap). Fixed, not VAR_LOAD/auto-calibrated, so it does not adapt.
#     2.34 ns centres the sampling point in RGMII's 4 ns DDR data eye, so the
#     PHY is assumed to source rxd/rxctl edge-aligned with rxc (its own internal
#     RGMII RX delay off) and the FPGA supplies the whole shift.
#   - TX is edge-aligned: util_gmii_to_rgmii regenerates rgmii_txc from the same
#     clock that launches the data (ODDR, SAME_EDGE), with no phase shift. So
#     txd/txctl and txc leave together and the PHY must sample with its internal
#     RGMII TX delay, or the board must have matched the trace lengths.
#
# The numbers below model board/PLL skew, not silicon requirements -- they are
# deliberately loose. If the PHY datasheet gives real setup/hold values, replace
# them; do not tighten them to "make timing pass".
set_input_delay  -clock [get_clocks rgmii_rxc] -max  1.0 -min  0.0 \
    [get_ports {rgmii_rxd[*] rgmii_rxctl}]

# rgmii_txc is regenerated in the fabric, so it needs its own generated clock to
# be a meaningful reference for txd/txctl -- otherwise the output ports have no
# launch clock and go unconstrained.
create_generated_clock -name rgmii_txc_out -source [get_ports rgmii_rxc] \
    -divide_by 1 [get_ports rgmii_txc]

set_output_delay -clock [get_clocks rgmii_txc_out] -max  1.0 -min -1.0 \
    [get_ports {rgmii_txd[*] rgmii_txctl}]

# Three clocks that are genuinely unrelated: the 200 MHz board oscillator (and
# everything the MMCM derives from it), the 148.5 MHz HDMI input pixel clock,
# and the 125 MHz RGMII receive clock. Without this the tools try to time the
# paths that cross the camera_fifo, which are only made safe by the FIFO's own
# CDC, and the reported failures bury the real ones.
set_clock_groups -asynchronous \
    -group [get_clocks -include_generated_clocks sys_clk_p] \
    -group [get_clocks -include_generated_clocks vin_clk] \
    -group [get_clocks -include_generated_clocks rgmii_rxc]
