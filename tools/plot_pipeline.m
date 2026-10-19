%% plot_pipeline.m —— hdmi_loop 去雾流水线延迟时序图
%
% 延迟数字全部由 RTL 逐级数出,并与 tb_haze_removal_top.v 的实测交叉验证:
%   dark_channel 推算 13 拍 == 仿真"暗通道核对最佳延迟 D = 13"
%   src_delay 17 == dark(13) + tx_get(4)
%
% 用法(MATLAB):  cd tools; plot_pipeline
% 输出:          tools/figs/pipeline_timing.png

clear; close all;
% 全程关掉 TeX 解释器:否则 hdmi_loop / src_min 里的下划线会被当成下标
TEX = {'Interpreter','none'};

WINDOW_PASSES = 3;                    % 与 dark_channel.v / time_alignment.v 一致
FCLK  = 148.5e6;                      % vin_clk
TPER  = 1/FCLK*1e9;                   % 每拍 ns

% ---------------- 各段延迟(拍),全部来自 RTL ----------------
d.src_min   = 1;                                                    % pixel_min_of_rgb 一次寄存
d.per_pass  = 4;                                                    % search_block_min:2 拍控制 + 2 拍矩阵
d.dark      = d.src_min + WINDOW_PASSES*d.per_pass;                 % 13
d.tx        = 4;                                                    % modify_A,recip_r,tx_prod_r,tx_q_r
d.cal       = 2;                                                    % value_tem -> prod(DSP48) -> post_img
d.out       = 2;                                                    % 输出 mux / 标记对齐
d.src_delay = d.dark + d.tx;                                        % 17
TOTAL       = d.dark + d.tx + d.cal + d.out;                        % 21

% ---------------- 数据通路(顺序拼接) ----------------
% 字段: 名称, 起点, 长度, 颜色, 标签放哪(1=条内 0=条上方)
above_lvl = 0;
seg = {
  'src_min',                              0,                     d.src_min,                            [0.20 0.45 0.78], 0
  sprintf('search_block_min  (3 级串联 = 7×7)'), d.src_min,       WINDOW_PASSES*d.per_pass,             [0.13 0.58 0.44], 1
  sprintf('tx_get  (t = 1-ω·dc/A)'),      d.src_min+WINDOW_PASSES*d.per_pass, d.tx,                     [0.88 0.47 0.16], 1
  sprintf('haze_removal_cal  (J=(I-A)/t+A)'), d.src_min+WINDOW_PASSES*d.per_pass+d.tx, d.cal,          [0.58 0.32 0.72], 0
  '输出 mux / 标记对齐',                  d.dark+d.tx+d.cal,     d.out,                                [0.45 0.45 0.48], 0
};

YLO = 0.58; YHI = 0.86;               % 数据通路条的上下沿

fig = figure('Color','w','Position',[60 60 1280 640]);
ax  = axes('Parent',fig); hold(ax,'on');

for k = 1:size(seg,1)
    nm = seg{k,1}; x0 = seg{k,2}; w = seg{k,3}; col = seg{k,4}; inside = seg{k,5};
    patch([x0 x0+w x0+w x0], [YLO YLO YHI YHI], col, ...
          'FaceAlpha',0.9,'EdgeColor','k','LineWidth',1.1,'Parent',ax);
    if inside
        text(x0+w/2, (YLO+YHI)/2, sprintf('%s\n%d 拍', nm, w), ...
             'HorizontalAlignment','center','VerticalAlignment','middle', ...
             'FontSize',10,'Color','w','FontWeight','bold','Parent',ax, TEX{:});
    else
        % 窄条:标签放到条上方并逐条抬高 + 引线指回本条(否则相邻窄条互相压)
        yoff = 0.045 + 0.115*above_lvl;  above_lvl = above_lvl + 1;
        plot([x0+w/2 x0+w/2], [YHI YHI+yoff], '-k','LineWidth',0.8,'Parent',ax);
        text(x0+w/2, YHI+yoff+0.012, sprintf('%s\n%d 拍', nm, w), ...
             'FontSize',9,'Color',[0.1 0.1 0.1],'Parent',ax, TEX{:});
    end
end

% ---------------- time_alignment 对齐通路 ----------------
A2LO = 0.13; A2HI = 0.43;
patch([0 d.src_delay d.src_delay 0], [A2LO A2LO A2HI A2HI], [0.86 0.86 0.33], ...
      'FaceAlpha',0.9,'EdgeColor','k','LineWidth',1.1,'Parent',ax);
text(d.src_delay/2, A2HI+0.045, ...
     sprintf('time_alignment   src_delay = %d 拍 = dark(%d) + tx_get(%d)', ...
             d.src_delay, d.dark, d.tx), ...
     'HorizontalAlignment','center','VerticalAlignment','bottom', ...
     'FontSize',10,'FontWeight','bold','Parent',ax, TEX{:});

% ---------------- 里程碑竖线 ----------------
yl = [0.13 0.98];
plot([d.dark d.dark], yl, '--','Color',[0.35 0.35 0.35],'LineWidth',1.1,'Parent',ax);
text(d.dark-0.2, yl(2)+0.02, sprintf('t 就绪 @%d 拍', d.dark), ...
     'HorizontalAlignment','right','VerticalAlignment','bottom','FontSize',9,'Parent',ax, TEX{:});

plot([d.src_delay d.src_delay], yl, '-.','Color',[0.15 0.15 0.15],'LineWidth',1.4,'Parent',ax);
text(d.src_delay+0.3, A2HI+0.045, ...
     sprintf('两路在 haze_removal_cal\n入口对齐 (@%d 拍)', d.src_delay), ...
     'HorizontalAlignment','left','VerticalAlignment','bottom', ...
     'FontSize',9,'Color',[0.15 0.15 0.15],'Parent',ax, TEX{:});

% ---------------- 画布 ----------------
xlim(ax,[-0.5 TOTAL+2.6]);  ylim(ax,[0.02 1.30]);
set(ax,'YTick',[],'XTick',0:2:TOTAL,'FontSize',9);
xlabel(ax, sprintf('时间 (拍 @ 148.5 MHz,1 拍 = %.3f ns)   最终输出 @ %d 拍 ≈ %.1f ns', ...
       TPER, TOTAL, TOTAL*TPER),'FontSize',10, TEX{:});
title(ax, sprintf('hdmi_loop 去雾流水线延迟架构(端到端 %d 拍)', TOTAL), ...
      'FontSize',13,'FontWeight','bold', TEX{:});
grid(ax,'on'); box(ax,'on');

% 图注放左上角空白处,避开所有条与 xlabel
text(0.015, 0.985, ...
  sprintf(['延迟由 RTL 逐级数出:src_min 1 + search_block_min 4×3 + tx_get 4 + haze_removal_cal 2 + 输出 2 = %d 拍\n' ...
           '交叉验证:dark_channel 推算 13 拍 == tb 实测"暗通道核对最佳延迟 D = 13"'], TOTAL), ...
  'Units','normalized','HorizontalAlignment','left','VerticalAlignment','top', ...
  'FontSize',8.5,'Color',[0.35 0.35 0.35],'Parent',ax, TEX{:});

outdir = fullfile(fileparts(mfilename('fullpath')),'figs');
if ~exist(outdir,'dir'); mkdir(outdir); end
out = fullfile(outdir,'pipeline_timing.png');
exportgraphics(fig, out, 'Resolution', 200);
fprintf('OK saved: %s\n', out);
fprintf('end-to-end %d cycles = %.1f ns @ %.1f MHz\n', TOTAL, TOTAL*TPER, FCLK/1e6);
