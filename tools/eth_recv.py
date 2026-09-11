#!/usr/bin/env python3
# -*- coding: utf-8 -*-
r"""
eth_recv.py —— 通过 UDP 接收 hdmi_loop 的 960x540 RGB565 视频流。

FPGA 侧(见 hdmi_loop.srcs/sources_1/ethernet/)把抽取后的画面切成连续的
768 字节 UDP 报文,发往 192.168.0.3:8080,源 IP 192.168.0.2,MAC
00:0a:35:01:fe:c0。工程里 ARP 表项没有老化、MDIO 也不工作,所以**上电之前**
PC 的 IPv4 地址必须已经是 192.168.0.3。否则板子会每秒重发一次 ARP 直到天荒
地老,画面永远不来。

协议
----
* 一帧 = 540 行 × 1920 字节 = 1,036,800 字节 = 1350 × 768,正好是整数个报文,
  不会有哪个包跨在两帧之间。(当初选 768 就是为这个:1024 除不尽,余 512。)
* 行号同时写在**两个地方**,因此有两条读取路径,由 --framing 选择:

  raw  (源端口改动之前和之后的 bitstream 都支持)
       FPGA 把行号写进 IP 头的 Identification 字段(mac_test 的 identify_code:
       vsync 清零,每过一个保留行 +1)。要读它就得看见 IP 头,而普通 UDP 套接
       字**拿不到** IP 头——内核已经剥掉了。所以这条路径必须开 SOCK_RAW,
       在 Windows 上要管理员权限。参考工程的 video.exe 就是这条路:它是
       WinPcap 抓包(pcap_open_live/pcap_next_ex),不是 UDP 套接字。

  port (mac_test.v 源端口改动之后编出的 bitstream)
       同一个行号写进 UDP **源端口**:0x1000 | (行号 & 0x3FF),目的端口仍是
       8080。标号是 **1 基**的——板子 540 行发出来是 1~540,所以线上实际看到
       的源端口是 4097~4636(0 从不发送,见 LINE_MAX)。加掩码只是为了让端口
       永远出不了 0x1000~0x13FF,于是"这是不是源端口版 bitstream"这个判断无
       法被误判。这条路径普通 UDP 套接字就够——recvfrom 本来就会告诉我们源端
       口——所以不需要管理员、不用和防火墙较劲、也不用在 8.1 万包/秒的速率下
       解析包头。**推荐用这条**。高于 4636 的端口会被拒绝:那只能是计数器跑飞
       后被掩码绕回来的结果,不可能是某一行。

  auto (默认) 先用普通 UDP 套接字探一下——这一步不要钱也不要权限——然后要么
       继续用这个套接字(源端口定界),要么重开一个原始套接字。它**不会静默降
       级**:如果 bitstream 需要 raw 而 raw 开不起来,那是硬错误,因为"拿源端口
       定界去接原始 bitstream"正是本脚本要杜绝的那种故障。

* 两种方式下行号在一帧内都单调不减、在帧边界回退,所以 `行号 < 上一个行号`
  即帧边界。这个规则在丢包后能自己重新对齐;而"数到 1350 个包"一旦中途丢一
  个就永久错位。
* 拼出来的长度不等于 1,036,800 就说明丢过包。这类帧只计数并丢弃,不显示,
  因为短帧解出来是明显错行的画面,会把真正的问题盖住。
* 像素字节是大端 RGB565,高字节在前。UDP 校验和恒为 0(不计算),IP 校验和
  只覆盖 IP 头,所以线上没有任何东西依赖源端口——这正是把行号挪到源端口
  "零代价"的原因。

数据量:约 81,000 包/秒、约 62 MB/s。下面的收包循环刻意避免逐包分配——在这个
速率下每包多一次拷贝比解析本身还贵。如果仍然看到丢包,把套接字缓冲区调大:
    Windows:  netsh int ipv4 set global defaultreceivewindow=<bytes>
    Linux:    sysctl -w net.core.rmem_max=<bytes>

用别的工具代替本脚本
--------------------
PotPlayer、VLC、ffmpeg 这些是播放器——它们打开文件和流(http/rtsp/rtmp),
而不是"监听一个 UDP 端口并把某种私有包格式拼回去"。PotPlayer 完全做不到。
ffmpeg **可以**,因为它的 udp:// 输入把报文当成裸字节流,而本协议恰好就是:

    ffmpeg -f rawvideo -pixel_format rgb565be -video_size 960x540 -framerate 60 \
           -i "udp://0.0.0.0:8080?listen=1&overrun_nonfatal=1&fifo_size=20000000" \
           -f sdl "hdmi_loop"

把 `-f sdl -` 换成输出文件,或者用 `-c:v libx264 out.mp4` 录制。源端口改动之后
这条命令依然有效,因为目的端口没动。它用起来方便,但**没有任何丢包检测**:丢一
个包就会把那帧剩下的部分整体错位,而且它根本不做定界——ffmpeg 只是把字节接起
来。当你需要确认"我看到的画面可不可信"时,请用本脚本。

用法
----
    python eth_recv.py                     # 先探测,再实时显示
    python eth_recv.py --framing port      # 强制用源端口定界
    python eth_recv.py --framing raw       # 强制用 IP 头定界(需管理员)
    python eth_recv.py --no-display        # 只看统计,不开窗口
    python eth_recv.py --save out.avi      # 同时录制
    python eth_recv.py --bind 192.168.0.3  # PC 有多张网卡时

    # 不开窗口,抓一帧存 PNG、再录十秒视频:
    python eth_recv.py --no-display --duration 10 \
        --snapshot frames/one.png --save frames/ten.avi

    python eth_recv.py --snapshot frame.bin   # 改存原始的 1,036,800 字节

依赖 numpy 和 opencv-python(`pip install numpy opencv-python`)。
跑 tools/tb_eth_recv.py 可以在不插板子的情况下自检两条定界路径。
"""

