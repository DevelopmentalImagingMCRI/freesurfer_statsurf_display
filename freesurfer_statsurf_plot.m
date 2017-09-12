function [varargout] = freesurfer_statsurf_plot(FSAverageV, FSAverageF, FaceVertexCData, FreesurferSeedType, ...
	ValuesMask, CMAPX, CMAPIMG, MainTitle, SurfType, LegendLabel, LegendXTick, LegendXTickLabels, UseShortLabels, NoLabels, NoLegend, MedialLateralLabels, LabelColour)

% plots the stat surfaces

% 
% VariablesNeeded = {'ValuesMask', 'FSAverageVInflated', 'FSAverageF', 'FreesurferSeedType', ...
% 	'LegendLabel', 'CMAPX', 'CMAPIMG', 'LegendXTick', 'LegendXTickLabels', 'MainTitle'};
% 
% for z = 1:length(VariablesNeeded)
% 	if(exist(VariablesNeeded{z}, 'var') ~= 1)
% 		error(['Variable does not exist: ' VariablesNeeded{z}]);
% 	end
% end

if nargin < 17
	LabelColour = 'w';
end

[APARCLabels{1:2}] = deal({'bankssts', 'caudalanteriorcingulate', 'caudalmiddlefrontal', ...
	'cuneus', 'entorhinal', 'fusiform', ...
	'inferiorparietal', 'inferiortemporal', 'isthmuscingulate', ...
    'lateraloccipital', 'lateralorbitofrontal', 'lingual', ...
	'medialorbitofrontal', 'middletemporal',  'parahippocampal', ...
    'paracentral', 'parsopercularis', 'parsorbitalis', ...
    'parstriangularis', 'pericalcarine', 'postcentral', ...
    'posteriorcingulate', 'precentral', 'precuneus', ...
    'rostralanteriorcingulate', 'rostralmiddlefrontal', 'superiorfrontal', ...
    'superiorparietal', 'superiortemporal', 'supramarginal', ...
    'frontalpole', 'temporalpole', 'transversetemporal', 'insula'});

[DKTLabels{1:2}] = deal({'caudalanteriorcingulate', 'caudalmiddlefrontal', ...
	'cuneus', 'entorhinal', 'fusiform', ...
	'inferiorparietal', 'inferiortemporal', 'isthmuscingulate', ...
    'lateraloccipital', 'lateralorbitofrontal', 'lingual', ...
	'medialorbitofrontal', 'middletemporal',  'parahippocampal', ...
    'paracentral', 'parsopercularis', 'parsorbitalis', ...
    'parstriangularis', 'pericalcarine', 'postcentral', ...
    'posteriorcingulate', 'precentral', 'precuneus', ...
    'rostralanteriorcingulate', 'rostralmiddlefrontal', 'superiorfrontal', ...
    'superiorparietal', 'superiortemporal', 'supramarginal', ...
    'transversetemporal', 'insula'});

if UseShortLabels
	APARCShortLabels = {'BSTS', 'CAC', 'CMF', 'CUN', 'ENT', 'FUS', ...
				'INFP', 'IT', 'ISTC', 'LOCC', 'LORB', 'LIN', 'MORB', 'MT', ...
				'PARH', 'PARC', 'POPE', 'PORB', 'PTRI', 'PCAL', 'PSTS', 'PC', ...
				'PREC', 'PCUN', 'RAC', 'RMF', 'SF', 'SP', 'ST', 'SMAR', 'FP', 'TP', 'TT', 'INS'};
	DKTShortLabels = {'CAC', 'CMF', 'CUN', 'ENT', 'FUS', ...
				'INFP', 'IT', 'ISTC', 'LOCC', 'LORB', 'LIN', 'MORB', 'MT', ...
				'PARH', 'PARC', 'POPE', 'PORB', 'PTRI', 'PCAL', 'PSTS', 'PC', ...
				'PREC', 'PCUN', 'RAC', 'RMF', 'SF', 'SP', 'ST', 'SMAR', 'TT', 'INS'};
else
	APARCShortLabels = [];
	DKTShortLabels = [];
end

switch(FreesurferSeedType)
	case 'aparc'
		RegionLabels = APARCLabels;
		ShortRegionLabels = APARCShortLabels;
	case 'dkt'
		RegionLabels = DKTLabels;
		ShortRegionLabels = DKTShortLabels;
