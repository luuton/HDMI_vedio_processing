%% plot_blockdiagrams.m —— hdmi_loop readme 里的系统框图 / 结构图
%
% 生成 5 张图到 tools/figs/:
%   fig1_overview.png     项目总览(HDMI 环出 + 并行网口通道)
%   fig2_architecture.png 系统架构(对应原 mermaid 图)
%   fig3_clocks.png       时钟与复位结构
%   fig4_ethpath.png      网口视频通道数据通路
%   fig5_timingpath.png   时序瓶颈路径
%
% 用法:  cd tools; plot_blockdiagrams
%
% 两个 MATLAB 坑(都已规避,但改这个文件时要记得):
%   1) 单引号字符串不解释换行转义,必须过 sprintf 才是真换行 —— 且"sprintf 必须
%      放在脚本本体里",写成局部函数包一层会因为作用域丢变量而出错。
%      所以本文件直接在 box() 的调用处用 sprintf。
%   2) 脚本里的局部函数必须放在文件**末尾**,放在中间会报
%      "是否使用变量关键字 end" 之类的语法错。
%   3) 全程 Interpreter=none,否则 hdmi_loop / src_min 的下划线会被当 TeX 下标。

clear; close all;
OUT = fullfile(fileparts(mfilename('fullpath')),'figs');
if ~exist(OUT,'dir'); mkdir(OUT); end

%% ==================== 图 1:项目总览 ====================
f = figure('Color','w','Position',[60 60 1280 420]); ax = axes('Parent',f); hold(ax,'on');
C_IN=[0.84 0.91 0.99]; C_HAZE=[0.86 0.95 0.89]; C_OUT=[0.99 0.92 0.83]; C_ETH=[0.93 0.89 0.98];

boxc(ax, 0.3, 2.30, 1.7, 0.75, {'外部 HDMI 源'},                    C_IN,   10);
boxc(ax, 2.5, 2.30, 1.9, 0.75, {'HDMI 接收 RX','RGB888 + HS/VS/DE'}, C_IN,   9);
boxc(ax, 4.9, 2.30, 1.9, 0.75, {'去雾流水线','Y_ENHANCE=0 默认'},    C_HAZE, 9);
boxc(ax, 7.3, 2.30, 1.9, 0.75, {'key_in[0] 一键切换','去雾 / 直连'}, C_OUT,  9);
boxc(ax, 9.7, 2.95, 1.7, 0.62, {'HDMI 发送 TX','→ 显示器'},           C_OUT,  9);
boxc(ax, 9.7, 1.75, 1.7, 0.62, {'网口通道','→ PC'},                  C_ETH,  9);
boxc(ax, 4.3, 0.75, 2.4, 0.70, {'key_in[2]','推流使能'},            C_ETH,  9);
boxc(ax, 7.0, 0.75, 4.4, 0.70, {'1/2×1/2 抽取 + RGB565 → camera_fifo','→ UDP/IP → RGMII PHY → 网线'}, C_ETH, 8.5);

arrowc(ax, 2.00,2.68, 2.45,2.68);
arrowc(ax, 4.40,2.68, 4.85,2.68);
arrowc(ax, 6.80,2.68, 7.25,2.68);
arrowc(ax, 9.20,2.72, 9.65,3.10);
arrowc(ax, 9.20,2.55, 9.65,2.15);
arrowc(ax, 6.70,1.10, 6.95,1.10);          % key_in[2] -> 抽取/FIFO 链
xlim(ax,[0 11.8]); ylim(ax,[0.4 3.8]); axis(ax,'off');
title(ax,'hdmi_loop 项目总览:HDMI 环出 + 并行网口通道','FontSize',13,'FontWeight','bold','Interpreter','none');
exportgraphics(f, fullfile(OUT,'fig1_overview.png'), 'Resolution',200); close(f);

%% ==================== 图 2:系统架构 ====================
% 拓扑逐条对照 haze_removal_top.v 的端口连接。原图(pre_img)扇出到 4 个消费者:
%   dark_channel / calculate_A / time_alignment(src 通路) / 直连通路
% 其中 dark_channel 与 calculate_A 是**并行**分支。控制信号 key_in[2] 是
% video_to_eth 的写使能门控(输入),不是它的下游 —— 别画反。
f = figure('Color','w','Position',[50 50 1500 860]); ax = axes('Parent',f); hold(ax,'on');

