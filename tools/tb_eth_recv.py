#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
tb_eth_recv.py —— eth_recv.py 的离线自检。不用板子,不用网络。

在责怪 FPGA 之前先跑它:  python tools/tb_eth_recv.py

为什么要有这个文件
------------------
eth_recv.py 的第一版开的是普通 SOCK_DGRAM 套接字,却把接收缓冲区当成"第 0 个
字节就是 IP 头开头"来解析。而 SOCK_DGRAM 上内核早就把 IP 和 UDP 剥掉了,第 0
个字节是像素数据——解析器于是把两个像素读成"行号"、把一个像素字节读成"IP 版
本号"。它靠巧合仍能接受约 0.2% 的包,于是一边打印着一切正常的统计行,一边丢掉
一条完好码流 99.8% 的包,永远合不出一帧。这个现象被误当成硬件故障很久。

根因是**套接字的开法与字节的解析方式不匹配**。这恰恰是"不插板子也能测出来"的
那类 bug,所以这里把每种定界路径真正会收到的字节喂给它,断言两条路径结论一致
——而且同样重要的是,断言错误的配对会被**大声拒绝**,而不是以一个看着还挺像样
的低接受率被接受。

这里不需要板子,也不需要任何权限:唯一用到套接字的第 9 项测试走回环,端口是本
进程自己开的。这里的任何结果都不会受 bitstream、链路、板子 IP 或防火墙影响,这
正是重点——在这里失败,就是本脚本自己有问题。
"""

import os
import random
import socket
import struct
import sys
import time

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

import eth_recv as E                                    # noqa: E402

FRAME_W, FRAME_H = E.FRAME_W, E.FRAME_H
PAYLOAD_BYTES = E.PAYLOAD_BYTES
FRAME_BYTES = E.FRAME_BYTES
PACKETS_PER_FRAME = E.PACKETS_PER_FRAME

PC_IP = E.PC_IP
BOARD_IP = E.BOARD_IP
DST_PORT = 8080
SRC_PORT_LEGACY = 8080

_failures = []
_checks = 0


def check(cond, what):
    global _checks
    _checks += 1
    if not cond:
        _failures.append(what)
        print("  FAIL  %s" % what)
    else:
        print("  ok    %s" % what)
    return cond


# --------------------------------------------------------------------------- #
# 一个合成报文,与板子放到线上的字节完全一致
# --------------------------------------------------------------------------- #

def ip_checksum(hdr):
    """RFC 1071:对 20 字节头做反码和,计算时第 10 字节起的校验和字段先置 0。"""
    total = 0
    for i in range(0, len(hdr), 2):
        total += (hdr[i] << 8) | hdr[i + 1]
    while total >> 16:
        total = (total & 0xFFFF) + (total >> 16)
    return (~total) & 0xFFFF


def build_packet(line, payload, src_port=None, ip_id=None,
                 src_ip=BOARD_IP, dst_ip=PC_IP, dst_port=DST_PORT,
                 proto=0x11):
    """原始套接字交付的那个 IP 数据报:IP 头在最前面。

    默认值精确复现板子的行为:IP ID == 行号,UDP 源端口 == 0x1000 + 行号,目的
    端口 8080。
    """
    if src_port is None:
        src_port = E.PORT_BASE + line
    if ip_id is None:
        ip_id = line

    udp_len = 8 + len(payload)
    total_len = 20 + udp_len
    ip = struct.pack(
        ">BBHHHBBH4s4s",
        0x45,             # IPv4,IHL = 5 个字
        0x00,             # DSCP/ECN
        total_len,
        ip_id,
        0x4000,           # 不分片 —— mac_test 就是这么发的
        0x80,             # TTL
        proto,
        0x0000,           # 校验和先占位
        socket.inet_aton(src_ip),
        socket.inet_aton(dst_ip),
    )
    ip = ip[:10] + struct.pack(">H", ip_checksum(ip)) + ip[12:]
    udp = struct.pack(">HHHH", src_port, dst_port, udp_len, 0x0000)
    return ip + udp + bytes(payload)


def line_payload(line):
    """768 字节,长得像真实画面的某一行。

    真实像素字节是 RGB565,高字节主要由红/绿分量决定,极少是 0x4X——这正是那个
    坏掉的解析器 `buf[0] >> 4 == 4` 只有约 6% 通过率的原因。把测试数据造得像真
    实数据,是下面那个反向测试能有意义的前提。
    """
    rng = random.Random(0xC0DE ^ line)
    return bytes(rng.randrange(0x00, 0xFF) for _ in range(PAYLOAD_BYTES))


def dgram_style_payload(line):
    """同一个行号下,SOCK_DGRAM 套接字交付的东西:没有包头。"""
    return line_payload(line)


def fresh(mode):
    return E.make_decoder(mode, DST_PORT, PC_IP), E.Counters()


# --------------------------------------------------------------------------- #
# 1. 两条定界路径对同一个报文的解读完全一致
# --------------------------------------------------------------------------- #

def test_both_framings_agree():
    print("1. both framings agree on line, payload and boundary")

    for line in (0, 1, 137, 539):
        payload = line_payload(line)
        packet = build_packet(line, payload)

        dec_raw, st_raw = fresh("raw")
        got_raw = dec_raw(packet, len(packet), (BOARD_IP, E.PORT_BASE + line), st_raw)

        dec_port, st_port = fresh("port")
        got_port = dec_port(payload, len(payload),
                            (BOARD_IP, E.PORT_BASE + line), st_port)

        if not check(got_raw is not None, "raw decoder accepts line %d" % line):
            continue
        check(got_port is not None, "port decoder accepts line %d" % line)
        if got_port is None:
            continue

        line_raw, pay_raw = got_raw
        line_port, pay_port = got_port

        check(line_raw == line, "raw line == %d (got %d)" % (line, line_raw))
        check(line_port == line, "port line == %d (got %d)" % (line, line_port))
        check(bytes(pay_raw) == payload, "raw payload == the 768 bytes sent")
        check(bytes(pay_port) == payload, "port payload == the 768 bytes sent")
        check(bytes(pay_raw) == bytes(pay_port), "both framings agree on payload")
        check(st_raw.pay_len == 0 and st_port.pay_len == 0,
              "neither framing flags a payload-length problem")


# --------------------------------------------------------------------------- #
# 2. 面对改动前的 bitstream,raw 解码器仍然可用
# --------------------------------------------------------------------------- #

def test_raw_legacy_source_port():
    print("2. raw framing works against a pre-change bitstream (source port 8080)")

    payload = line_payload(42)
    packet = build_packet(42, payload, src_port=SRC_PORT_LEGACY)
    dec, st = fresh("raw")
    got = dec(packet, len(packet), (BOARD_IP, SRC_PORT_LEGACY), st)
    check(got is not None and got[0] == 42,
          "raw framing reads the line number from the IP ID when the source "
          "port is still 8080")


# --------------------------------------------------------------------------- #
# 3. 整次重写所针对的那个故障
# --------------------------------------------------------------------------- #

def test_raw_rejects_dgram_payload():
    """把最初的 bug 反过来写成断言。

    给 raw 解码器喂不带包头的字节,**必须**得到一个明确的拒绝,而不是一条看着还
    挺像样的涓涓细流。老解析器能接受其中约 0.2%——8.1 万包/秒里约 158 包/秒——
    这正是那个故障如此难被发现的原因。这里只要通过率超过千分之几,就说明定界方
    式与套接字类型又一次脱节了。
    """
    print("3. raw framing rejects headerless (SOCK_DGRAM-style) bytes")

    dec, st = fresh("raw")
    n = 4000
    accepted = 0
    for line in range(n):
        payload = dgram_style_payload(line)
        if dec(payload, len(payload), (BOARD_IP, SRC_PORT_LEGACY), st) is not None:
            accepted += 1

    check(accepted == 0,
          "0 of %d headerless packets accepted (got %d, %.2f%%)"
          % (n, accepted, 100.0 * accepted / n))
    check(st.rx == 0, "rejections are counted in the step counters")
    check(st.short + st.ip_ver + st.ip_ihl + st.src_ip + st.dst_ip
          + st.dst_port + st.udp_len > 0,
          "at least one rejection counter moved, so a silent drop is impossible")


# --------------------------------------------------------------------------- #
# 4. raw 定界不会被别人的流量骗到
# --------------------------------------------------------------------------- #

def test_raw_validation_gates():
    print("4. raw framing rejects packets that are not the board's video")

    payload = line_payload(7)

    cases = [
        ("wrong source IP",
         dict(src_ip="192.168.0.99"), "src_ip"),
        ("wrong destination IP",
         dict(dst_ip="192.168.0.4"), "dst_ip"),
        ("wrong destination port",
         dict(dst_port=9999), "dst_port"),
        ("not IPv4 (0x65 = IPv6)",
         dict(), "ip_ver"),
        # Windows 上的原始套接字不按协议过滤,所以 TCP 得由解码器自己拒掉。
        ("wrong IP protocol (TCP)",
         dict(proto=0x06), "proto"),
    ]

    dec, st = fresh("raw")
    for name, kwargs, counter in cases:
        packet = build_packet(7, payload, **kwargs)
        if name.startswith("not IPv4"):
            packet = bytes([0x65]) + packet[1:]
        got = dec(packet, len(packet), (BOARD_IP, E.PORT_BASE + 7), st)
        check(got is None, "rejects %s" % name)
        check(getattr(st, counter) > 0,
              "  ...and counts it under '%s'" % counter)
        setattr(st, counter, 0)

    # 被截断的数据报必须被拒,而不是读越缓冲区末尾。
    packet = build_packet(7, payload)[:400]
    got = dec(packet, len(packet), (BOARD_IP, E.PORT_BASE + 7), st)
    check(got is None, "rejects a truncated datagram (400 of %d bytes)"
          % (len(payload) + 28))


# --------------------------------------------------------------------------- #
# 5. 源端口定界,包括它必须拒绝的旧版 bitstream
# --------------------------------------------------------------------------- #

def test_port_framing():
    print("5. port framing reads the line number and refuses the old bitstream")

    dec, st = fresh("port")
    payload = line_payload(200)
    for line in (0, 1, 200, 539):
        got = dec(payload, len(payload),
                  (BOARD_IP, E.PORT_BASE + line), st)
        if check(got is not None, "port framing accepts line %d" % line):
            check(got[0] == line, "  ...and reads line %d" % line)

    # 旧版 bitstream:源端口永远进不了这个窗口。这正是板子**当前**可能在跑的
    # bitstream,所以失败必须响亮——每个包都被拒且都被计数,而不是悄悄归零。
    dec, st = fresh("port")
    for _ in range(50):
        assert dec(payload, len(payload), (BOARD_IP, SRC_PORT_LEGACY), st) is None
    check(st.dst_port == 50,
          "port framing refuses source port 8080 (legacy bitstream) and counts "
          "all 50 packets as rejected")

    # 一帧的**最后一个**标号必须被接受。这就是让整轮抓取白跑的那个回归:板子把
    # 它的 540 行标成 1..540(计数器在 vsync 清零、在第一个 href 下降沿 +1,所以
    # 它是 1 基的,行号 0 从不出现)。用 `line >= FRAME_H` 当卡会把每个标号 540 的
    # 包都丢掉——那是每一帧的帧尾——重组器于是只看到 1347 个包而不是 1350 个,一
    # 帧都完不成。
    dec, st = fresh("port")
    got = dec(payload, len(payload), (BOARD_IP, E.PORT_BASE + FRAME_H), st)
    check(got is not None and got[0] == FRAME_H,
          "port framing ACCEPTS line %d -- the board's last label" % FRAME_H)
    check(st.port_range == 0, "  ...and does not count it as out of range")

    dec, st = fresh("port")
    got = dec(payload, len(payload), (BOARD_IP, E.PORT_BASE + 0), st)
    check(got is not None and got[0] == 0,
          "port framing also tolerates line 0 (unused by the board, harmless)")

    # 端口落在 0x3FF 宽的窗口内、却高于任何真实行号:掩码把跑飞的计数器绕回来
    # 了。4096 + 600 = 4696 确实在窗口里,但行号 600 不存在——标号最高只到
    # FRAME_H。
    dec, st = fresh("port")
    got = dec(payload, len(payload), (BOARD_IP, E.PORT_BASE + 600), st)
    check(got is None, "port framing rejects line 600 (labels stop at %d)"
          % FRAME_H)
    check(st.port_range == 1, "  ...and counts it under 'port_range'")

    # 端口落在窗口内,但不是板子发来的。
    dec, st = fresh("port")
    got = dec(payload, len(payload), ("192.168.0.77", E.PORT_BASE + 5), st)
    check(got is None, "port framing checks the source IP")
    check(st.other_src == 1, "  ...and counts it under 'other_src'")


# --------------------------------------------------------------------------- #
# 6. 帧重组:帧边界,以及"长度必须正好"这条规则
# --------------------------------------------------------------------------- #

def frame_bytes():
    """一段 1,036,800 字节的测试数据,每个字节都标着自己该在的位置。"""
    return bytes((i * 7 + (i >> 8) + (i >> 16) * 3) & 0xFF
                 for i in range(FRAME_BYTES))


def packet_line(i):
    """一帧里第 i 个数据报携带的标号,与板子实际发出的完全一致。

    有两点必须弄对,而且两点都是**从硬件实测得来**、不是猜的:

    一行 1920 字节、一个数据报 768 字节,所以**一行 = 两个半数据报**——标号不是
    一包一个。它在相邻包之间会重复(每个标号对应 3、2、3、2…… 个包),只有它的
    **回退**才是帧边界。这一点建模建错了,测试就会让你相信一个本来能用的重组器
    是坏的。

    标号是 **1 基**的,范围 1..FRAME_H。identify_code 在 vsync 沿清零,之后第一
    个像素行 href 的下降沿就 +1,所以行号 0 从不发送。**实机实测**:32 万个包中
    源端口为 4097..4636,4096 一次都没出现。

    重复规律是 3/2/3/2……,**偶数**标号拿 3 个包、奇数标号拿 2 个(直接数一帧的
    源端口量出来的):标号 1 -> 2 个包,2 -> 3 个,3 -> 2 个,……,540 -> 3 个。
    也就是说一帧的**最后一个标号占三个数据报**,而 `>= FRAME_H` 那道卡每帧挖掉
    的 2304 字节空洞,正好就是它们。
    """
    return (2 * i + 6) // 5


def test_assembly():
    print("6. assembling frames from a line-number stream")

    assert packet_line(0) == 1, "fixture model is wrong: labels must be 1-based"
    assert packet_line(PACKETS_PER_FRAME - 1) == FRAME_H, \
        "fixture model is wrong: %d packets must span labels 1..%d" % (
            PACKETS_PER_FRAME, FRAME_H)
    assert all(packet_line(i) <= FRAME_H for i in range(PACKETS_PER_FRAME)), \
        "fixture model is wrong: a label exceeds FRAME_H"
    # 而且每个标号的包数必须复现硬件的 3/2/3/2 规律——包括标号 540 占三个包。
    counts = {}
    for i in range(PACKETS_PER_FRAME):
        counts[packet_line(i)] = counts.get(packet_line(i), 0) + 1
    assert len(counts) == FRAME_H, "fixture model is wrong: %d distinct labels" % len(counts)
    assert all(v == (3 if k % 2 == 0 else 2) for k, v in counts.items()), \
        "fixture model is wrong: datagrams-per-label is not 3,2,3,2,...,3"

    src = frame_bytes()

    def feed_frame(asm, skip=None, start=0):
        """按板子的顺序喂入第 start..1349 个包,返回每一步的结果。"""
        out = []
        for i in range(start, PACKETS_PER_FRAME):
            if i == skip:
                continue                  # 这个数据报在传输中丢了
            payload = src[i * PAYLOAD_BYTES:(i + 1) * PAYLOAD_BYTES]
            out.append(asm.feed(packet_line(i), payload))
        return out

    asm = E.Assembler()
    results = feed_frame(asm)
    check(all(r[0] == "none" for r in results),
          "no boundary is reported while a frame is in progress")

    # 下一帧的第一个数据报把它封口。它的标号是 1 而不是 0——板子的计数器正是从
    # 540 直接绕回 1。
    status, frame, size = asm.feed(packet_line(0), src[:PAYLOAD_BYTES])
    check(status == "ok", "the label dropping from %d back to 1 ends the frame"
          % FRAME_H)
    check(size == FRAME_BYTES,
          "frame is exactly %d bytes (got %d)" % (FRAME_BYTES, size))
    check(frame is not None and len(frame) == FRAME_BYTES,
          "the returned buffer holds the whole frame")
    check(PACKETS_PER_FRAME * PAYLOAD_BYTES == FRAME_BYTES,
          "1350 datagrams x 768 == one frame")

    # 逐字节一致:重组必须原样复现源数据,不能有任何漂移。边界规则里任何一处
    # off-by-one 都会在这里暴露,而在别处都不会。
    check(bytes(frame) == src, "reassembled frame is byte-identical to the source")

    # 再抽查一下:标号 L 确实位于偏移 (L-1) * 1920——标号是 1 基的,所以标号 1
    # 是第一行、标号 540 是最后一行。
    ok = True
    for line in (1, 2, 138, 540):
        off = (line - 1) * (FRAME_BYTES // FRAME_H)
        if bytes(frame[off:off + 16]) != src[off:off + 16]:
            ok = False
    check(ok, "label L lands at byte offset (L-1) * 1920")

    # 丢一个数据报会让下一个边界变成短帧,并且不产生任何图像。
    asm = E.Assembler()
    feed_frame(asm, skip=100)
    status, frame, size = asm.feed(packet_line(0), src[:PAYLOAD_BYTES])
    check(status == "short", "a lost datagram makes the next frame 'short'")
    check(size == FRAME_BYTES - PAYLOAD_BYTES,
          "  ...by exactly one payload (%d, got %d)"
          % (PAYLOAD_BYTES, FRAME_BYTES - size))
    check(frame is None, "  ...and no image is produced from it")

    # 重新对齐:无论之前怎样,重组器都会在下一帧恢复。
    # 它从第 1 个包接着走,因为上面用来给坏帧封口的那个标号-1 数据报,本身就是
    # 这一帧的第一个数据报——边界只在**开启**下一帧的那个包上才被检测到,所以
    # 那个包属于新的一帧。
    feed_frame(asm, start=1)
    status, frame, size = asm.feed(packet_line(0), src[:PAYLOAD_BYTES])
    check(status == "ok", "the frame after a loss assembles normally again")
    check(size == FRAME_BYTES, "  ...at full length")
    check(bytes(frame) == src, "  ...and byte-identical to the source")


def test_assembly_overrun():
    """拿源端口定界去接"行号卡死"的 bitstream,绝不能把内存吃光。

    没有 MAX_CUR 的话,这里会以 62 MB/s 一直追加下去,机器大约三十秒就撑死了
    ——那比它要修的那个故障糟糕得多。
    """
    print("7. a line number that never goes backwards cannot exhaust memory")

    asm = E.Assembler()
    status, size = "none", 0
    for _ in range(4000):
        status, _frame, size = asm.feed(8080, b"\x00" * PAYLOAD_BYTES)
        if status == "overrun":
            break
    check(status == "overrun", "an unchanging line number is reported as overrun")
    check(size <= E.MAX_CUR + PAYLOAD_BYTES,
          "the buffer is dropped at %d bytes, not left to grow" % size)
    check(len(asm.cur) < PAYLOAD_BYTES * 4, "the buffer is actually released")


# --------------------------------------------------------------------------- #
# 8. RGB565 -> BGR 转换
# --------------------------------------------------------------------------- #

def test_to_bgr():
    print("8. RGB565 -> BGR conversion")

    import numpy as np

    # 线上是大端:纯红 0xF800、纯绿 0x07E0、纯蓝 0x001F。
    line = bytearray()
    for _ in range(FRAME_W):
        line += b"\xF8\x00"      # 红
        line += b"\x07\xE0"      # 绿
        line += b"\x00\x1F"      # 蓝
    line = bytes(line[:FRAME_W * 2])

    frame = line * FRAME_H
    check(len(frame) == FRAME_BYTES, "fixture is one whole frame")

    img = E.to_bgr(memoryview(frame))
    check(img.shape == (FRAME_H, FRAME_W, 3), "shape is (%d, %d, 3)" % (FRAME_H, FRAME_W))
    check(img.dtype == np.uint8, "dtype is uint8")

    # to_bgr 返回的是 OpenCV 的 BGR 顺序——下标 0 是**蓝**——因为 cv2.imshow 和
    # cv2.VideoWriter 就要这个顺序。这里也按这个顺序比,而且三个分量全比,这样
    # 红蓝互换不可能蒙混过关。
    #
    # 它必须匹配的打包方式是 video_to_eth.v:75,
    #     px565 = {vin_data[23:19], vin_data[15:10], vin_data[7:3]}
    # 也就是 R 在 bit 15:11、G 在 10:5、B 在 4:0,高字节先上线。
    b, g, r = img[0, 0].tolist()
    check((r, g, b) == (255, 0, 0), "0xF800 -> pure red (BGR got %s)"
          % ([b, g, r],))
    b, g, r = img[0, 1].tolist()
    check((r, g, b) == (0, 255, 0), "0x07E0 -> pure green (BGR got %s)"
          % ([b, g, r],))
    b, g, r = img[0, 2].tolist()
    check((r, g, b) == (0, 0, 255), "0x001F -> pure blue (BGR got %s)"
          % ([b, g, r],))

    # 高位复制到低位,正是它让白色是纯白而不是 0xF8F8F8。
    white = bytes(b"\xFF\xFF") * FRAME_W * FRAME_H
    img = E.to_bgr(memoryview(white))
    check(img[0, 0].tolist() == [255, 255, 255],
          "0xFFFF -> pure white (got %s)" % (img[0, 0].tolist(),))

    # to_bgr 不能和它的输入别名,否则重组器的缓冲区交到 cv2 手里之后可能在底下
    # 被改掉。
    buf = bytearray(b"\xF8\x00" * (FRAME_W * FRAME_H))
    img = E.to_bgr(memoryview(buf))
    buf[0] = 0x00
    check(img[0, 0, 2] == 255, "the result does not alias the input buffer")


# --------------------------------------------------------------------------- #
# 9. 整条链路走一次真实套接字
# --------------------------------------------------------------------------- #

def test_loopback_roundtrip():
    """在回环上跑一次真正的 SOCK_DGRAM 往返。

    上面每一项喂给解码器的都是字节串,这一项要过内核:一个源端口真的带着行号的
    发送方、一个真正的接收套接字,以及真正的 Assembler。它是"不插板子能跑的东
    西里最接近板子的那个",也是唯一一项能把"套接字类型与解析方式"的配对真正跑
    一遍的测试——而那个配对正是出过错的地方。
    """
    print("9. a real UDP socket round-trip on loopback")

    import threading

    # 板子自己的窗口是 0x1000..0x13FF,但行号 404 对应源端口 4500,而 Windows
    # 不允许本机套接字**绑** 4500——它在 Windows 的保留端口集合里(IANA 分配给
    # IPsec NAT-T)。这对真实系统毫无影响:发**自** 4500 的是板子,本机从不绑它,
    # 而接收套接字接受任意源端口。但本测试确实要绑,所以改用 0x2000 起始的窗口
    # ——那个在这里完全可以绑。解码器的窗口做成参数,正是为了这个。
    lo_base = 0x2000

    rx = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    rx.setsockopt(socket.SOL_SOCKET, socket.SO_RCVBUF, 4 << 20)
    rx.bind(("127.0.0.1", 0))
    rx.settimeout(10.0)
    port = rx.getsockname()[1]

    src = frame_bytes()
    total = PACKETS_PER_FRAME + 1
    send_error = []

    # 每个不同的行号开一个套接字,并且整轮运行期间一直开着。行号在相邻数据报之
    # 间会重复(一行 2.5 个包),而在 Windows 上把一个 UDP 源端口关掉后立刻重新
    # 绑会失败并报 WSAEACCES——内核对前一个套接字还没处理完。每个源端口保持一个
    # 套接字,这也正是板子的做法。
    socks = {}

    def sender():
        try:
            for i in range(total):
                # 一帧最后一个包(标号 540)之后是下一帧的第一个包,标号 1——
                # 这次下跌就是帧边界,而携带这个边界的包属于新的一帧。
                j = i % PACKETS_PER_FRAME
                line = packet_line(j)
                off = j * PAYLOAD_BYTES
                tx = socks.get(line)
                if tx is None:
                    # 绑源端口正是让它看起来像板子的关键:源端口定界就是从它
                    # 读行号的。
                    tx = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
                    tx.bind(("127.0.0.1", lo_base + line))
                    socks[line] = tx
                tx.sendto(src[off:off + PAYLOAD_BYTES], ("127.0.0.1", port))
                time.sleep(0.0002)      # 给接收端留出跟得上的余地
        except OSError as exc:
            send_error.append(str(exc))

    dec = E.make_decoder("port", port, "127.0.0.1", src_ip="127.0.0.1",
                        port_base=lo_base)
    st = E.Counters()
    asm = E.Assembler()
    frames = []
    accepted = 0                     # 解码器数的是拒绝,不是接受,所以在这里自己数

    t = threading.Thread(target=sender)
    t.start()
    try:
        while len(frames) < 1 and not send_error:
            try:
                data, addr = rx.recvfrom(2048)
            except socket.timeout:
                break
            got = dec(data, len(data), addr, st)
            if got is None:
                continue
            accepted += 1
            status, frame, _size = asm.feed(got[0], got[1])
            if status == "ok":
                frames.append(frame)
    finally:
        t.join(timeout=5.0)
        for tx in socks.values():
            tx.close()
        rx.close()

    if send_error:
        check(False, "could not send the test stream: %s" % send_error[0])
        return

    check(accepted == total,
          "all %d datagrams passed the port decoder (got %d)" % (total, accepted))
    check(len(frames) == 1,
          "exactly one frame assembled (got %d)" % len(frames))
    if frames:
        check(bytes(frames[0]) == src, "it arrived byte-identical over the socket")


def main():
    print("eth_recv.py self-test -- no board, no network, no privileges\n")

    test_both_framings_agree()
    test_raw_legacy_source_port()
    test_raw_rejects_dgram_payload()
    test_raw_validation_gates()
    test_port_framing()
    test_assembly()
    test_assembly_overrun()
    test_to_bgr()
    test_loopback_roundtrip()

    print()
    if _failures:
        print("%d of %d checks FAILED:" % (len(_failures), _checks))
        for f in _failures:
            print("  - %s" % f)
        return 1
    print("all %d checks passed" % _checks)
    return 0


if __name__ == "__main__":
    sys.exit(main())
