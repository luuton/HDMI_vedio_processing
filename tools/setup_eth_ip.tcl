# ============================================================================
# tools/setup_eth_ip.tcl
#
# 视频以太网通道的一次性工程改造。
#
# 在已经打开 hdmi_loop.xpr 的 Vivado Tcl 控制台里运行:
#
#     source tools/setup_eth_ip.tcl
#
# 或者无界面运行(GUI 里不能同时开着这个工程):
#
#     vivado -mode batch -source tools/setup_eth_ip.tcl
#
# 三件事,每件都是必须的:
#
#   1. 把 hdmi_loop.srcs/sources_1/ethernet/ 下的 Verilog 加进 sources_1。
#      Vivado 不会自己发现被丢进源码树里的文件。
#
#   2. 把 sys_pll 从 Differential_clock_capable_pin 改成 No_buffer,
#      并重新生成。就是这一步卡住了其他所有事情:
#      顶层现在自己在 sys_clk_p/n 上例化 IBUFDS+BUFG,因为 IDELAYCTRL
#      需要那个 200 MHz 参考时钟,而唯一能取到它的地方就是同一对引脚
#      —— 而一对 clock-capable 引脚只能驱动恰好一个输入缓冲。
#      用旧设置时,生成出来的 wrapper 会暴露 clk_in1_p/clk_in1_n,
#      而 hdmi_loop.v 驱动的是 clk_in1,于是 elaborate 失败。
#      用新设置时没有内部 IBUFDS,
#      clk_in1 就是一个普通输入。
#
#   3. 创建 camera_fifo:4096 x 8、独立时钟、block RAM、标准 FIFO、
#      带 wr_rst_busy / rd_rst_busy 的异步复位。
#
# 这里选择新建 FIFO,而不是从 26_video_ethernet 拷贝,是有意为之。
# 那个 .xci 是 Vivado 2023.1.1 针对另一个器件写的,
# 它的 gen_directory 指向本工程里并不存在的路径。
# 在 2021.2 里打开它会触发一次 IP 升级,而升级可以随意改动复位结构
# —— 具体说就是 eth_video_tx 的帧边界控制器要等的那个
# wr_rst_busy / rd_rst_busy 握手。用同一套参数重新建一个,
# 结果是确定的。
#
# 可以重复运行:每一步都会先检查自己是否已经做过。
# ============================================================================

if {[catch {current_project} proj] || $proj eq ""} {
    # 是用 -mode batch 打开的吗?那就试着在本脚本旁边找 hdmi_loop.xpr。
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
# 1. 源文件
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

# get_files 返回的是正斜杠路径;比较前两边都要归一化。
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
# 2. sys_pll 输入缓冲
# ---------------------------------------------------------------------------
set pll_ips [get_ips -quiet sys_pll]
if {[llength $pll_ips] == 0} {
    error "IP 'sys_pll' not found in the project."
}

set prim_src [get_property -quiet CONFIG.PRIM_SOURCE [get_ips sys_pll]]
puts "==> sys_pll PRIM_SOURCE is currently '$prim_src'"

if {$prim_src ne "No_buffer"} {
    # 重写 PRIM_IN_FREQ 是为了让 MMCM 的解保持不变:同样的 200 MHz
    # 输入、同样的 742.5 MHz VCO、同样的 27 / 148.5 MHz 输出。只是缓冲
    # 挪到了 IP 外面。
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

    # 参数完全照搬 26_video_ethernet 的 camera_fifo.xci,只是把
    # Write_Data_Count 关掉,因为这里没人读 wr_data_count。
    #
    # 对 4096 深的 FIFO 来说,Read_Data_Count_Width 用 12 是有意为之:满的时候
    # 计数值读出来是 0,而不是 4096。这可以接受,因为写侧会在 FIFO 被抽干之前
    # 停下,而帧边界控制器从来只判断是否为零 —— 也因为入 62 MB/s、出约 118 MB/s
    # 意味着占用深度一直停留在几百的量级。不要在没有同时加宽
    # mac_test 里的 fifo_data_count 和 eth_video_tx 里的 fifo_rdusedw 的情况下,
    # 把它"修"成 13。
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
# 校验最终状态,而不是打印一份清单。某一步要是悄悄什么都没做,
# 代价是一整轮综合,再加上一个指向完全不相干位置的 elaborate 报错 ——
# 而这正是本脚本要防止的失效,也正是本脚本
# 存在的意义所在。
#
# 注意:下面每个 '[' 要么是真的 Tcl 命令替换,要么被反斜杠
# 转义过。puts 字符串里裸写一个 '[Common 17-69]' 会被当成命令执行。
# ---------------------------------------------------------------------------
puts ""
puts "============================== verification ================================"

set problems 0

# 1. sys_pll 不再自带输入缓冲。
set prim_src [get_property -quiet CONFIG.PRIM_SOURCE [get_ips sys_pll]]
if {$prim_src eq "No_buffer"} {
    puts "  OK    sys_pll PRIM_SOURCE = No_buffer"
} else {
    puts "  FAIL  sys_pll PRIM_SOURCE = '$prim_src' (expected No_buffer)"
    incr problems
}

# 2. 重新生成出来的 wrapper 必须暴露 clk_in1,而不是差分对 ——
#    这才是真正让 hdmi_loop.v 能 elaborate 的东西。
# proj_dir 是存放 .xpr 的目录,所以 hdmi_loop.gen 和
# hdmi_loop.srcs 就在它下面。
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

# 3. camera_fifo 存在,并且带 12 位读数据计数 —— 这正是 RTL 所假设的。
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

# 4. 每个以太网源文件都确实进了工程。
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
