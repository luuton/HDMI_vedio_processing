set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]
#############SPI 配置设置#############################
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design] 
set_property CONFIG_MODE SPIx4 [current_design] 
set_property BITSTREAM.CONFIG.CONFIGRATE 50 [current_design] 
############## 时钟定义######################
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

############## 按键定义###################################
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
# 以太网视频传输 -- RGMII PHY
#
# 引脚分配复制自 26_video_ethernet/auto_create_project/src/constraints/top.xdc
# 并已与上面的所有内容逐引脚核对:无冲突。
#
# 注意:这里刻意不做 `IOB TRUE`。与 vout_* 并行 RGB 总线不同,
# RGMII 引脚是通过 ODDR/IDDR 原语驱动/接收的,而这些原语已经
# 指定了 IOLOGIC 位置。在其之上再加 IOB TRUE 会让布局器拒绝
# ODDR/IDDR 的布局。
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

# 只在发送侧使用 SLEW FAST。接收引脚是输入,SLEW
# 在那里没有意义,设置它会产生一条虚假的 critical warning。
set_property SLEW FAST [get_ports rgmii_txc]
set_property SLEW FAST [get_ports rgmii_txctl]
set_property SLEW FAST [get_ports {rgmii_txd[*]}]

# MDIO 从不被驱动(e_mdio 被置为 1'bz)。板上没有上拉电阻时
# 该引脚会浮空,所以启用内部上拉。
set_property PULLUP TRUE [get_ports e_mdio]

# 参考设计发布时这些引脚未加约束,而时序预算恰恰就
# 落在这些引脚上:
#   - RX 经过 30 抽头的 FIXED IDELAY(在 200 MHz REFCLK 下为 2.34 ns,
#     ~78 ps/抽头)。是 Fixed 而非 VAR_LOAD/自动校准,因此不自适应。
#     2.34 ns 把采样点对准 RGMII 4 ns DDR 数据眼图的中心,所以
#     假定 PHY 输出的 rxd/rxctl 与 rxc 边沿对齐(其内部
#     RGMII RX 延迟关闭),整个偏移由 FPGA 提供。
#   - TX 是边沿对齐的:util_gmii_to_rgmii 用与发送数据相同的
#     时钟(ODDR,SAME_EDGE)重新生成 rgmii_txc,不做相移。因此
#     txd/txctl 与 txc 一起发出,PHY 必须用其内部
#     RGMII TX 延迟采样,或者板上走线长度必须匹配。
#
# 下面的数字是在建模板级/PLL 偏斜,而不是硅片要求 —— 它们
# 是故意放松的。如果 PHY 数据手册给出了真实的 setup/hold 值,请替换
# 掉它们;不要为了“让时序通过”而收紧这些数字。
set_input_delay  -clock [get_clocks rgmii_rxc] -max  1.0 -min  0.0 \
    [get_ports {rgmii_rxd[*] rgmii_rxctl}]

# rgmii_txc 是在 fabric 内重新生成的,所以它需要自己的生成时钟,才能
# 成为 txd/txctl 的有意义参考 —— 否则这些输出端口没有
# 发起时钟,处于未约束状态。
create_generated_clock -name rgmii_txc_out -source [get_ports rgmii_rxc] \
    -divide_by 1 [get_ports rgmii_txc]

set_output_delay -clock [get_clocks rgmii_txc_out] -max  1.0 -min -1.0 \
    [get_ports {rgmii_txd[*] rgmii_txctl}]

# 三个确实互不相关的时钟:200 MHz 板载晶振(以及
# MMCM 由它派生出的所有时钟)、148.5 MHz 的 HDMI 输入像素时钟,
# 以及 125 MHz 的 RGMII 接收时钟。没有这一条,工具会去分析
# 跨越 camera_fifo 的路径,而这些路径只靠 FIFO 自身的
# CDC 才安全,报出的失败会淹没真正的失败。
set_clock_groups -asynchronous \
    -group [get_clocks -include_generated_clocks sys_clk_p] \
    -group [get_clocks -include_generated_clocks vin_clk] \
    -group [get_clocks -include_generated_clocks rgmii_rxc]