pane(ax, 0.3, 5.8, 2.6, 2.7, '输入侧',                       [0.80 0.89 0.99]);
pane(ax, 3.3, 4.3, 6.2, 4.2, '去雾流水线 haze_removal_top',  [0.82 0.94 0.86]);
pane(ax,10.0, 4.3, 4.3, 4.2, '输出侧',                       [0.99 0.90 0.82]);
pane(ax, 0.3, 0.3,14.3, 3.6, '网口通道 sources_1/ethernet',  [0.92 0.88 0.97]);

boxc(ax, 0.5, 7.6, 2.2, 0.60, {'HDMI RX 并行','RGB888 + hs/vs/de'}, [0.88 0.94 1.00], 8);
boxc(ax, 0.5, 6.9, 2.2, 0.50, {'IBUFG -> sys_vin_clk'},           [0.88 0.94 1.00], 8);
boxc(ax, 0.5, 6.3, 2.2, 0.50, {'sys_pll MMCM 200->27MHz'},        [0.88 0.94 1.00], 8);

boxc(ax, 3.7, 7.6, 2.1, 0.60, {'dark_channel','src_min + 7x7'},          [0.90 0.96 0.91], 8);
boxc(ax, 6.2, 7.6, 2.1, 0.60, {'calculate_A','逐帧大气光 A'},             [0.90 0.96 0.91], 8);
boxc(ax, 6.2, 6.5, 2.1, 0.60, {'tx_get','t = 1 - w*I_dark/A'},           [0.90 0.96 0.91], 8);
boxc(ax, 3.7, 5.4, 4.6, 0.60, {'time_alignment','图像 / 透射率 / 大气光 对齐'}, [0.90 0.96 0.91], 8);
boxc(ax, 3.7, 4.4, 4.6, 0.70, {'haze_removal_cal','J = (I-A)/t + A','有符号定点 + 饱和'}, [0.82 0.92 0.86], 9);

boxc(ax,10.3, 7.6, 3.7, 0.60, {'mode_cur  0去雾 / 1直连'},         [0.99 0.92 0.84], 9);
boxc(ax,10.3, 6.6, 3.7, 0.50, {'直连通路 vin 2 级延迟'},           [0.99 0.92 0.84], 9);
boxc(ax,10.3, 5.6, 3.7, 0.50, {'key_in[0] 切换(同步+去抖+帧边界)'}, [0.99 0.92 0.84], 8);
boxc(ax,10.3, 4.5, 3.7, 0.50, {'HDMI TX  vout_*'},                [0.99 0.92 0.84], 9);

boxc(ax, 0.6, 3.10, 2.2, 0.50, {'key_in[2] 推流开关'},                    [0.95 0.91 0.99], 8);
boxc(ax, 0.6, 2.10, 2.6, 0.70, {'video_to_eth','1/2x1/2 抽取 RGB565'},   [0.95 0.91 0.99], 8);
boxc(ax, 3.8, 2.10, 2.6, 0.70, {'camera_fifo','4096x8 跨时钟'},          [0.95 0.91 0.99], 8);
boxc(ax, 7.0, 2.10, 2.6, 0.70, {'mac_test','帧边界复位控制'},             [0.95 0.91 0.99], 8);
boxc(ax,10.2, 2.10, 2.6, 0.70, {'udp_tx  768 B 载荷','源端口=0x1000+行号'},[0.95 0.91 0.99], 8);
boxc(ax,10.2, 1.10, 2.6, 0.60, {'ip_tx  IP ID = 行号'},                  [0.95 0.91 0.99], 8);
boxc(ax, 7.0, 1.10, 2.6, 0.60, {'mac_tx'},                              [0.95 0.91 0.99], 8);
boxc(ax, 3.8, 1.10, 2.6, 0.60, {'util_gmii_to_rgmii  tap 30'},           [0.95 0.91 0.99], 8);
boxc(ax, 0.6, 1.10, 2.6, 0.60, {'RGMII PHY -> 网线 -> PC'},              [0.95 0.91 0.99], 8);