end

if isempty(ValuesMask) && ismember(FreesurferSeedType, {'aparc', 'dkt'})
		ValuesMask = cellfun(@(x) (true(size(x))), RegionLabels, 'UniformOutput', false);
end

Hemis = {'lh', 'rh'};

clf;
FigPos = [1 1 1048 850];
%FigPos = [1702 100 1048 850]; % just for multiple monitors
set(gcf, 'Color', 'k', 'Position', FigPos, 'PaperPosition', FigPos, 'PaperUnits', 'points', 'InvertHardCopy', 'off');

switch(SurfType)
	case {'pial', 'white'}
		ZoomFactor = 1;
	case 'inflated'
		ZoomFactor = 2;
end
%#$ZoomFactor = 2; % for inflated
%ZoomFactor = 1; % for pial
clf;
AX = zeros(2, 2);
Patches = zeros(2, 2);

PatchProps = {'EdgeColor', 'none', 'AmbientStrength', 0.8, 'SpecularStrength', 0.4, 'FaceColor', 'interp'};

for HemiIDX = 1:length(Hemis)
	AX(HemiIDX, 1) = subplot(2, 2, 1 + (HemiIDX - 1) * 2);
	Patches(HemiIDX, 1) = patch('Vertices', FSAverageV{HemiIDX}, 'Faces', FSAverageF{HemiIDX}, 'FaceVertexCData', FaceVertexCData{HemiIDX}, PatchProps{:});
	axis equal off;
	lighting gouraud;
	view(90 + 180 * (HemiIDX - 1), 0);
	camlight;
	zoom(ZoomFactor);
	%title([Hemis{z} ' ' NeuropsychFieldsOfInterest{NSFieldIDX} ' ' APARCFieldsOfInterest{APARCFieldIDX}], 'Interpreter', 'none');
	AX(HemiIDX, 2) = subplot(2, 2, 2 + (HemiIDX - 1) * 2);
	Patches(HemiIDX, 2) = patch('Vertices', FSAverageV{HemiIDX}, 'Faces', FSAverageF{HemiIDX}, 'FaceVertexCData', FaceVertexCData{HemiIDX}, PatchProps{:});
	axis equal off;
	lighting gouraud;
	view(270 + 180 * (HemiIDX - 1), 0);
	camlight;
	zoom(ZoomFactor);
end
UpNudge = 0.2;

for z = 1:2
	AXPos = get(AX(2, z), 'Position');
	AXPos(2) = AXPos(2) + UpNudge;
	set(AX(2, z), 'Position', AXPos);
end

if ~verLessThan('matlab', 'R2016a')
	set(AX, 'Clipping', 'off');
end

TopLeftAXPos = get(AX(1, 1), 'Position');
TopRightAXPos = get(AX(1, 2), 'Position');
BottomLeftAXPos = get(AX(2, 1), 'Position');
BottomRightAXPos = get(AX(2, 2), 'Position');

DoPositionRectangles = false;

if DoPositionRectangles
	Colors = 'rgbm';
	for z = 1:numel(AX)
		AXPos = get(AX(z), 'Position');
		annotation('rectangle', AXPos, 'Color', Colors(z));
	end
