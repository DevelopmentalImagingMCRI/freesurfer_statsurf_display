function [varargout] = freesurfer_statsurf_savefig(PNGName)

FigPos = get(gcf, 'Position');
set(gcf, 'PaperPosition', FigPos, 'PaperUnits', 'points', 'InvertHardCopy', 'off');
%keyboard;
PNGName = fullfile(GHPages, 'main_dkt_fsrgb.png');
exportfig(gcf, PNGName, 'Format', 'png', 'Width', FigPos(3), 'Height', FigPos(4), 'Color', 'rgb');

IMG = imread(PNGName);
IMG = imautocropblack(IMG, 10);
imwrite(IMG, PNGName);