% 原图扇出母线:x=3.45 竖线,不穿过任何方块
plot([2.70 3.45],[7.90 7.90],'-','Color',[0.20 0.20 0.20],'LineWidth',1.25,'Parent',ax);
plot([3.45 3.45],[5.70 8.40],'-','Color',[0.20 0.20 0.20],'LineWidth',1.25,'Parent',ax);
text(3.38, 8.47,'原图 pre_img','FontSize',7.5,'Color',[0.3 0.3 0.3], ...
     'HorizontalAlignment','left','Parent',ax,'Interpreter','none');
arrowc(ax, 3.45,7.90, 3.70,7.90);
arrowL(ax, [3.45 7.25 7.25], [7.25 7.25 7.60]);
arrowc(ax, 3.45,5.70, 3.70,5.70);
arrowL(ax, [3.45 10.10 10.10 10.30], [8.40 8.40 6.85 6.85]);

arrowL(ax, [4.65 4.65 6.20], [7.60 6.80 6.80]);
arrowc(ax, 7.25,6.50, 7.25,6.02);
arrowc(ax, 8.30,7.90, 9.10,7.90);
arrowc(ax, 9.10,7.90, 9.10,5.70);
arrowc(ax, 9.10,5.70, 8.30,5.70);
arrowc(ax, 6.00,5.40, 6.00,5.12);
arrowL(ax, [8.30 9.30 9.30 10.30], [4.75 4.75 7.90 7.90]);

arrowc(ax,14.00,6.85,14.45,6.85);
arrowc(ax,14.45,6.85,14.45,7.90);
arrowc(ax,14.45,7.90,14.00,7.90);
arrowc(ax,10.30,5.85, 9.90,5.85);
arrowc(ax, 9.90,5.85, 9.90,7.75);
arrowc(ax, 9.90,7.75,10.30,7.75);
arrowL(ax, [14.00 14.20 14.20 14.00], [7.70 7.70 4.75 4.75]);
% mux -> video_to_eth:绕行回边。终点必须落在 v2e 的**顶边**(x=3.05),
% 若落在右边缘(3.20,2.45)会与 v2e->camera_fifo 的箭头起点重合,变成双向箭头。
% 竖向走 x=3.05 是为了避开 key_in[2] 方块(x 范围 0.6..2.8)。
arrowL(ax, [10.30 10.15 10.15 3.05 3.05], [8.05 8.05 3.75 3.75 2.82]);
arrowc(ax, 1.70,3.10, 1.70,2.82);

arrowc(ax, 3.20,2.45, 3.80,2.45);  arrowc(ax, 6.40,2.45, 7.00,2.45);
arrowc(ax, 9.60,2.45,10.20,2.45);  arrowc(ax,11.50,2.10,11.50,1.72);
arrowc(ax,10.20,1.40, 9.60,1.40);  arrowc(ax, 7.00,1.40, 6.40,1.40);
arrowc(ax, 3.80,1.40, 3.20,1.40);

xlim(ax,[0 15.6]); ylim(ax,[0.2 9.0]); axis(ax,'off');
title(ax,'hdmi_loop 系统架构','FontSize',14,'FontWeight','bold','Interpreter','none');
exportgraphics(f, fullfile(OUT,'fig2_architecture.png'), 'Resolution',200); close(f);

fprintf('fig1, fig2 done\n');