import argparse
import errno
import os
import socket
import sys
import time

try:
    import numpy as np
except ImportError:
    sys.exit("numpy is required:  pip install numpy")

FRAME_W, FRAME_H = 960, 540
FRAME_BYTES = FRAME_W * FRAME_H * 2          # RGB565
PAYLOAD_BYTES = 768                          # 必须整除 FRAME_BYTES:1350 个包
PACKETS_PER_FRAME = FRAME_BYTES // PAYLOAD_BYTES

BOARD_IP = "192.168.0.2"
PC_IP = "192.168.0.3"
BOARD_MAC = "00-0a-35-01-fe-c0"              # `arp -a` 打印出来的那种写法

UDP_HDR = 8
IP_HDR_MIN = 20

# 源端口定界:FPGA 把 0x1000 | (行号 & 0x3FF) 写进 UDP 源端口。掩码是有意的
# ——即使 identify_code 跑飞,端口也出不了这个窗口,于是"这是不是源端口版
# bitstream"永远是个可靠的判断,且行号恒等于 端口 - PORT_BASE。
PORT_BASE = 0x1000
PORT_MAX = PORT_BASE + 0x3FF

# 板子的标号是 1 基的。identify_code 在 vsync 沿清零,之后第一个像素行 href 的
# 下降沿就 +1,所以一帧 540 行发出来是 1~540,不是 0~539。**实机实测**:32 万个
# 包中源端口只出现 4097~4636,而 4096(行号 0)一次都没出现过。
#
# 所以这个标号只是**排序提示**,不是行索引——重组器只问"它回退了吗",跟基数是
# 几无关。这里接受 0~FRAME_H 整个区间,把"计数器跑飞"交给下面的计数器去抓。
LINE_MAX = FRAME_H

# 只有行号回退才会触发帧边界。如果它一直不回退——正是"拿源端口定界去接一个仍把
# 行号放在 IP 头里的 bitstream"会发生的事,此时源端口恒为 8080——组装缓冲区就会
# 以 62 MB/s 一直涨到把内存吃光。这里给它封顶,溢出即视为失锁。
MAX_CUR = FRAME_BYTES + PAYLOAD_BYTES


class Counters:
    """各类拒绝原因的计数。用 __slots__ 是因为它每包都要被碰一次。"""

    __slots__ = ("rx", "accepted", "short", "ip_ver", "ip_ihl", "proto",
                 "src_ip", "dst_ip", "dst_port", "udp_len", "pay_len",
                 "other_src", "port_range", "unresync", "frames_ok",
                 "frames_bad", "bytes_ok", "warned")

    def __init__(self):
        for name in self.__slots__:
            setattr(self, name, 0)


