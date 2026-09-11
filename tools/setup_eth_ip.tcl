# ============================================================================
# tools/setup_eth_ip.tcl
#
# One-time project surgery for the video-over-Ethernet channel.
#
# Run from the Vivado Tcl console with hdmi_loop.xpr already open:
#
#     source tools/setup_eth_ip.tcl
#
# or headless (Vivado must not be holding the project open in the GUI):
#
#     vivado -mode batch -source tools/setup_eth_ip.tcl
#
# Three things, each mandatory:
#
#   1. Add the Verilog under hdmi_loop.srcs/sources_1/ethernet/ to sources_1.
#      Vivado does not notice files dropped into the source tree on its own.
#
#   2. Switch sys_pll from Differential_clock_capable_pin to No_buffer and
#      regenerate it. This is the step that blocks everything else: the top
#      level now instantiates IBUFDS+BUFG on sys_clk_p/n itself, because
#      IDELAYCTRL needs the 200 MHz reference and the only place to get it is
#      that same pin pair -- and one clock-capable pair may drive exactly one
#      input buffer. With the old setting the generated wrapper exposes
#      clk_in1_p/clk_in1_n, hdmi_loop.v drives clk_in1, and elaboration fails.
#      With the new one there is no internal IBUFDS and clk_in1 is a plain
#      input.
#
#   3. Create camera_fifo: 4096 x 8, independent clocks, block RAM, standard
#      FIFO, asynchronous reset with wr_rst_busy / rd_rst_busy.
#
# The FIFO is created here rather than copied from 26_video_ethernet on
# purpose. That .xci was written by Vivado 2023.1.1 against a different device
# and its gen_directory points at a path that does not exist in this project.
# Opening it in 2021.2 triggers an IP upgrade, and an upgrade is free to change
# the reset structure -- specifically the wr_rst_busy / rd_rst_busy handshake
# that eth_video_tx's frame-boundary controller waits on. Creating it fresh
# from the same parameter set is deterministic.
#
# Safe to re-run: each step checks whether it has already been done.
# ============================================================================

if {[catch {current_project} proj] || $proj eq ""} {
    # Opened with -mode batch? Try to find hdmi_loop.xpr next to this script.
    set here [file dirname [file normalize [info script]]]
    set xpr  [file join [file dirname $here] hdmi_loop.xpr]
    if {[file exists $xpr]} {
        puts "==> no project open, opening $xpr"
        open_project $xpr
        set proj [current_project]
    } else {
        error "No project is open and $xpr does not exist. Open hdmi_loop.xpr first."
    }
}
set proj_name [get_property NAME [current_project]]
puts "==> project: $proj"

set proj_dir [get_property DIRECTORY [current_project]]
set eth_dir  [file normalize [file join $proj_dir hdmi_loop.srcs sources_1 ethernet]]

if {![file isdirectory $eth_dir]} {
    error "Ethernet source directory not found: $eth_dir"
}

# ---------------------------------------------------------------------------
# 1. sources
# ---------------------------------------------------------------------------
set eth_files {}
foreach f [lsort [glob -nocomplain -directory $eth_dir -types f *.v]] {
    lappend eth_files $f
}
foreach sub {mac mac/rx mac/tx} {
    set d [file join $eth_dir $sub]
    if {[file isdirectory $d]} {
        foreach f [lsort [glob -nocomplain -directory $d -types f *.v]] {
            lappend eth_files $f
        }
    }
}

if {[llength $eth_files] == 0} {
    error "No .v files found under $eth_dir"
}

# get_files returns forward-slashed paths; normalise both sides before comparing.
set already {}
foreach f [get_files -quiet -all] {
    lappend already [string tolower [file normalize $f]]
}

set added 0
set skipped 0
foreach f $eth_files {
    if {[lsearch -exact $already [string tolower [file normalize $f]]] >= 0} {
        incr skipped
    } else {
        add_files -norecurse -fileset sources_1 $f
        incr added
    }
}
puts "==> sources: $added added, $skipped already present ([llength $eth_files] total)"
update_compile_order -fileset sources_1

# ---------------------------------------------------------------------------
# 2. sys_pll input buffer
# ---------------------------------------------------------------------------
set pll_ips [get_ips -quiet sys_pll]
if {[llength $pll_ips] == 0} {
    error "IP 'sys_pll' not found in the project."
}

set prim_src [get_property -quiet CONFIG.PRIM_SOURCE [get_ips sys_pll]]
puts "==> sys_pll PRIM_SOURCE is currently '$prim_src'"

if {$prim_src ne "No_buffer"} {
    # PRIM_IN_FREQ is restated so the MMCM solution is unchanged: same 200 MHz
    # input, same 742.5 MHz VCO, same 27 / 148.5 MHz outputs. Only the buffer
    # moves out of the IP.
    set_property -dict [list \
        CONFIG.PRIM_SOURCE {No_buffer}    \
        CONFIG.PRIM_IN_FREQ {200.000}     \
    ] [get_ips sys_pll]

    generate_target all [get_ips sys_pll] -force

    set prim_src [get_property -quiet CONFIG.PRIM_SOURCE [get_ips sys_pll]]
    if {$prim_src ne "No_buffer"} {
        error "PRIM_SOURCE did not change (still '$prim_src'). Regenerate sys_pll by hand."
    }
    puts "==> sys_pll regenerated with PRIM_SOURCE=No_buffer (clk_in1 is now a plain input)"
} else {
    puts "==> sys_pll already No_buffer, nothing to do"
}

