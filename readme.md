# hdmi_loop

**FPGA 上的 HDMI 实时暗通道去雾环出。** 外部 HDMI 信号进入 FPGA,经暗通道先验(DCP)
去雾流水线处理后直接环出到显示器;同一路画面同时经千兆以太网推给 PC。

![项目总览](tools/figs/fig1_overview.png)

---

## 这是什么

- **纯 RTL 实现**的暗通道先验去雾(Vivado 2021.2,Artix-7),不依赖 CPU / 操作系统
- **逐像素全流水**:148.5 MHz 像素时钟,一拍一个像素,1080p60
- **一键 A/B**:板载按键在"去雾 / 直连原图"间切换,只在帧边界生效,不撕裂
- **并行网口通道**:960×540 RGB565 @60fps 经 UDP 推送到 PC(与 HDMI 环出互不影响)

## 关键参数

| 项目 | 数值 |
| --- | --- |
| 器件 | Artix-7 `xc7a200tfbg484-2`(ALINX AX7A200) |
| 工具 | Vivado 2021.2 |
| 视频 | 1080p60,像素时钟 148.5 MHz,RGB888 |
| 流水线延迟 | **21 拍 ≈ 141.4 ns**(逐级见 [TECHNICAL.md](TECHNICAL.md)) |
| 资源 | 2994 LUT(2.24%)/ 3267 FF(1.21%)/ 4.5 BRAM(1.23%)/ 4 DSP(0.54%) |
| 网口输出 | 960×540 RGB565 @60fps,约 62 MB/s,UDP 8080 |
| 时序 | ✅ **已收敛**:`vin_clk` 域 WNS **+0.420 ns**,0 失败端点 |

## 快速开始

```bash
# 1. 直接用 Vivado 打开工程
hdmi_loop.xpr

# 2. 或者从工程生成脚本重建(在任意空目录执行)
vivado -mode batch -source <仓库>/hdmi_loop_gen.tcl -tclargs --origin_dir <仓库>

# 3. PC 端接收视频(先把自己配成 192.168.0.3)
pip install numpy opencv-python
python tools/eth_recv.py
```

> **新克隆的工程**在综合前必须先执行一次 `tools/setup_eth_ip.tcl`(当前仓库里的
> `.xpr` 已经做过,见 [TECHNICAL.md](TECHNICAL.md) 的"第 0 步")。

## 验证状态

**离线验证全部通过**(不依赖上板):

| 项目 | 结果 |
| --- | --- |
| 去雾链 WP3(7×7)/ WP1(3×3) | **PASS**,两档校验和与改动前逐位一致 |
| `video_to_eth` 缩放 / `udp_tx` 读使能 | **PASS** |
| 上位机接收自检 | **PASS**,90 条断言 |
| 全量 `xvlog` + `xelab` | **0 ERROR** |

**未完成**:比特流生成与上板联调。详细数据见 [TECHNICAL.md](TECHNICAL.md) 第十二节。


## 目录结构

```
hdmi_loop.srcs/     RTL 源码、约束、IP
  darkchannel/      去雾流水线(src_min / 7x7 暗通道 / tx_get / 复原)
  ethernet/         UDP/IP/ARP + RGMII 发送链
  new/              顶层、I2C 配置、时钟
tools/              上位机接收程序、自检 testbench、MATLAB 绘图脚本
hdmi_loop_gen.tcl   工程生成脚本
```

## 已知限制

- 大气光取**全帧最大值**的单标量近似,含大面积白色物体时会偏亮
- 暗通道窗口是**因果锚定**,透射率图相对原图有约 3 行 + 3 像素偏移
- `Y_ENHANCE`(亮度增强)分支**默认关闭且未维护**
- 网口目的 IP / MAC 写死,`arp_cache` 无老化,PC 配错需复位 FPGA

完整列表见 [TECHNICAL.md](TECHNICAL.md) 的"已知限制与注意事项"一节。

## 来源说明

`hdmi_loop.srcs/sources_1/new/i2c_master_*.v` 来自 OpenCores I2C 主机核,
保留其原始版权声明与许可条款。