class Assembler:
    """把 (行号, 载荷) 流还原成一帧一帧。

    特意从 main() 里拆出来。这里唯一有意思的逻辑就是那两条原先写错的规则——
    "行号回退处即帧尾"和"只有正好 FRAME_BYTES 才显示"——而 tb_eth_recv.py 直接
    驱动这个类、而不是驱动它的一份拷贝,所以自检覆盖的正是真正在跑的代码。

    feed() 返回 (status, frame, size):
        "none"    已追加载荷,没什么可报的
        "ok"      frame 是拼完整的 FRAME_BYTES 字节帧(bytearray)
        "short"   边界到了,但只有 size 字节——中间丢过包
        "overrun" MAX_CUR 字节内都没出现边界,流已失步
    """

    __slots__ = ("cur", "prev_line")

    def __init__(self):
        self.cur = bytearray()
        self.prev_line = None

    def feed(self, line, payload):
        status = "none"
        frame = None
        size = 0

        if self.prev_line is not None and line < self.prev_line:
            size = len(self.cur)
            if size == FRAME_BYTES:
                frame = self.cur
                status = "ok"
            else:
                # 短帧解出来是明显错行的画面,显示它等于把丢包藏起来,而不是
                # 报告出来。
                status = "short"
            self.cur = bytearray()

        self.cur += payload
        self.prev_line = line

        if len(self.cur) > MAX_CUR:
            # 已经攒了整整一帧的字节还没等到行号回退,说明没有边界可依。见
            # MAX_CUR 的说明。
            size = len(self.cur)
            self.cur = bytearray()
            self.prev_line = None
            return "overrun", None, size

        return status, frame, size


def to_bgr(frame):
    """1,036,800 字节大端 RGB565 -> 540x960 的 BGR uint8 数组。

    `frame` 可以是 memoryview——np.frombuffer 直接读它、不做拷贝,所以调用方可以
    传组装缓冲区的一个视图而不必先 bytes() 一份。返回的数组是新分配的,因此这里
    没有任何东西与输入别名。
    """
    px = np.frombuffer(frame, dtype=">u2")
    # 在 C 里一次性把字节序换掉。不这么做的话,后面每一次移位/掩码在这个小端宿主
    # 上都会再换一次,而后面的移位/掩码有十几次。
    px = px.astype(np.uint16).reshape(FRAME_H, FRAME_W)
    r = ((px >> 11) & 0x1F).astype(np.uint8)
    g = ((px >> 5) & 0x3F).astype(np.uint8)
    b = (px & 0x1F).astype(np.uint8)
    # 把高位复制到低位,这样 0x1F 会映射成 0xFF 而不是 0xF8。
    r = (r << 3) | (r >> 2)
    g = (g << 2) | (g >> 4)
    b = (b << 3) | (b >> 2)
    return np.dstack([b, g, r])


# --------------------------------------------------------------------------- #
# 两条定界路径。都用闭包写,这样被比较的常量是烘焙进去的——热循环每包要调用其中
# 之一,不能有分配。
# --------------------------------------------------------------------------- #

