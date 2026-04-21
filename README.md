# HDMI 视频处理工程

基于 Xilinx Vivado 的 HDMI 2.0 视频接收与处理项目，目标硬件为 **Xilinx KC705 开发板**（FPGA 型号：xc7k325tffg900-2）。

## 项目简介

本项目实现了在 KC705 开发板上通过 FMC HDMI 2.0 子卡完成 HDMI 信号的接收（RX）、视频处理（Video Processing）及发送（TX）的完整数据链路。视频数据以 AXI4-Stream 接口在各模块间传递，顶层模块负责对接收到的视频流进行处理后再输出。

## 目录结构

```
.
├── imports/                          # 约束文件及 TCL 脚本
│   ├── hdmi_example_kc705.xdc        # KC705 引脚与时序约束
│   ├── phys_opt_design.tcl           # 物理优化 TCL 脚本
│   ├── route_design.tcl              # 布线 TCL 脚本
│   └── postroute_phys_opt_design.tcl # 布线后物理优化脚本
├── v_hdmi_rx_ss_0_ex.srcs/
│   └── sources_1/
│       ├── new/
│       │   └── Vedio_Processing.v    # 自定义视频处理模块（顶层业务逻辑）
│       └── bd/
│           └── exdes/                # Block Design（HDMI RX/TX 子系统）
├── v_hdmi_rx_ss_0_ex.xpr             # Vivado 工程文件
└── README.md
```

## 硬件要求

| 项目 | 规格 |
|------|------|
| 开发板 | Xilinx KC705 |
| FPGA | xc7k325tffg900-2 |
| FMC 子卡 | FMC HDMI 2.0（需支持 KC705 HPC 连接器） |
| 时钟芯片 | SI5324（板载，用于 MGT 参考时钟整形） |

## 接口说明

### `Vedio_Processing` 模块（AXI4-Stream）

| 信号名 | 方向 | 位宽 | 说明 |
|--------|------|------|------|
| `axis_IN_tdata` | 输入 | 48 bit | 来自 HDMI RX 的视频像素数据 |
| `axis_IN_tlast` | 输入 | 1 bit | 行末尾标志 |
| `axis_IN_tuser` | 输入 | 1 bit | 帧起始标志 |
| `axis_IN_tvalid` | 输入 | 1 bit | 数据有效 |
| `axis_IN_tready` | 输出 | 1 bit | 接收方准备好 |
| `axis_OUT_tdata` | 输出 | 48 bit | 处理后输出至 HDMI TX 的像素数据 |
| `axis_OUT_tlast` | 输出 | 1 bit | 行末尾标志 |
| `axis_OUT_tuser` | 输出 | 1 bit | 帧起始标志 |
| `axis_OUT_tvalid` | 输出 | 1 bit | 数据有效 |
| `axis_OUT_tready` | 输入 | 1 bit | 下游准备好 |

### 主要外部接口（KC705 引脚）

| 信号 | 说明 |
|------|------|
| `HDMI_RX_CLK_P_IN` | HDMI RX MGT 参考时钟正端（C8） |
| `HDMI_RX_DAT_P_IN[2:0]` | HDMI RX 三路高速串行数据正端 |
| `RX_HPD_OUT` | HDMI RX 热插拔检测输出 |
| `RX_DDC_OUT_scl/sda` | HDMI RX DDC（I²C）时钟/数据 |
| `TX_REFCLK_P_IN` | HDMI TX MGT 参考时钟正端（E8） |
| `HDMI_TX_CLK_P_OUT` | HDMI TX 时钟正端输出（C19） |
| `HDMI_TX_DAT_P_OUT[2:0]` | HDMI TX 三路高速串行数据正端 |
| `TX_HPD_IN` | HDMI TX 热插拔检测输入 |
| `rs232_uart_rxd/txd` | UART 调试串口（USB 转串口） |
| `fmch_iic_scl/sda` | FMC 子卡 I²C 接口 |
| `LED0` | 状态指示 LED |
| `SI5324_RST_OUT` | SI5324 时钟芯片复位 |
| `SI5324_LOL_IN` | SI5324 失锁检测输入 |

## 开发环境

- **EDA 工具**：Xilinx Vivado 2021.2
- **设计语言**：Verilog / Block Design
- **顶层模块**：`exdes_wrapper`
- **综合策略**：Vivado Synthesis Defaults
- **实现策略**：Vivado Implementation Defaults（含后布线物理优化）

## 快速上手

1. 克隆本仓库到本地：
   ```bash
   git clone https://github.com/luuton/HDMI_vedio_processing.git
   ```

2. 使用 **Vivado 2021.2** 打开工程文件：
   ```
   File → Open Project → v_hdmi_rx_ss_0_ex.xpr
   ```

3. 若 IP 核未生成，在 Vivado 中执行：
   ```
   Tools → Generate Block Design
   ```

4. 在 `Vedio_Processing.v` 中实现自定义视频处理逻辑（当前为直通框架）。

5. 依次执行综合（Synthesis）、实现（Implementation）、生成比特流（Generate Bitstream）。

6. 通过 JTAG 将比特流下载到 KC705 开发板。

## 许可证

本项目仅供学习与研究使用。
