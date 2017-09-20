function [varargout] = freesurfer_statsurf_savefig(PNGName)

FigPos = get(gcf, 'Position');
set(gcf, 'PaperPosition', FigPos, 'PaperUnits', 'points', 'InvertHardCopy', 'off');
exportfig(gcf, PNGName, 'Format', 'png', 'Width', FigPos(3), 'Height', FigPos(4), 'Color', 'rgb');

IMG = imread(PNGName);
IMG = imautocrop(IMG, 10);
imwrite(IMG, PNGName);