def make_decoder(mode, port, dst_ip, src_ip=BOARD_IP, port_base=PORT_BASE):
    """返回 decode(buf, n, addr, st) -> (行号, 载荷 memoryview) 或 None。

    `addr` 是 recvfrom 返回的 (ip, port)。每种拒绝都会给各自的计数器加一,这样
    一次"几乎什么都没接受"的运行能说清**为什么**,而不是只打印一行看起来很正常
    的统计然后什么都不说。

    两个地址都做成参数而不是模块全局量,是为了让 tb_eth_recv.py 能拿真实套接字
    在回环地址上驱动解码器——端到端地验证"套接字类型与解析方式"的配对,而这正是
    整件事的症结所在。
    """
    src = socket.inet_aton(src_ip)
    s0, s1, s2, s3 = src[0], src[1], src[2], src[3]
    dst = socket.inet_aton(dst_ip)
    d0, d1, d2, d3 = dst[0], dst[1], dst[2], dst[3]

    def decode_raw(buf, n, addr, st):
        """从 IP 头的 Identification 字段取行号。

        写成"对预分配缓冲区做 memoryview 切片",而不是每包都解出一个新的 bytes
        对象。那些 SOCK_DGRAM 本可以交给内核去做的头部检查,这里在 Python 里自己
        做,因为原始套接字会收到**发往本机的每一个** UDP 报文,而不只是板子的。
        """
        if n < IP_HDR_MIN + UDP_HDR:
            st.short += 1
            return None
        if (buf[0] >> 4) != 4:                       # 只收 IPv4
            st.ip_ver += 1
            return None
        ihl = (buf[0] & 0x0F) * 4
        if ihl < IP_HDR_MIN or n < ihl + UDP_HDR:
            st.ip_ihl += 1
            return None
        # 协议字段在这里查,而不是指望套接字:在 Windows 上
        # socket(AF_INET, SOCK_RAW, IPPROTO_UDP) 收包时**并不**过滤——它会把每
        # 一个 IPv4 报文都交上来。少了这一条,某个 TCP 段只要载荷头两个字节碰巧
        # 长得像端口,就会被当成视频解析。
        if buf[9] != socket.IPPROTO_UDP:
            st.proto += 1
            return None
        if buf[12] != s0 or buf[13] != s1 or buf[14] != s2 or buf[15] != s3:
            st.src_ip += 1
            return None
        if buf[16] != d0 or buf[17] != d1 or buf[18] != d2 or buf[19] != d3:
            st.dst_ip += 1
            return None
        if ((buf[ihl + 2] << 8) | buf[ihl + 3]) != port:
            st.dst_port += 1
            return None
        udp_len = (buf[ihl + 4] << 8) | buf[ihl + 5]
        end = ihl + udp_len
        if udp_len < UDP_HDR or end > n:             # 被截断 / 有填充
            st.udp_len += 1
            return None
        if udp_len - UDP_HDR != PAYLOAD_BYTES:
            st.pay_len += 1                          # 只计数,仍然接受
        # IP Identification = 行号,大端。
        return (buf[4] << 8) | buf[5], memoryview(buf)[ihl + UDP_HDR:end]

    def decode_port(buf, n, addr, st):
        """从 UDP 源端口取行号。完全不解析包头。

        普通 UDP 套接字把载荷交给我们时已经剥掉了头部,n 就是载荷长度,而
        `addr[1]` 是源端口——它就是行号,即 0x1000 + 行号。源 IP 这一关仍然必
        要:没有它,某个不相干应用的临时源端口就可能落进这个看着挺像的区间。
        """
        if addr[0] != src_ip:
            st.other_src += 1
            return None
        src_port = addr[1]
        if src_port < port_base or src_port > port_base + 0x3FF:
            st.dst_port += 1
            return None
        line = src_port - port_base
        # 掩码把端口窗口做成 0x1000..0x13FF(4096..5119),而真正的 identify_code
        # 最高只到 FRAME_H,所以板子的端口是 4097..4636(见 LINE_MAX)。再高就说明
        # 掩码把跑飞的计数器绕回来了——"行号 904"不是视频的某一行,接受它会让
        # 重组器永久失步。
        #
        # 注意这里是 `>` 而不是 `>=`:用 `>= FRAME_H` 当卡会把每个标号为 540 的
        # 包都丢掉,而那是每一帧的帧尾——1350 个包只剩 1347 个,一帧都合不成。
        if line > LINE_MAX:
            st.port_range += 1
            return None
        if n != PAYLOAD_BYTES:
            st.pay_len += 1                              # counted, still accepted
        return line, memoryview(buf)[:n]

    return decode_raw if mode == "raw" else decode_port


# --------------------------------------------------------------------------- #
# 套接字
# --------------------------------------------------------------------------- #

def set_rcvbuf(sock):
    """尽可能向内核要大的接收缓冲区。返回实际拿到的字节数。"""
    # 在 Windows 上第一次 setsockopt 总是"成功"、然后被悄悄截断,所以只有
    # getsockopt 才说真话——实际值要报给用户,而不是假设。
    for want in (8 << 20, 4 << 20, 1 << 20, 256 << 10):
        try:
            sock.setsockopt(socket.SOL_SOCKET, socket.SO_RCVBUF, want)
            break
        except OSError:
            continue
    try:
        return sock.getsockopt(socket.SOL_SOCKET, socket.SO_RCVBUF)
    except OSError:
        return 0


def open_udp_socket(bind, port):
    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    rcvbuf = set_rcvbuf(sock)
    try:
        sock.bind((bind, port))
    except OSError as exc:
        if exc.errno == errno.EADDRINUSE or getattr(exc, "winerror", None) == 10048:
            sys.exit("port %d is already in use -- another copy of this script, "
                     "or ffmpeg, is running." % port)
        raise
    sock.settimeout(1.0)
    return sock, rcvbuf