%% ==================== 图 3:时钟与复位 ====================
f = figure('Color','w','Position',[60 60 1300 460]); ax = axes('Parent',f); hold(ax,'on');
CE=[0.86 0.93 0.99]; CR=[0.99 0.93 0.85];
boxc(ax, 0.3, 2.55, 2.0, 0.55, {'sys_clk_p/n (R4)','200 MHz 差分'}, CE, 9);
boxc(ax, 2.9, 2.55, 1.8, 0.55, {'IBUFDS + BUFG','sys_clk_200m'}, CE, 9);
boxc(ax, 5.4, 3.30, 2.4, 0.50, {'sys_pll MMCM','PRIM_SOURCE=No_buffer'}, CE, 8.5);
boxc(ax, 8.4, 3.30, 2.2, 0.50, {'27 MHz → i2c_config'}, CE, 8.5);
boxc(ax, 5.4, 2.55, 2.4, 0.50, {'IDELAYCTRL.REFCLK','(rgmii_idelay_group)'}, CE, 8.5);
boxc(ax, 5.4, 1.80, 2.4, 0.50, {'reset 335 ms','→ phy_rst_n → e_reset'}, CR, 8.5);
boxc(ax, 8.4, 1.80, 3.0, 0.50, {'& IDELAYCTRL.RDY','→ 3 级同步 → eth_rst_n'}, CR, 8.5);
boxc(ax, 0.3, 0.85, 2.0, 0.55, {'vin_clk 148.5 MHz'}, CE, 9);
boxc(ax, 2.9, 0.85, 1.8, 0.55, {'IBUFG','sys_vin_clk'}, CE, 9);
boxc(ax, 5.4, 0.85, 3.2, 0.55, {'去雾链 / 直连延迟 / video_to_eth'}, CE, 8.5);
arrowc(ax, 2.30,2.82, 2.85,2.82);
arrowc(ax, 4.70,2.82, 5.35,3.55);
arrowc(ax, 4.70,2.82, 5.35,2.80);
arrowc(ax, 4.70,2.82, 5.35,2.05);
arrowc(ax, 7.80,3.55, 8.35,3.55);
arrowc(ax, 7.80,2.05, 8.35,2.05);
arrowc(ax, 2.30,1.12, 2.85,1.12);
arrowc(ax, 4.70,1.12, 5.35,1.12);
xlim(ax,[0 11.8]); ylim(ax,[0.5 4.1]); axis(ax,'off');
title(ax,'hdmi_loop 时钟与复位结构','FontSize',13,'FontWeight','bold','Interpreter','none');
exportgraphics(f, fullfile(OUT,'fig3_clocks.png'), 'Resolution',200); close(f);

%% ==================== 图 4:网口数据通路 ====================
% 发送链的真实顺序(看 mac_test 的实例化层次):
%   camera_fifo -> mac_test -> udp_tx -> ip_tx -> mac_tx -> util_gmii_to_rgmii -> PHY
% 之前画成"上排走到右再折回下排往左再回右",下排出现方向相反的箭头,是错的。
f = figure('Color','w','Position',[60 60 1420 420]); ax = axes('Parent',f); hold(ax,'on');
CG=[0.87 0.94 0.99];

boxc(ax, 0.2, 1.90, 2.0, 0.62, {'vout_* 复用后画面','RGB888 @148.5 MHz'}, CG, 8.5);
boxc(ax, 2.6, 1.90, 2.0, 0.62, {'video_to_eth','1/2 列+1/2 行抽取','RGB888→RGB565'}, CG, 8.5);
boxc(ax, 5.0, 1.90, 2.0, 0.62, {'camera_fifo','4096×8 跨时钟','写148.5/读125 MHz'}, CG, 8.5);
boxc(ax, 7.4, 1.90, 2.0, 0.62, {'mac_test','帧边界复位控制','→ udp_tx'}, CG, 8.5);
boxc(ax, 9.8, 1.90, 2.0, 0.62, {'udp_tx','768 B 载荷','源端口=0x1000+行号'}, CG, 8.5);

boxc(ax, 9.8, 0.60, 2.0, 0.62, {'ip_tx','IP ID = 行号'}, CG, 8.5);
boxc(ax, 7.4, 0.60, 2.0, 0.62, {'mac_tx'}, CG, 8.5);
boxc(ax, 5.0, 0.60, 2.0, 0.62, {'util_gmii_to_rgmii','ODDR/IDDR + tap 30'}, CG, 8.5);
boxc(ax, 2.6, 0.60, 2.0, 0.62, {'RGMII PHY','→ 网线 → PC'}, CG, 8.5);

