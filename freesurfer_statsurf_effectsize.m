function [AX, LegAX] = freesurfer_statsurf_effectsize(EffectSizes, EffectSizesMask, FreesurferSeedType, varargin)

% freesurfer_statsurf_effectsize(EffectSizes, EffectSizesMask, FreesurferSeedType, param1, val1, param2, val2, ...)
% 
% DESCRIPTION
%	Plots effect size values for regions specified in the seed type
%	(FreeSurferSeedType); the aparc, aparc.a2009s and dkt schemes are supported. The EffectSizes and EffectSizesMask are 2 element cell
%	arrays with EffectSizes{1} and EffectSizesMask{1} giving the effect size values and masks for
%	the left hemisphere and EffectSizes{2} and EffectSizesMask{2} giving the effect size values and masks for
%	the right hemisphere. The effect size masks are logical arrays that determine which regions should
%   have their effect sizes plotted. FreesurferSeedType is a string that should be
%	either 'aparc', 'aparc.a2009s', 'dkt'. The seed type determines the number
%	of elements required in the EffectSizes and EffectSizesMask vectors, see NOTES
%	below.
% PARAMETERS
%	EffectSizes (cell array) [2]: {LH effect sizes, RH effect sizes}
%	EffectSizesMask (cell array) [2]: {LH effect size masks, RH effect size masks}
%   FreesurferSeedType (string): supported seed types are:
% 'aparc', Desikan-Killiany et al.
% 'aparc.a2009s', Destrieux et al.
% 'dkt' Desikan-Killiany-Tourville et al.
% PARAMETER/VALUE PAIRS
%	'GroupLabels' (cell array of strings) [2]: the two group labels used to
%	annotate the legend, the groups are called 'Group 1' and 'Group 2' if
%	this parameter is not given
%	'MainTitle' (string): optional title to be placed at the top of the
%	middle of the plot, if [] this parameter is ignored
%	'ShortAPARCLabels' (logical): whether to use abbreviated aparc
%	labels on the regions themselves rather than use boxes and arrows
%	'NoLabels' (logical): whether to not use labels at all
%	'MedialLateralLabels' (logical): whether to place 'Medial' and
%	'Lateral' on the left and right of the figure, respectively
%	'ScalarName' (string): the name of the effect. Used to annotated the
%	legend. '\itd' by default for Cohen's d.
%	'SmallMediumLargeEffectSize' [3]: SmallMediumLargeEffectSize(1) small,
%	SmallMediumLargeEffectSize(2) medium, SmallMediumLargeEffectSize(3)
%	large effect sizes
%	'LargestEffectSize' [1]: the largest effect size to plot, larger values
%	will be clamped. 1.5 by default
% NOTES
% Each element of the vectors in PValues and TValues point to a structure
% used in the parcellation scheme (FreesurferSeedType). The labels are
% listed in text files as follows:
% FreesurferSeedType = 'aparc': seedtype_aparc.txt
% FreesurferSeedType = 'dkt': seedtype_dkt.txt
% FreesurferSeedType = aparc.a2009s: seedtype_aparc.a2009s.txt

[GroupLabels, ...
MainTitle, ...
MedialLateralLabels, ...
NonSignificantColour, ...
CMAPSize, NoLabels, NoLegend, UseShortLabels, SurfType, ...
FSAverageV, FSAverageF, ValueVertexIDX, ~, ...
OtherArgs] = freesurfer_statsurf_checkargs({EffectSizes, EffectSizesMask}, FreesurferSeedType, varargin);

LargestEffectSize = 1.5;
LegendLabel = '\itd';
SmallMediumLargeEffectSize = [0.2, 0.5, 0.8];

for z = 1:2:length(OtherArgs)
	if length(OtherArgs) >= z + 1
		if(~ischar(OtherArgs{z}))
			disp('Parameter not a string, ignoring');
		else
			switch(lower(OtherArgs{z}))
				case 'largesteffectsize'
					LargestEffectSize = OtherArgs{z + 1};
				case 'legendlabel'
					LegendLabel = OtherArgs{z + 1};
				case 'smallmediumlargeeffectsize'
					SmallMediumLargeEffectSize = OtherArgs{z + 1};
				otherwise
					disp(['Unsupported optional option (ignored): ' OtherArgs{z}]);
			end
		end
	else
		disp('Last parameter had no value associated with it, ignoring');
	end
end

if isempty(EffectSizesMask)
	EffectSizesMask = cellfun(@(x) (true(size(x))), EffectSizes, 'UniformOutput', false);
end

CMAPX = linspace(0, LargestEffectSize, CMAPSize);
CMAP = jet(numel(CMAPX)) / 2;

CMAPIMG = permute(repmat(reshape(CMAP, [size(CMAP, 1), 1, 3]), [1, 50, 1]), [2 1 3]);

Hemis = {'lh', 'rh'};

FaceVertexCData = cell(1, length(Hemis));
for HemiIDX = 1:length(Hemis)

	CurData = min(EffectSizes{HemiIDX}, LargestEffectSize);
	CurData(~EffectSizesMask{HemiIDX}) = NaN;
	C = double(ValueVertexIDX{HemiIDX});
	C(ValueVertexIDX{HemiIDX} > 0) = CurData(ValueVertexIDX{HemiIDX}(ValueVertexIDX{HemiIDX} > 0));
	% IDX == 0 is an unknown label, make this P = 1
	C(ValueVertexIDX{HemiIDX} == 0) = NaN;
	
	FaceVertexCData{HemiIDX} = repmat(NonSignificantColour, length(C), 1);
	
	M = ~isnan(C);
	
	for z = 1:3
		FaceVertexCData{HemiIDX}(M, z) = interp1(CMAPX(:), CMAP(:, z), C(M), 'linear');
	end
end

if(~isempty(SmallMediumLargeEffectSize))
	LegendXTick = [0, SmallMediumLargeEffectSize(:)', LargestEffectSize];
	LegendXTickLabels = {'0', {num2str(SmallMediumLargeEffectSize(1), '%.1f'), 'S'}, {num2str(SmallMediumLargeEffectSize(2), '%.1f'), 'M'}, {num2str(SmallMediumLargeEffectSize(3), '%.1f'), 'L'}, ['\geq' num2str(LargestEffectSize, '%.1f')]};
else
	%LegendLabel = '\itp';
	LegendXTick = [0, LargestEffectSize];
	LegendXTickLabels = {'0', num2str(LargestEffectSize, '%.1f')};
end

freesurfer_statsurf_plot(FSAverageV, FSAverageF, FaceVertexCData,  FreesurferSeedType, ...
	EffectSizesMask, CMAPX, CMAPIMG, MainTitle, SurfType, LegendLabel, LegendXTick, LegendXTickLabels, UseShortLabels, NoLabels, NoLegend, MedialLateralLabels);
%keyboard;