def open_raw_socket(bind, port):
    """开一个 SOCK_RAW/IPPROTO_UDP 套接字,好让 recvfrom 把 IP 头也交上来。

    Windows 上创建它本身就要求管理员权限,而且 bind() 到 0.0.0.0 会被拒
    (WSAEINVAL)——原始套接字总是绑在一个具体的本机地址上。这两种失败都给一句
    明确的指示,而不是甩一串 traceback。
    """
    try:
        sock = socket.socket(socket.AF_INET, socket.SOCK_RAW, socket.IPPROTO_UDP)
    except OSError as exc:
        if (getattr(exc, "winerror", None) == 10013
                or exc.errno in (errno.EPERM, errno.EACCES)):
            sys.exit(
                "could not create a SOCK_RAW socket: %s\n"
                "  Reading the line number out of the IP header needs a raw\n"
                "  socket, which needs Administrator.\n"
                "  Windows: re-run from an elevated terminal (right-click ->\n"
                "           'Run as administrator'), keeping --framing raw.\n"
                "  Linux:   sudo setcap cap_net_raw+ep $(readlink -f $(which python3))\n"
                "  Or use a bitstream that puts the line number in the UDP\n"
                "  source port and --framing port, which needs no privileges."
                % exc)
        raise

    try:
        sock.bind((bind, 0))
    except OSError as exc:
        winerror = getattr(exc, "winerror", None)
        if winerror == 10022:
            sys.exit("could not bind the raw socket to %s: %s\n"
                     "  A raw socket cannot bind to 0.0.0.0. Pass the PC's real\n"
                     "  address:  --bind 192.168.0.3" % (bind, exc))
        if winerror == 10049 or exc.errno == errno.EADDRNOTAVAIL:
            sys.exit("could not bind the raw socket to %s: %s\n"
                     "  This PC does not own %s. Set the NIC's IPv4 address\n"
                     "  BEFORE powering the board -- the board ARPs once and\n"
                     "  never again, so it keeps talking to whatever MAC last\n"
                     "  answered." % (bind, exc, bind))
        raise

    rcvbuf = set_rcvbuf(sock)
    sock.settimeout(1.0)
    return sock, rcvbuf


def open_firewall_helper(bind, port):
    """一个绑在该端口上的普通 UDP 套接字,从不读取。

    两个作用。其一,绑一个 SOCK_RAW **不会**让 Windows 防火墙建立"应用 + 端口"
    的放行规则,所以少了它,板子的报文可能在原始套接字看到之前就被 WFP 丢掉
    ——而症状是在一条完好的链路上"一个包都收不到"。其二,如果没有任何东西绑在
    这个端口上,主机会对每个报文回 ICMP 端口不可达,也就是每秒 8.1 万个 ICMP
    回复砸回给一块完全没道理期待它们的 FPGA。

    它的缓冲区故意开得很小:反正从不去读,填满就丢。这些丢弃是免费的,也影响不
    到原始套接字——后者有自己的缓冲区。绑失败时返回 None(不致命,说明一下即可)。
    """
    try:
        helper = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        helper.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        helper.setsockopt(socket.SOL_SOCKET, socket.SO_RCVBUF, 8 << 10)
        helper.bind((bind, port))
        return helper
    except OSError as exc:
        print("note: could not bind a helper UDP socket to %s:%d (%s)."
              % (bind, port, exc))
        print("      If Windows Firewall blocks inbound UDP %d, allow it for:"
              % port)
        print("      %s" % sys.executable)
        return None


def print_no_traffic_hint(port):
    print("no packets -- check:")
    print("  * PC IPv4 is %s (arp -a | findstr %s  should show %s)"
          % (PC_IP, BOARD_MAC.replace("-", "-"), BOARD_MAC))
    print("  * key_in[2] has not been toggled off")
    print("  * Windows Firewall allows inbound UDP %d for %s" % (port, sys.executable))
    print("  * the board is powered and the link LED is on")


# --------------------------------------------------------------------------- #
# 定界模式的选择
# --------------------------------------------------------------------------- #

def probe_framing(bind, port):
    """用一个不需要权限的套接字判断线上跑的是哪种 bitstream。

    返回 (mode, sock, rcvbuf),其中 mode 为 "port" 时 sock 就是那个探测用的套接
    字(留着继续用),为 "raw" 时 sock 是 None(调用方另外去开原始套接字)。

    用原始套接字去探测是循环论证——"拿不到管理员权限"恰恰是最需要知道"这个
    bitstream 不需要看包头"的场景。普通 UDP 套接字免费就能回答这个问题:如果板
    子回过来的源端口落在 4097..4636,行号就在端口里,而这个套接字正是该留下的
    那一个。
    """
    sock, rcvbuf = open_udp_socket(bind, port)
    seen = 0
    last_port = 0
    last_packet = time.monotonic()
    while True:
        try:
            _n, addr = sock.recvfrom(2048)
        except socket.timeout:
            if time.monotonic() - last_packet > 3.0:
                print_no_traffic_hint(port)
                last_packet = time.monotonic()
            continue
        last_packet = time.monotonic()
        if addr[0] != BOARD_IP:
            continue
        seen += 1
        last_port = addr[1]
        if PORT_BASE <= addr[1] <= PORT_MAX:
            print("probing: udp.srcport %d is in %d..%d -- the line number is in "
                  "the source port; keeping this socket (no privileges needed)"
                  % (addr[1], PORT_BASE, PORT_MAX))
            return "port", sock, rcvbuf
        if seen >= 32:
            print("probing: udp.srcport %d in all %d packets -- this bitstream "
                  "puts the line number in the IP header, so it needs a raw "
                  "socket (Administrator)"
                  % (last_port, seen))
            sock.close()
            return "raw", None, 0