% 单一流向:上排左->右,再下折,下排右->左,与真实发送顺序一致
arrowc(ax, 2.25,2.21, 2.55,2.21);
arrowc(ax, 4.65,2.21, 4.95,2.21);
arrowc(ax, 7.05,2.21, 7.35,2.21);
arrowc(ax, 9.45,2.21, 9.75,2.21);
arrowc(ax,10.80,1.85, 10.80,1.27);       % 下折:udp_tx -> ip_tx
arrowc(ax, 9.75,0.91, 9.45,0.91);        % ip_tx -> mac_tx(向左)
arrowc(ax, 7.35,0.91, 7.05,0.91);        % mac_tx -> util_gmii_to_rgmii(向左)
arrowc(ax, 4.95,0.91, 4.65,0.91);        % util_gmii -> PHY(向左)

xlim(ax,[0 12.0]); ylim(ax,[0.2 2.8]); axis(ax,'off');
title(ax,'网口视频通道数据通路:发送链(960×540 RGB565 @60fps)','FontSize',13,'FontWeight','bold','Interpreter','none');
exportgraphics(f, fullfile(OUT,'fig4_ethpath.png'), 'Resolution',200); close(f);

%% ==================== 图 5:时序瓶颈路径 ====================
% 画成水平链:tx_prod_r 是起点(寄存器),后面三级才是原先挤在同一周期内的组合逻辑。
% tx_q_r 插在"进位链"与"饱和 mux"之间,后两级都还在 —— 竖排+箭头容易被误读成
% "后面被取代"。实测数字另作独立注释,不混进数据流。
f = figure('Color','w','Position',[50 50 1380 560]); ax = axes('Parent',f); hold(ax,'on');
C_REG=[0.85 0.93 0.88]; C_BAD=[0.96 0.88 0.87];

YW = 1.65; HH = 0.95;
boxc(ax, 0.3, YW, 2.15, HH, {'tx_prod_r','DSP48 输出寄存器'},             C_REG, 8.5);
boxc(ax, 2.85,YW, 2.15, HH, {'9x CARRY4 进位链','(tx_prod_r+32768)>>16'},  C_BAD, 8.5);
boxc(ax, 5.40,YW, 2.15, HH, {'饱和 mux','tx_q>255 ? 255 : 255-tx_q'},      C_BAD, 8.5);
boxc(ax, 7.95,YW, 2.15, HH, {'跨模块 -> a_tx = A*tx','(在 calculate_A 侧)'}, C_BAD, 8.5);
boxc(ax,10.50,YW, 2.30, HH, {'value_tem_*_reg','(haze_removal_cal)'},       C_REG, 8.5);

arrowc(ax, 2.45,YW+HH/2, 2.83,YW+HH/2);
arrowc(ax, 5.00,YW+HH/2, 5.38,YW+HH/2);
arrowc(ax, 7.55,YW+HH/2, 7.93,YW+HH/2);
arrowc(ax,10.10,YW+HH/2,10.48,YW+HH/2);

% 插入点:x=5.17 正是进位链与饱和 mux 之间的空档
plot([5.17 5.17],[YW-0.57 YW+HH+0.60],'--','Color',[0.15 0.45 0.75], ...
     'LineWidth',1.7,'Parent',ax);
text(5.17, YW+HH+0.66,'插入 tx_q_r (1 拍)','FontSize',9.5,'FontWeight','bold', ...
     'Color',[0.10 0.35 0.65],'HorizontalAlignment','center','Parent',ax,'Interpreter','none');
text(5.17, YW-0.50,'进位链与饱和 mux 之间','FontSize',8.5,'Color',[0.25 0.25 0.25], ...
     'HorizontalAlignment','center','Parent',ax,'Interpreter','none');

% 原先同周期的范围
plot([2.85 7.55],[YW+HH+0.20 YW+HH+0.20],'-','Color',[0.62 0.22 0.22], ...
     'LineWidth',1.0,'Parent',ax);
text(5.20, YW+HH+0.27,'原先全在同一周期(8.75 ns,要求 6.734 ns)','FontSize',8.5, ...
     'Color',[0.62 0.22 0.22],'HorizontalAlignment','center','Parent',ax,'Interpreter','none');

