function [varargout] = freesurfer_statsurf_plot(FSAverageV, FSAverageF, FaceVertexCData, FreesurferSeedType, ...
	ValuesMask, CMAPX, CMAPIMG, LegendXTick, LegendXTickLabels, options)

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

HorizontalCompactNudge = 0.07;

if options.UseShortLabels
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

if options.LargeFonts
    FontMult = 1.5;
else
    FontMult = 1;
end

Hemis = {'lh', 'rh'};

clf;
FigPos = [1 1 1048 850];
%FigPos = [1702 100 1048 850]; % just for multiple monitors
set(gcf, 'Color', 'k', 'Position', FigPos, 'PaperPosition', FigPos, 'PaperUnits', 'points', 'InvertHardCopy', 'off');

switch(options.SurfType)
	case {'pial', 'white'}
		if strcmp(options.SurfaceSource, 'fs6')
			ZoomFactor = 2;
		else
			ZoomFactor = 1;
		end
	case 'inflated'
		if strcmp(options.SurfaceSource, 'fs6')
			ZoomFactor = 2;
		else
			ZoomFactor = 1.25;
		end
end
%#$ZoomFactor = 2; % for inflated
%ZoomFactor = 1; % for pial
clf;
AX = zeros(2, 2);
Patches = zeros(2, 2);

PatchProps = {'EdgeColor', 'none', 'AmbientStrength', 0.8, 'SpecularStrength', 0.1, 'FaceColor', 'interp'};

if(~isempty(options.PatchProps))
	PatchProps = [PatchProps, options.PatchProps];
end

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
if ~verLessThan('matlab', 'R2016a')
	set(AX, 'Clipping', 'off');
end
%keyboard;
UpNudge = 0.2;
% disp('At start');
% for z = 1:numel(AX)
%     get(AX(z), 'Position')
% end
for z = 1:2
	AXPos = get(AX(2, z), 'Position');
	AXPos(2) = AXPos(2) + UpNudge;
	set(AX(2, z), 'Position', AXPos);
end
%keyboard;
if options.HorizontalCompact
    for z = 1:2
        AXPos = get(AX(z, 1), 'Position');
        AXPos(1) = AXPos(1) + HorizontalCompactNudge;
        set(AX(z, 1), 'Position', AXPos);

        AXPos = get(AX(z, 2), 'Position');
        AXPos(1) = AXPos(1) - HorizontalCompactNudge;
        set(AX(z, 2), 'Position', AXPos);
    end
end
%keyboard;
% disp('At start');
% for z = 1:numel(AX)
%     get(AX(z), 'Position')
% end
%keyboard;
% if ~verLessThan('matlab', 'R2016a')
% 	set(AX, 'Clipping', 'off');
% end
%keyboard;
DoPositionRectangles = false;

if DoPositionRectangles
	Colors = 'rgbm';
	for z = 1:numel(AX)
		AXPos = get(AX(z), 'Position');
		annotation('rectangle', AXPos, 'Color', Colors(z));
	end
end

TopLeftAXPos = get(AX(1, 1), 'Position');
TopRightAXPos = get(AX(1, 2), 'Position');
BottomLeftAXPos = get(AX(2, 1), 'Position');
BottomRightAXPos = get(AX(2, 2), 'Position');