# --------------------------------------------------------------------------- #

def main():
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--framing", choices=("auto", "raw", "port"), default="auto",
                    help="how the line number is carried (default: auto-detect)")
    ap.add_argument("--bind", default=None,
                    help="local address (default: %s for raw, 0.0.0.0 for port)"
                         % PC_IP)
    ap.add_argument("--port", type=int, default=8080)
    ap.add_argument("--no-display", action="store_true",
                    help="do not open a window (useful over ssh / for soak tests)")
    ap.add_argument("--save", metavar="FILE",
                    help="record the received video to an .avi file")
    ap.add_argument("--snapshot", metavar="FILE",
                    help="save the first complete frame and keep going. A .png/"
                         ".jpg/.bmp path is written as an image; a .bin/.raw path "
                         "is written as the raw 1,036,800 big-endian RGB565 bytes")
    ap.add_argument("--duration", type=float, metavar="SECS",
                    help="stop after SECS seconds of wall clock (default: run "
                         "until ESC or Ctrl-C)")
    ap.add_argument("--stats-every", type=float, default=1.0,
                    help="seconds between statistics lines (default: 1.0)")
    ap.add_argument("--convert-every", type=int, default=1, metavar="N",
                    help="convert/display only every Nth good frame (default: 1). "
                         "Frames are still validated and counted. Raise it if the "
                         "conversion cannot keep up and packets are being dropped.")
    args = ap.parse_args()

    # 即使 stdout 是管道或文件,也让它按行刷新。一旦重定向到日志,Python 就会
    # 把它块缓冲,统计信息几分钟都不出来——而"脚本看着在正常工作、其实什么都不
    # 说"正是本次重写要杜绝的那种故障。
    try:
        sys.stdout.reconfigure(line_buffering=True)
    except (AttributeError, OSError):        # Python < 3.7,或 stdout 被替换过
        pass

    # --bind 按模式分别解析:原始套接字必须写一个具体的本机地址,普通套接字用
    # 0.0.0.0 最省事。
    if args.bind is None:
        args.bind = PC_IP if args.framing == "raw" else "0.0.0.0"
    bind_raw = args.bind if args.bind != "0.0.0.0" else PC_IP

    mode = args.framing
    helper = None
    if mode == "auto":
        mode, sock, rcvbuf = probe_framing(args.bind, args.port)
        if mode == "raw":
            print("switching to a raw socket for IP-header framing")
            sock, rcvbuf = open_raw_socket(bind_raw, args.port)
            helper = open_firewall_helper(bind_raw, args.port)
    elif mode == "raw":
        sock, rcvbuf = open_raw_socket(bind_raw, args.port)
        helper = open_firewall_helper(bind_raw, args.port)
    else:
        sock, rcvbuf = open_udp_socket(args.bind, args.port)

    decode = make_decoder(mode, args.port, bind_raw)

    print("mode: %s framing -- %s"
          % (mode,
             "line number is the UDP source port (0x1000 + line), headers ignored"
             if mode == "port" else
             "line number is the IP header Identification field"))
    print("listening on %s:%d  (SO_RCVBUF = %.1f MB)"
          % (args.bind, args.port, rcvbuf / 1e6))
    print("expecting %d x %d RGB565, %d bytes/frame in %d-byte datagrams"
          % (FRAME_W, FRAME_H, FRAME_BYTES, PAYLOAD_BYTES))
    if rcvbuf < 2 << 20:
        print("note: the kernel granted only %.2f MB. At 62 MB/s that is about "
              "%.1f ms of slack," % (rcvbuf / 1e6, rcvbuf / 62e6 * 1000))
        print("      and converting a frame blocks this loop for several ms -- "
              "expect heavy loss.")
        print("        Windows:  netsh int ipv4 set global defaultreceivewindow=8388608")
        print("        Linux:    sysctl -w net.core.rmem_max=8388608")
    if mode == "raw":
        print("the PC must be %s -- the board never re-ARP's" % bind_raw)
    print()

    # .bin/.raw 表示存拼好的原始帧,其他后缀按图片处理。
    snap_raw = (args.snapshot is not None
                and args.snapshot.lower().endswith((".bin", ".raw")))

    cv2 = None
    writer = None
    if not args.no_display or args.save or (args.snapshot and not snap_raw):
        try:
            import cv2 as _cv2
            cv2 = _cv2
        except ImportError:
            sys.exit("opencv-python is required for display/recording:  "
                     "pip install opencv-python\n"
                     "or re-run with --no-display")

    for path in (args.save, None if snap_raw else args.snapshot):
        if path:
            parent = os.path.dirname(os.path.abspath(path))
            if parent and not os.path.isdir(parent):
                os.makedirs(parent)
                print("created %s" % parent)

    if args.save:
        # 写入帧率必须等于帧实际到达的速率,否则回放速度就是错的:用
        # --convert-every 2 时只有每隔一帧才被转换,所以录制帧率应当是 30 fps
        # 而不是 60。
        fps = 60.0 / args.convert_every
        fourcc = cv2.VideoWriter_fourcc(*"MJPG")
        writer = cv2.VideoWriter(args.save, fourcc, fps, (FRAME_W, FRAME_H))
        if not writer.isOpened():
            sys.exit("could not open %s for writing" % args.save)
        print("recording to %s at %g fps" % (args.save, fps))

    asm = Assembler()
    buf = bytearray(2048)                        # 每包复用,不分配
    line = -1                                    # 最近见到的行号,供统计用
    st = Counters()
    first_frame_reported = False
    snapshot_done = args.snapshot is None
    convert_due = 0
    do_convert = writer is not None or (cv2 is not None and not args.no_display)
    pkts = 0                                     # 每条统计行开头清零
    bytes_seen = 0
    frames_seen = 0
    started = time.monotonic()
    last_stats = started
    last_packet = started

    try:
        while True:
            n = -1
            try:
                n, addr = sock.recvfrom_into(buf)
            except socket.timeout:
                if time.monotonic() - last_packet > 3.0:
                    print_no_traffic_hint(args.port)
                    last_packet = time.monotonic()

            # 这个循环里**故意**不写 `continue`。哪怕每一个包都被拒,统计行也照
            # 常打印下去——把一条完好码流里 99.8% 的包默默丢掉还一声不吭,正是
            # 本次重写要消灭的那种故障。
            if n >= 0:
                last_packet = time.monotonic()
                st.rx += 1
                pkts += 1
                parsed = decode(buf, n, addr, st)
            else:
                parsed = None

            if parsed is not None:
                line, payload = parsed
                st.accepted += 1
                bytes_seen += len(payload)

                # 帧边界就是"行号回退了":见 Assembler。这个规则在丢包后能自己
                # 重新对齐,而"数到 1350 个报文"做不到。
                status, frame, size = asm.feed(line, payload)
                if status == "ok":
                    st.frames_ok += 1
                    frames_seen += 1
                    st.bytes_ok += size
                    if not first_frame_reported:
                        first_frame_reported = True
                        print("first frame assembled: %d datagrams, %d bytes"
                              % (PACKETS_PER_FRAME, FRAME_BYTES))

                    # 只在第一帧完整帧上抓一次,而且**不受** --convert-every 影响:
                    # 它是被点名要的。
                    if not snapshot_done:
                        snapshot_done = True
                        if snap_raw:
                            with open(args.snapshot, "wb") as fh:
                                fh.write(frame)
                            print("wrote %s -- %d raw big-endian RGB565 bytes"
                                  % (args.snapshot, size))
                        elif cv2.imwrite(args.snapshot, to_bgr(memoryview(frame))):
                            print("wrote %s -- %d x %d, RGB565 in, BGR out"
                                  % (args.snapshot, FRAME_W, FRAME_H))
                        else:
                            print("!! could not write %s" % args.snapshot)

                    if do_convert:
                        convert_due += 1
                    if do_convert and convert_due >= args.convert_every:
                        convert_due = 0
                        # frame 就是重组器自己的缓冲区,而且是整个交出来的,所以
                        # 取这个视图是安全的。
                        img = to_bgr(memoryview(frame))
                        if writer is not None:
                            writer.write(img)
                        if cv2 is not None and not args.no_display:
                            cv2.imshow("hdmi_loop - 960x540 RGB565 over UDP", img)
                            if cv2.waitKey(1) & 0xFF == 27:   # ESC
                                break
                elif status == "short":
                    st.frames_bad += 1
                    if st.frames_bad <= 5 or st.frames_bad % 100 == 0:
                        print("frame dropped: %d bytes, expected %d (line %d)"
                              % (size, FRAME_BYTES, line))
                elif status == "overrun":
                    st.unresync += 1
                    if st.unresync <= 3:
                        print("no frame boundary in %d bytes -- the line number "
                              "never went backwards." % size)
                        if mode == "port":
                            print("  Port framing takes the line number from the UDP "
                                  "source port, so a source port that never moves")
                            print("  means the board is still running a bitstream "
                                  "that keeps it in the IP header -- re-run with")
                            print("  --framing raw. (A port that is constant but "
                                  "inside %d..%d means the FPGA's identify_code is "
                                  "stuck.)" % (PORT_BASE, PORT_MAX))
                        else:
                            print("  Check the FPGA: identify_code should reset at "
                                  "vsync and climb to %d." % LINE_MAX)

            now = time.monotonic()
            if args.duration is not None and now - started >= args.duration:
                print("reached --duration %gs, stopping" % args.duration)
                break
            if now - last_stats >= args.stats_every:
                dt = now - last_stats
                acc = 100.0 * st.accepted / st.rx if st.rx else 0.0
                # 这里报的是**区间**速率,而不是老脚本那种全程累计平均——全程平均
                # 会把一次卡顿几乎完全抹平,于是"画面冻住了"能一连几分钟看着像
                # "一切正常"。
                print("ok %6d  dropped %5d  %7.2f MB/s  %6.1f fps  %3.0f%% acc  "
                      "line %5d  (%d pkts/s)"
                      % (st.frames_ok, st.frames_bad, bytes_seen / dt / 1e6,
                         frames_seen / dt, acc, line, int(pkts / dt)))
                if st.rx >= 2000 and acc < 50.0 and not st.warned:
                    report_rejections(st, mode, bind_raw)
                    st.warned = 1
                pkts = 0
                bytes_seen = 0
                frames_seen = 0
                last_stats = now

    except KeyboardInterrupt:
        pass
    finally:
        if helper is not None:
            helper.close()
        sock.close()
        if writer is not None:
            writer.release()
        if cv2 is not None and not args.no_display:
            cv2.destroyAllWindows()
        elapsed = time.monotonic() - started
        print()
        print("received %d good frame(s), dropped %d, in %.1f s"
              % (st.frames_ok, st.frames_bad, elapsed))
        print("accepted %d of %d packets (%.1f%%)"
              % (st.accepted, st.rx, 100.0 * st.accepted / st.rx if st.rx else 0.0))
        print("assembled %.1f MB of video" % (st.bytes_ok / 1e6))
        if st.frames_ok:
            print("average %.1f fps over the whole run" % (st.frames_ok / elapsed))