% 实测:独立注记,不画成数据流
boxc(ax, 0.3, 0.06, 6.0, 0.78, ...
     {'实测(同一份 RTL,插寄存器前 -> 后)','WNS  -1.985 ns -> -0.292 ns','失败端点  31 -> 7'}, ...
     [0.90 0.92 0.97], 9);
text(6.50, 0.46,'<< 非数据流,仅记录测量结果','FontSize',8.5,'Color',[0.35 0.35 0.35], ...
     'HorizontalAlignment','left','Parent',ax,'Interpreter','none');
text(0.35, 0.06,'绿色 = 寄存器(时序边界);红色 = 原先同周期内的组合逻辑', ...
     'FontSize',8,'Color',[0.40 0.40 0.40],'HorizontalAlignment','left', ...
     'Parent',ax,'Interpreter','none');

xlim(ax,[0 13.2]); ylim(ax,[-0.05 3.5]); axis(ax,'off');
title(ax,'tx_get 组合链切分:tx_q_r 插入位置与实测效果','FontSize',13, ...
      'FontWeight','bold','Interpreter','none');
exportgraphics(f, fullfile(OUT,'fig5_timingpath.png'), 'Resolution',200); close(f);

fprintf('fig1..fig5 all done -> %s\n', OUT);

%% ==================== 局部函数(必须在文件末尾) ====================
function boxc(ax, x, y, w, hh, lines, fc, fs)
    if w <= 0 || hh <= 0, return; end
    patch([x x+w x+w x],[y y y+hh y+hh], fc, 'FaceAlpha',0.95, ...
          'EdgeColor',[0.15 0.15 0.15],'LineWidth',1.1,'Parent',ax);
    text(x+w/2, y+hh/2, lines, 'HorizontalAlignment','center', ...
         'VerticalAlignment','middle','FontSize',fs,'Parent',ax,'Interpreter','none');
end

function pane(ax, x, y, w, hh, t, c)
    patch([x x+w x+w x],[y y y+hh y+hh], c, 'FaceAlpha',0.32, ...
          'EdgeColor',[0.45 0.45 0.45],'LineWidth',1.2,'LineStyle','--','Parent',ax);
    % 标题放面板上方,避免被内部方块压住
    text(x+w/2, y+hh+0.09, t, 'FontSize',10,'FontWeight','bold', ...
         'Color',[0.25 0.25 0.25],'HorizontalAlignment','center', ...
         'VerticalAlignment','bottom','Parent',ax,'Interpreter','none');
end

function arrowL(ax, xs, ys)
    % 折线箭头:用于需要绕行的边(如 mux -> video_to_eth 的回边)。
    % xs/ys 为折点序列,箭头画在最后一段末端。
    col = [0.35 0.35 0.35]; lw = 1.15; head = 0.09;
    plot(xs, ys, '-','Color',col,'LineWidth',lw,'Parent',ax);
    n = numel(xs);
    dx = xs(n)-xs(n-1); dy = ys(n)-ys(n-1); L = hypot(dx,dy);
    if L < 1e-9, return; end
    ux = dx/L; uy = dy/L; px = -uy; py = ux;
    patch([xs(n), xs(n)-ux*head+px*head*0.55, xs(n)-ux*head-px*head*0.55], ...
          [ys(n), ys(n)-uy*head+py*head*0.55, ys(n)-uy*head-py*head*0.55], col, ...
          'EdgeColor','none','Parent',ax);
end

function arrowc(ax, x1, y1, x2, y2)
    col = [0.20 0.20 0.20]; lw = 1.25; head = 0.09;
    dx = x2-x1; dy = y2-y1; L = hypot(dx,dy);
    if L < 1e-9, return; end
    ux = dx/L; uy = dy/L;
    plot([x1 x2-ux*head],[y1 y2-uy*head],'-','Color',col,'LineWidth',lw,'Parent',ax);
    px = -uy; py = ux;
    patch([x2, x2-ux*head+px*head*0.55, x2-ux*head-px*head*0.55], ...
          [y2, y2-uy*head+py*head*0.55, y2-uy*head-py*head*0.55], col, ...
          'EdgeColor','none','Parent',ax);
end