end
if ~isempty(CMAPX) && ~NoLegend
	%keyboard;
	LegAXHeight = 0.05;
	LegAXWidth = 0.2;
	LegAX = axes('Position', [(TopLeftAXPos(1) + TopRightAXPos(1) + TopRightAXPos(3)) / 2 - LegAXWidth / 2, ...
		BottomLeftAXPos(2) - LegAXHeight * 1.2, ...
		LegAXWidth, ...
		LegAXHeight]);
	imshow(CMAPIMG, [], 'YData', (1:size(CMAPIMG, 2)) / 10, 'XData', 1:size(CMAPIMG, 2));
	axis xy on;

	set(gca, 'YTick', [], 'Color', 'w', 'XColor', 'w', 'XTick', []);

	LegendXTickIDX = interp1(CMAPX, 1:length(CMAPX), LegendXTick);

	%LegendXTickLabels = {'0', ['>= ' num2str(LargestEffectSize, '%.3f')]};
	for z = 1:length(LegendXTickIDX)
		text(LegendXTickIDX(z), -1, LegendXTickLabels{z}, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top', ...
			'Color', 'w');
	end
	if(~isempty(LegendLabel))
		text(0.5, -1.0, LegendLabel, 'Color', 'w', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top', 'FontSize', 24, 'FontName', 'Times', 'Units', 'normalized');
	end
end

% title
if(~isempty(MainTitle))
	annotation('textbox', 'Position', [(TopLeftAXPos(1) + TopRightAXPos(1) + TopRightAXPos(3)) / 2 - 0.01, ...
		TopLeftAXPos(2) + TopLeftAXPos(4), ...
		0.02, ...
		1 - (TopLeftAXPos(2) + TopLeftAXPos(4))], 'String', MainTitle, 'Color', 'w', 'HorizontalAlignment', 'center', 'FontSize', 18, 'VerticalAlignment', 'top');
end

annotation('textbox', 'Position', [(TopLeftAXPos(1) + TopRightAXPos(1) + TopRightAXPos(3)) / 2 - 0.01, ...
	TopLeftAXPos(2) + 9 * TopLeftAXPos(4) / 10, ...
	0.02, ...
	0.01], 'String', 'LH', 'Color', 'w', 'HorizontalAlignment', 'center', 'FontSize', 18);
annotation('textbox', 'Position', [(BottomLeftAXPos(1) + BottomRightAXPos(1) + BottomRightAXPos(3)) / 2 - 0.01, ...
	BottomLeftAXPos(2) + BottomLeftAXPos(4) / 10, ...
	0.02, ...
	0.01], 'String', 'RH', 'Color', 'w', 'HorizontalAlignment', 'center', 'FontSize', 18);

if MedialLateralLabels
	
	if ~verLessThan('matlab', 'R2016a')
		if ~UseShortLabels
			switch(computer)
				case 'GLNXA64'
					LeftX = -1.2;
					RightX = 2.21;
				otherwise
					LeftX = -1.75;
					RightX = 2.5;
			end
		else
			LeftX = -0.75;
			RightX = 1.71;
		end
	else
		LeftX = -0.2;
		RightX = 1.21;
	end
	T = {'FontSize', 20, 'Color', 'w', 'Units', 'normalized', 'HorizontalAlignment', 'center'};
	text( LeftX, 0.275,  'Medial', 'Parent', AX(1, 1), 'Rotation',  90, T{:});
	text(RightX, 0.275, 'Lateral', 'Parent', AX(1, 2), 'Rotation', 270, T{:});
end
% now put the PA arrows
%keyboard;
TopAXPos = get(AX(1, 1), 'Position');
BotAXPos = get(AX(2, 1), 'Position');

ArrowProps = {'Color', 'w', 'LineWidth', 2};
TextProps = {'Color', 'w', 'LineStyle', 'none', 'EdgeColor', 'w', 'VerticalAlignment', 'middle', 'FontSize', 20};

W = 0.15;
annotation('doublearrow', [TopAXPos(1) + TopAXPos(3) * W, TopAXPos(1) + TopAXPos(3) * (1 - W)], ...
	repmat(TopAXPos(2) + TopAXPos(4), 1, 2), ArrowProps{:});
annotation('textbox', [TopAXPos(1), TopAXPos(2) + TopAXPos(4) - 0.1, TopAXPos(3) * W, 0.2], 'String', 'P', ...
	TextProps{:}, ...
	'HorizontalAlignment', 'right');
annotation('textbox', [TopAXPos(1) + TopAXPos(3) * (1 - W), TopAXPos(2) + TopAXPos(4) - 0.1, TopAXPos(3) * W, 0.2], 'String', 'A', ...
	TextProps{:}, ...
	'HorizontalAlignment', 'left');

T = 0.105;
% bottom left
annotation('doublearrow', [BotAXPos(1) + BotAXPos(3) * W, BotAXPos(1) + BotAXPos(3) * (1 - W)], ...
	repmat(BotAXPos(2), 1, 2) + 0.1 - T, ArrowProps{:});
annotation('textbox', [BotAXPos(1), BotAXPos(2) - T, BotAXPos(3) * W, 0.2], 'String', 'A', ...
	TextProps{:}, ...
	'HorizontalAlignment', 'right');
annotation('textbox', [BotAXPos(1) + BotAXPos(3) * (1 - W), BotAXPos(2) - T, BotAXPos(3) * W, 0.2], 'String', 'P', ...
	TextProps{:}, ...
	'HorizontalAlignment', 'left');

TopAXPos = get(AX(1, 2), 'Position');
BotAXPos = get(AX(2, 2), 'Position');

% top right
annotation('doublearrow', [TopAXPos(1) + TopAXPos(3) * W, TopAXPos(1) + TopAXPos(3) * (1 - W)], ...
	repmat(TopAXPos(2) + TopAXPos(4), 1, 2), ArrowProps{:});
annotation('textbox', [TopAXPos(1), TopAXPos(2) + TopAXPos(4) - 0.1, TopAXPos(3) * W, 0.2], 'String', 'A', ...
	TextProps{:}, ...
	'HorizontalAlignment', 'right');
annotation('textbox', [TopAXPos(1) + TopAXPos(3) * (1 - W), TopAXPos(2) + TopAXPos(4) - 0.1, TopAXPos(3) * W, 0.2], 'String', 'P', ...
	TextProps{:}, ...
	'HorizontalAlignment', 'left');

% bottom right
annotation('doublearrow', [BotAXPos(1) + BotAXPos(3) * W, BotAXPos(1) + BotAXPos(3) * (1 - W)], ...
	repmat(BotAXPos(2) + 0.1 - T, 1, 2), ArrowProps{:});
annotation('textbox', [BotAXPos(1), BotAXPos(2) - T, BotAXPos(3) * W, 0.2], 'String', 'P', ...
	TextProps{:}, ...
	'HorizontalAlignment', 'right');
annotation('textbox', [BotAXPos(1) + BotAXPos(3) * (1 - W), BotAXPos(2) - T, BotAXPos(3) * W, 0.2], 'String', 'A', ...
	TextProps{:}, ...
	'HorizontalAlignment', 'left');
%NoLabels = false;
if(~NoLabels)
	if(ismember(lower(FreesurferSeedType), {'aparc', 'dkt'}))
		if(iscell(ShortRegionLabels))
			FontWeight = 'bold';
			FontSize = 10;
		else
			switch(computer)
					case {'PCWIN64', 'GLNXA64'}
						FontWeight = 'normal';
						FontSize = 8;
					otherwise
						FontWeight = 'bold';
						FontSize = 10;
			end
		end

		LabelTextBoxPropsDone = {'FitBoxToText', 'off', ...
			'Margin', 2, ...
			'Color', LabelColour, 'EdgeColor', 'none', 'LineStyle', 'none', ...
			'VerticalAlignment', 'middle', ...
			'HorizontalAlignment', 'center', ...
			'FontWeight', FontWeight, ...
			'FontSize', FontSize};

		ArrowProps = {'LineWidth', 2, 'Color', LabelColour};
		
		if (verLessThan('matlab', 'r2017a'))
			RectProps = {'FaceColor', 'flat', 'EdgeColor', LabelColour, 'LineWidth', 2};
		else
			RectProps = {'FaceColor', 'none', 'EdgeColor', LabelColour, 'LineWidth', 2};
		end
		% Create textbox
		%LabelTextBoxPropsDone = [LabelTextBoxProps {'Color', 'w'}];
		%RectProps
		[TextBoxes, Arrows, Rectangles] = freesurfer_statplot_aparc_figures_textboxes(FreesurferSeedType);
		if(iscell(ShortRegionLabels))
			ShortRegionLabelsLegendStrings = cell(1000, 1);
			ShortRegionLabelsLegendStringsIDX = 1;
		end
		for HemiIDX = 1:length(Hemis)
			Hemi = upper(Hemis{HemiIDX});
			F = RegionLabels{HemiIDX};

			for CurField = 1:length(F)
				if(ValuesMask{HemiIDX}(CurField))
					if(iscell(ShortRegionLabels))
						% put the abbreviations in instead of the main boxes
						HasArrow = isfield(Arrows.(Hemi), F{CurField});
						HasTextBox = isfield(TextBoxes.(Hemi), F{CurField});
						%HasRectangle = isfield(Rectangles.(Hemi), F{CurField});


						if(HasArrow || HasTextBox)
							% if there is an arrow then put it at the center of the
							% arrow endpoint
							NumTextBoxes = length(TextBoxes.(Hemi).(F{CurField}));
							if(HasArrow)
								XIDX = find(strcmp('X', Arrows.(Hemi).(F{CurField})(1:2:end))); % find 'X' in the parameters, which are in the odd indices
								XIDX = (XIDX - 1) * 2 + 1; % so find the original index that it is in
								CurX = Arrows.(Hemi).(F{CurField}){XIDX + 1};
								YIDX = find(strcmp('Y', Arrows.(Hemi).(F{CurField})(1:2:end))); % find 'X' in the parameters, which are in the odd indices
								YIDX = (YIDX - 1) * 2 + 1; % so find the original index that it is in
								CurY = Arrows.(Hemi).(F{CurField}){YIDX + 1};

								TextBoxesCentroid = [CurX(2), CurY(2)];
							elseif(HasTextBox)
								% if there are textboxes but no arrows, then find
								% the centroid of the textboes

								TextBoxesCentroid = zeros(NumTextBoxes, 2);
								for CurTextBox = 1:NumTextBoxes
									PositionIDX = find(strcmp('Position', TextBoxes.(Hemi).(F{CurField}){CurTextBox}(1:2:end))); % find 'Position' in the parameters, which are in the odd indices
									PositionIDX = (PositionIDX - 1) * 2 + 1; % so find the original index that it is in
									TextBoxPosition = TextBoxes.(Hemi).(F{CurField}){CurTextBox}{PositionIDX + 1};
									TextBoxesCentroid(CurTextBox, :) = [TextBoxPosition(1) + TextBoxPosition(3) / 2, TextBoxPosition(2) + TextBoxPosition(4) / 2];
								end
								TextBoxesCentroid = mean(TextBoxesCentroid, 1);
							end

							TextBoxWidthHeight = [0.2, 0.1];
							annotation('textbox', 'Position', [TextBoxesCentroid(1) - TextBoxWidthHeight(1) / 2, TextBoxesCentroid(2) - TextBoxWidthHeight(2) / 2, TextBoxWidthHeight], ...
								'String', ShortRegionLabels{CurField}, LabelTextBoxPropsDone{:});
							CurString = cell(1, NumTextBoxes);

							for CurTextBox = 1:NumTextBoxes
								StringIDX = find(strcmp('String', TextBoxes.(Hemi).(F{CurField}){CurTextBox}(1:2:end)));
								StringIDX = (StringIDX - 1) * 2 + 1;
								CurString{CurTextBox} = TextBoxes.(Hemi).(F{CurField}){CurTextBox}{StringIDX + 1};
							end
							% now CurString will be a cell array, so we
							% need to join it with spaces
							CurString = cat(1, CurString{:});
							CurString = deblank(sprintf('%s ', CurString{:}));
							CurString = strrep(CurString, '- ', '');
							ShortRegionLabelsLegendStrings{ShortRegionLabelsLegendStringsIDX} = [ShortRegionLabels{CurField} ': ' CurString ', '];
							ShortRegionLabelsLegendStringsIDX = ShortRegionLabelsLegendStringsIDX + 1;
						end
					else
						if(isfield(TextBoxes.(Hemi), F{CurField}))
							for CurBox = 1:length(TextBoxes.(Hemi).(F{CurField}))
								annotation('textbox', LabelTextBoxPropsDone{:}, TextBoxes.(Hemi).(F{CurField}){CurBox}{:});
							end
						end
						if(isfield(Arrows.(Hemi), F{CurField}))
							annotation('arrow', Arrows.(Hemi).(F{CurField}){:}, ArrowProps{:});
						end
						if(isfield(Rectangles.(Hemi), F{CurField}))
							
							annotation('rectangle', Rectangles.(Hemi).(F{CurField}){:}, RectProps{:});
						end
					end	
				end
			end
		end
		if(iscell(ShortRegionLabels))
			ShortRegionLabelsLegendStrings = ShortRegionLabelsLegendStrings(1:ShortRegionLabelsLegendStringsIDX - 1);
			%keyboard;
			ShortRegionLabelsLegendStrings = unique(ShortRegionLabelsLegendStrings);
			ShortRegionLabelsLegendStrings = cat(2, ShortRegionLabelsLegendStrings{:});
			disp(ShortRegionLabelsLegendStrings(1:end - 2));
		end
	end
end