if ~isempty(CMAPX) && ~options.NoLegend
	%keyboard;
	LegAXHeight = 0.05;
	LegAXWidth = 0.2;
	LegAX = axes('Position', [(TopLeftAXPos(1) + TopRightAXPos(1) + TopRightAXPos(3)) / 2 - LegAXWidth / 2, ...
		BottomLeftAXPos(2) - LegAXHeight * 1.5, ...
		LegAXWidth, ...
		LegAXHeight]);
	imshow(CMAPIMG, [], 'YData', (1:size(CMAPIMG, 2)) / 10, 'XData', 1:size(CMAPIMG, 2));
	axis xy on;

	set(gca, 'YTick', [], 'Color', options.BackgroundTextColour, 'XColor', options.BackgroundTextColour, 'XTick', []);

	LegendXTickIDX = interp1(CMAPX, 1:length(CMAPX), LegendXTick);

	%LegendXTickLabels = {'0', ['>= ' num2str(LargestEffectSize, '%.3f')]};
	for z = 1:length(LegendXTickIDX)
		text(LegendXTickIDX(z), -1, LegendXTickLabels{z}, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top', ...
			'Color', options.BackgroundTextColour, 'FontSize', 18);
	end
	if(~isempty(options.LegendLabel))
		text(0.5, -1.0, options.LegendLabel, 'Color', options.BackgroundTextColour, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top', 'FontSize', 24 * FontMult, 'FontName', 'Times', 'Units', 'normalized');
	end
end


if options.MedialLateralLabels && ~options.HorizontalCompact
% 	if ~verLessThan('matlab', 'R2017b')
% 		%disp('here');
%
% 	elseif ~verLessThan('matlab', 'R2016a')
% 		if ~options.UseShortLabels
% 			switch(computer)
% 				case 'GLNXA64'
% 					LeftX = -1.2;
% 					RightX = 2.21;
% 				otherwise
% 					LeftX = -1.75;
% 					RightX = 2.5;
% 			end
% 		else
% 			LeftX = -1;
% 			RightX = 2;
% 		end
%
% 	else
% 		LeftX = -0.2;
% 		RightX = 1.21;
% 	end

	%if ~options.UseShortLabels
	%	LeftX = -0.12;
	%	RightX = 0.02;
	if ~verLessThan('matlab', 'R2017b')
		%disp('here');
		LeftX = -0.0;
		RightX = 0.02;
	elseif ~verLessThan('matlab', 'R2016a')
		if ~options.UseShortLabels
			switch(computer)
				case 'GLNXA64'
					LeftX = -1.2;
					RightX = 2.21;
				otherwise
					LeftX = -1.75;
					RightX = 2.5;
			end
		else
			LeftX = -1;
			RightX = 2;
		end

	else
		LeftX = 0.01;
		RightX = -0.04;
	end

	T = {'EdgeColor', 'none', 'FontSize', 20 * FontMult, 'Color', options.BackgroundTextColour, 'Units', 'normalized', 'HorizontalAlignment', 'center'};
	%text( LeftX, 0.275,  'Medial', 'Parent', AX(1, 1), 'Rotation',  90, T{:});
	%text(RightX, 0.275, 'Lateral', 'Parent', AX(1, 2), 'Rotation', 270, T{:});

	TopLAXPos = get(AX(1, 1), 'Position');
	TopRAXPos = get(AX(1, 2), 'Position');
	BotLAXPos = get(AX(2, 1), 'Position');
	BotRAXPos = get(AX(2, 2), 'Position');

	%annotation('textbox', [0, BotLAXPos(2), TopLAXPos(1), TopLAXPos(2) + TopLAXPos(4) - BotLAXPos(2)], ...
	%	'String', 'Medial', T{:});
	T = {'HeadStyle','none','LineStyle', 'none', 'FontSize', 20 * FontMult, 'TextColor', options.BackgroundTextColour, 'HorizontalAlignment', 'center'};
	T = {'FontSize', 20 * FontMult, 'TextColor', options.BackgroundTextColour, 'HorizontalAlignment', 'center'};
    
    XX = [TopLAXPos(1) + LeftX / 2, TopLAXPos(1) + LeftX];
	YY = repmat((TopLAXPos(2) + TopLAXPos(4) + BotLAXPos(2)) / 2, 1, 2);
	annotation('textarrow', XX, YY, 'String', 'Medial', T{:}, 'TextRotation', 90);
	XX = [TopRAXPos(1) + TopRAXPos(3) + RightX, TopRAXPos(1)];
    YY = repmat((TopRAXPos(2) + TopRAXPos(4) + BotRAXPos(2)) / 2, 1, 2);
	annotation('textarrow', XX, YY, 'String', 'Lateral', T{:}, 'TextRotation', 270);

end

% now put the PA arrows and LH and RH labels

TopLeftAXPos = get(AX(1, 1), 'Position');
TopRightAXPos = get(AX(1, 2), 'Position');
BottomLeftAXPos = get(AX(2, 1), 'Position');
BottomRightAXPos = get(AX(2, 2), 'Position');

ArrowProps = {'Color', options.BackgroundTextColour, 'LineWidth', 2};
if options.HorizontalCompact
    TextFontSize = 28;
else
    TextFontSize = 20;
end
TextProps = {'Color', options.BackgroundTextColour, 'LineStyle', 'none', 'EdgeColor', options.LabelColour, 'VerticalAlignment', 'middle', 'FontSize', 28};

ArrowFigWidthProp = 0.35;
if(options.UseShortLabels)
	ArrowFigBotNudge = 0.075;
	ArrowFigTopNudge = 0.135;
else
	ArrowFigBotNudge = 0.1;
	ArrowFigTopNudge = 0.095;
end
AnnotHeight = 0.2;


annotation('textbox', 'Position', [(TopLeftAXPos(1) + TopRightAXPos(1) + TopRightAXPos(3)) / 2 - 0.01, ...
	TopLeftAXPos(2) + TopLeftAXPos(4) - ArrowFigTopNudge, ...
	0.02, ...
	AnnotHeight], 'String', 'LH', 'Color', options.LabelColour, TextProps{:}, 'HorizontalAlignment', 'center');
annotation('textbox', 'Position', [(BottomLeftAXPos(1) + BottomRightAXPos(1) + BottomRightAXPos(3)) / 2 - 0.01, ...
	BottomLeftAXPos(2) - ArrowFigBotNudge, ...
	0.02, ...
	AnnotHeight], 'String', 'RH', 'Color', options.LabelColour, TextProps{:}, 'HorizontalAlignment', 'center');

% top left
annotation('doublearrow', [TopLeftAXPos(1) + TopLeftAXPos(3) * ArrowFigWidthProp, TopLeftAXPos(1) + TopLeftAXPos(3) * (1 - ArrowFigWidthProp)], ...
	repmat(TopLeftAXPos(2) + TopLeftAXPos(4) - ArrowFigTopNudge + 0.1, 1, 2), ArrowProps{:});
annotation('textbox', [TopLeftAXPos(1), TopLeftAXPos(2) + TopLeftAXPos(4) - ArrowFigTopNudge, TopLeftAXPos(3) * ArrowFigWidthProp, AnnotHeight], ...
	'String', 'P', ...
	TextProps{:}, ...
	'HorizontalAlignment', 'right');
annotation('textbox', [TopLeftAXPos(1) + TopLeftAXPos(3) * (1 - ArrowFigWidthProp), TopLeftAXPos(2) + TopLeftAXPos(4) - ArrowFigTopNudge, TopLeftAXPos(3) * ArrowFigWidthProp, AnnotHeight], ...
	'String', 'A', ...
	TextProps{:}, ...
	'HorizontalAlignment', 'left');

% bottom left
annotation('doublearrow', [BottomLeftAXPos(1) + BottomLeftAXPos(3) * ArrowFigWidthProp, BottomLeftAXPos(1) + BottomLeftAXPos(3) * (1 - ArrowFigWidthProp)], ...
	repmat(BottomLeftAXPos(2), 1, 2) + 0.1 - ArrowFigBotNudge, ArrowProps{:});
annotation('textbox', [BottomLeftAXPos(1), BottomLeftAXPos(2) - ArrowFigBotNudge, BottomLeftAXPos(3) * ArrowFigWidthProp, AnnotHeight], ...
	'String', 'A', ...
	TextProps{:}, ...
	'HorizontalAlignment', 'right', ...
    'FontSize', 28);
annotation('textbox', [BottomLeftAXPos(1) + BottomLeftAXPos(3) * (1 - ArrowFigWidthProp), BottomLeftAXPos(2) - ArrowFigBotNudge, BottomLeftAXPos(3) * ArrowFigWidthProp, AnnotHeight], ...
	'String', 'P', ...
	TextProps{:}, ...
	'HorizontalAlignment', 'left');

% top right
annotation('doublearrow', [TopRightAXPos(1) + TopRightAXPos(3) * ArrowFigWidthProp, TopRightAXPos(1) + TopRightAXPos(3) * (1 - ArrowFigWidthProp)], ...
	repmat(TopRightAXPos(2) + TopRightAXPos(4) - ArrowFigTopNudge + 0.1, 1, 2), ArrowProps{:});
annotation('textbox', [TopRightAXPos(1), TopRightAXPos(2) + TopRightAXPos(4) - ArrowFigTopNudge, TopRightAXPos(3) * ArrowFigWidthProp, AnnotHeight], ...
	'String', 'A', ...
	TextProps{:}, ...
	'HorizontalAlignment', 'right');
annotation('textbox', [TopRightAXPos(1) + TopRightAXPos(3) * (1 - ArrowFigWidthProp), TopRightAXPos(2) + TopRightAXPos(4) - ArrowFigTopNudge, TopRightAXPos(3) * ArrowFigWidthProp, AnnotHeight], ...
	'String', 'P', ...
	TextProps{:}, ...
	'HorizontalAlignment', 'left');

% bottom right
annotation('doublearrow', [BottomRightAXPos(1) + BottomRightAXPos(3) * ArrowFigWidthProp, BottomRightAXPos(1) + BottomRightAXPos(3) * (1 - ArrowFigWidthProp)], ...
	repmat(BottomRightAXPos(2) + 0.1 - ArrowFigBotNudge, 1, 2), ArrowProps{:});
annotation('textbox', [BottomRightAXPos(1), BottomRightAXPos(2) - ArrowFigBotNudge, BottomRightAXPos(3) * ArrowFigWidthProp, AnnotHeight], ...
	'String', 'P', ...
	TextProps{:}, ...
	'HorizontalAlignment', 'right');
annotation('textbox', [BottomRightAXPos(1) + BottomRightAXPos(3) * (1 - ArrowFigWidthProp), BottomRightAXPos(2) - ArrowFigBotNudge, BottomRightAXPos(3) * ArrowFigWidthProp, AnnotHeight], ...
	'String', 'A', ...
	TextProps{:}, ...
	'HorizontalAlignment', 'left');
%NoLabels = false;

% title
if(~isempty(options.MainTitle))
	T = 0.45;
	annotation('textbox', 'Position', [(TopLeftAXPos(1) + TopRightAXPos(1) + TopRightAXPos(3)) / 2 - T / 2, ...
		TopLeftAXPos(2) + TopLeftAXPos(4), ...
		T, ...
		1 - (TopLeftAXPos(2) + TopLeftAXPos(4))], ...
		'String', options.MainTitle, ...
		'Color', options.BackgroundTextColour, 'HorizontalAlignment', 'center', 'FontSize', 18 * FontMult, 'VerticalAlignment', 'middle', 'EdgeColor', 'none');
end

if(~options.NoLabels)
	if(ismember(lower(FreesurferSeedType), {'aparc', 'dkt'}))
		if(iscell(ShortRegionLabels))
			FontWeight = 'bold';
			FontSize = 10 * FontMult;
		else
			switch(computer)
					case {'PCWIN64', 'GLNXA64'}
						FontWeight = 'normal';
						FontSize = 8 * FontMult;
					otherwise
						FontWeight = 'bold';
						FontSize = 10 * FontMult;
			end
		end

		LabelTextBoxPropsDone = {'FitBoxToText', 'off', ...
			'Margin', 2, ...
			'Color', options.LabelColour, 'EdgeColor', 'none', 'LineStyle', 'none', ...
			'VerticalAlignment', 'middle', ...
			'HorizontalAlignment', 'center', ...
			'FontWeight', FontWeight, ...
			'FontSize', FontSize};

		ArrowProps = {'LineWidth', 2, 'Color', 'w'};

		if (verLessThan('matlab', 'r2017a'))
			RectProps = {'FaceColor', 'flat', 'EdgeColor', options.LabelColour, 'LineWidth', 2};
		else
			RectProps = {'FaceColor', 'none', 'EdgeColor', options.LabelColour, 'LineWidth', 2};
		end
		% Create textbox
		%LabelTextBoxPropsDone = [LabelTextBoxProps {'Color', options.LabelColour}];
		%RectProps
		switch(options.SurfaceSource)
			case 'fs6'
				freesurfer_statsurf_textboxes_func = @freesurfer_statsurf_textboxes_fs6;
			case 'mcribs'
				freesurfer_statsurf_textboxes_func = @freesurfer_statsurf_textboxes_mcribs;
		end
		[TextBoxes, Arrows, Rectangles] = freesurfer_statsurf_textboxes_func(FreesurferSeedType);
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
								% the centroid of the textboxes

								TextBoxesCentroid = zeros(NumTextBoxes, 2);
								for CurTextBox = 1:NumTextBoxes
									PositionIDX = find(strcmp('Position', TextBoxes.(Hemi).(F{CurField}){CurTextBox}(1:2:end))); % find 'Position' in the parameters, which are in the odd indices
									PositionIDX = (PositionIDX - 1) * 2 + 1; % so find the original index that it is in
									TextBoxPosition = TextBoxes.(Hemi).(F{CurField}){CurTextBox}{PositionIDX + 1};
									TextBoxesCentroid(CurTextBox, :) = [TextBoxPosition(1) + TextBoxPosition(3) / 2, TextBoxPosition(2) + TextBoxPosition(4) / 2];
								end
								TextBoxesCentroid = mean(TextBoxesCentroid, 1);
                            end
                            if options.HorizontalCompact
                                if TextBoxesCentroid(1) < 0.5
                                    TextBoxesCentroid(1) = TextBoxesCentroid(1) + HorizontalCompactNudge;
                                else
                                    TextBoxesCentroid(1) = TextBoxesCentroid(1) - HorizontalCompactNudge;
                                end
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

% disp('At end');
% for z = 1:numel(AX)
%     get(AX(z), 'Position')
% end

%keyboard;