# ---------------------------------------------------------------------------
# 3. camera_fifo
# ---------------------------------------------------------------------------
if {[llength [get_ips -quiet camera_fifo]] > 0} {
    puts "==> camera_fifo already exists, nothing to do"
} else {
    create_ip -name fifo_generator -vendor xilinx.com -library ip \
        -version 13.2 -module_name camera_fifo

    # Parameters follow 26_video_ethernet's camera_fifo.xci exactly, with
    # Write_Data_Count turned off because nothing reads wr_data_count here.
    #
    # Read_Data_Count_Width 12 is deliberate for a 4096-deep FIFO: at full the
    # count reads 0 instead of 4096. That is acceptable because the writer is
    # stopped before the FIFO is drained and the frame-boundary controller only
    # ever tests for zero -- and because 62 MB/s in against ~118 MB/s out means
    # occupancy stays in the low hundreds. Do not "fix" it to 13 without also
    # widening fifo_data_count in mac_test and fifo_rdusedw in eth_video_tx.
    set_property -dict [list \
        CONFIG.Fifo_Implementation          {Independent_Clocks_Block_RAM} \
        CONFIG.Performance_Options          {Standard_FIFO}                \
        CONFIG.Input_Data_Width             {8}                            \
        CONFIG.Input_Depth                  {4096}                         \
        CONFIG.Output_Data_Width            {8}                            \
        CONFIG.Reset_Pin                    {true}                         \
        CONFIG.Reset_Type                   {Asynchronous_Reset}           \
        CONFIG.Enable_Reset_Synchronization {true}                         \
        CONFIG.Use_Dout_Reset               {true}                         \
        CONFIG.Full_Flags_Reset_Value       {1}                            \
        CONFIG.Enable_Safety_Circuit        {true}                         \
        CONFIG.Read_Data_Count              {true}                         \
        CONFIG.Read_Data_Count_Width        {12}                           \
        CONFIG.Write_Data_Count             {false}                        \
        CONFIG.Data_Count                   {false}                        \
    ] [get_ips camera_fifo]

    generate_target {instantiation_template synthesis simulation} [get_ips camera_fifo]
    puts "==> camera_fifo created and generated"
}

update_compile_order -fileset sources_1

# ---------------------------------------------------------------------------
# Verify the resulting state instead of printing a checklist. A step that
# silently did nothing costs a whole synthesis run and then an elaboration error
# that points somewhere else entirely, which is exactly the failure this script
# exists to prevent.
#
# Note: every '[' below is a real Tcl command substitution or is backslash
# escaped. A bare '[Common 17-69]' in a puts string is executed as a command.
# ---------------------------------------------------------------------------
puts ""
puts "============================== verification ================================"

set problems 0

# 1. sys_pll no longer owns an input buffer.
set prim_src [get_property -quiet CONFIG.PRIM_SOURCE [get_ips sys_pll]]
if {$prim_src eq "No_buffer"} {
    puts "  OK    sys_pll PRIM_SOURCE = No_buffer"
} else {
    puts "  FAIL  sys_pll PRIM_SOURCE = '$prim_src' (expected No_buffer)"
    incr problems
}

# 2. The regenerated wrapper must expose clk_in1, not a differential pair --
#    this is the thing that actually makes hdmi_loop.v elaborate.
# proj_dir is the directory holding the .xpr, so hdmi_loop.gen and
# hdmi_loop.srcs sit directly under it.
set wrappers {}
foreach sub {gen srcs} {
    set pat [file join $proj_dir ${proj_name}.${sub} sources_1 ip sys_pll *clk_wiz.v]
    foreach f [glob -nocomplain $pat] { lappend wrappers $f }
}
if {[llength $wrappers] == 0} {
    puts "  ??    no sys_pll_clk_wiz.v found on disk; cannot check the wrapper port list"
} else {
    foreach w $wrappers {
        set fh [open $w r]
        set body [read $fh]
        close $fh
        if {[string match "*clk_in1_p*" $body]} {
            puts "  FAIL  [file tail $w] still exposes clk_in1_p -- hdmi_loop.v will not elaborate"
            incr problems
        } else {
            puts "  OK    [file tail $w] exposes clk_in1"
        }
    }
}

# 3. camera_fifo exists and has the 12-bit read data count the RTL assumes.
if {[llength [get_ips -quiet camera_fifo]] == 0} {
    puts "  FAIL  camera_fifo IP is missing"
    incr problems
} else {
    set rdc [get_property -quiet CONFIG.Read_Data_Count_Width [get_ips camera_fifo]]
    set dep [get_property -quiet CONFIG.Input_Depth [get_ips camera_fifo]]
    if {$rdc eq "12" && $dep eq "4096"} {
        puts "  OK    camera_fifo ${dep}x8, rd_data_count width $rdc"
    } else {
        puts "  FAIL  camera_fifo is ${dep}x8 with rd_data_count width '$rdc' (expected 4096 / 12)"
        incr problems
    }
}

# 4. Every ethernet source file actually made it into the project.
set now_in {}
foreach f [get_files -quiet -all] {
    lappend now_in [string tolower [file normalize $f]]
}
set missing {}
foreach f $eth_files {
    if {[lsearch -exact $now_in [string tolower [file normalize $f]]] < 0} {
        lappend missing $f
    }
}
if {[llength $missing] > 0} {
    puts "  FAIL  [llength $missing] ethernet source file(s) not in the project:"
    foreach m $missing { puts "          $m" }
    incr problems
} else {
    puts "  OK    all [llength $eth_files] ethernet source file(s) in the project"
}

puts "============================================================================"
if {$problems == 0} {
    puts "ALL CHECKS PASSED -- safe to Run Synthesis."
} else {
    puts "$problems CHECK(S) FAILED -- do NOT synthesise until these are resolved."
}
puts "============================================================================"