def report_rejections(st, mode, dst_ip):
    """解释一次"几乎什么都没接受"的运行。

    本脚本的前身什么都不计数,于是在拒掉一条有效码流 99.8% 的包时**什么都说
    不出来**——接收端的 bug 就是这样被误当成硬件故障的。每一条拒绝路径都有自己
    的计数器,所以能指出到底是哪一种占了大头。
    """
    print("!! only %.1f%% of received packets passed validation (%d of %d)"
          % (100.0 * st.accepted / st.rx, st.accepted, st.rx))
    for label, value in (("packet too short", st.short),
                         ("not IPv4", st.ip_ver),
                         ("IP header length bad", st.ip_ihl),
                         ("IP protocol != UDP", st.proto),
                         ("source IP != %s" % BOARD_IP, st.src_ip),
                         ("dest IP != %s" % dst_ip, st.dst_ip),
                         ("UDP dest port != %d" % args.port, st.dst_port),
                         ("UDP length field bad", st.udp_len),
                         ("payload length != %d" % PAYLOAD_BYTES, st.pay_len),
                         ("source IP != %s (port framing)" % BOARD_IP, st.other_src),
                         ("source port in window but line > %d" % LINE_MAX,
                          st.port_range)):
        if value:
            print("   %-34s : %d" % (label, value))
    if st.dst_port and mode == "raw":
        print("   'UDP dest port' or 'not IPv4' dominating is the signature of a")
        print("   normal UDP socket: the kernel already stripped IP+UDP, so byte 0")
        print("   is pixel data, not 0x45, and the 'port' read out of it is two")
        print("   pixel bytes. That was the original bug -- the framing and the")
        print("   socket type must match.")
    print()


if __name__ == "__main__":
    main()
