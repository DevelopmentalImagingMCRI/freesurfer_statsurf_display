function [AX, LegAX] = freesurfer_statsurf_scalar(Values, ValuesMask, FreesurferSeedType, varargin)

% freesurfer_statsurf_scalar(Values, ValuesMask, FreesurferSeedType, param1, val1, param2, val2, ...)
% 
% DESCRIPTION
%	Plots arbitrary scalar on Freesurfer surfaces for each region of the parcellation scheme specified in FreesurferSeedType.
%   The aparc and aparc.a2009s, dkt schemes are supported. The Values and ValuesMask are 2 element cell
%	arrays with Values{1} and ValuesMask{1} giving the masks for
%	the left hemisphere and Values{2} and ValuesMask{2} giving the masks for
%	the right hemisphere. The value masks are logical arrays that determine which regions should
%   have their values plotted. FreesurferSeedType is a string that is the parcellation scheme,
%	see supported values below. The seed type determines the number
%	of elements required in the Values and ValuesMask vectors, see NOTES
%	below.
%
% PARAMETERS
%	Values (cell array) [2]: {LH values, RH values}
%	ValuesMask (cell array) [2]: {LH values, RH values}
% FreesurferSeedType (string): supported seed types are:
% 'aparc', Desikan-Killiany et al.
% 'aparc.a2009s', Destrieux et al.
% 'dkt' Desikan-Killiany-Tourville et al.
% 'voneconomo', Von Econoomo and Koskinas
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
%	'ValueLimits' [2]: ValueLimits(1) and ValueLimits(2) are the lower and
%	upper limits on the values to be plotted, much like CLim in imagesc.
%	'ScalarName' (string): the name of the variable. Used to annotated the
%	legend.
% NOTES
% Each element of the vectors in PValues and TValues point to a structure
% used in the parcellation scheme (FreesurferSeedType). The labels are
% listed in text files as follows:
% FreesurferSeedType = 'aparc': seedtype_aparc.txt
% FreesurferSeedType = 'dkt': seedtype_dkt.txt
% FreesurferSeedType = aparc.a2009s: seedtype_aparc.a2009s.txt
% FreesurferSeedType = voneconomo: seedtype_voneconomo.txt

[GroupLabels, ...
MainTitle, ...
MedialLateralLabels, ...
NonSignificantColour, ...
CMAPSize, NoLabels, NoLegend, UseShortLabels, SurfType, ...
FSAverageV, FSAverageF, ValueVertexIDX, ~, ...
OtherArgs] = freesurfer_statsurf_checkargs({Values, ValuesMask}, FreesurferSeedType, varargin);

ValueLimits = [];
ScalarName = [];

for z = 1:2:length(OtherArgs)
	if length(OtherArgs) >= z + 1
		if(~ischar(OtherArgs{z}))
			disp('Parameter not a string, ignoring');
		else
			switch(lower(OtherArgs{z}))
				case 'scalarname'
					ScalarName = OtherArgs{z + 1};
				case 'valuelimits'
					ValueLimits = OtherArgs{z + 1};
				otherwise
					disp(['Unsupported optional option (ignored): ' OtherArgs{z}]);
			end
		end
	else
		disp('Last parameter had no value associated with it, ignoring');
	end
end

if isempty(ValuesMask)
	ValuesMask = cellfun(@(x) (true(size(x))), Values, 'UniformOutput', false);
end


if ~isempty(ValueLimits)
	CMAP = jet(CMAPSize);
	CMAPX = linspace(ValueLimits(1), ValueLimits(2), CMAPSize);
else
	AllValues = cat(2, Values{:});
	if(all(AllValues(:) > 0) || all(AllValues(:) < 0))
		CMAP = jet(CMAPSize);
		CMAPX = linspace(min(AllValues(:)), max(AllValues(:)), CMAPSize);
	else
		[CMAP, ~, CMAPX] = bluewhitered_image(CMAPSize, AllValues);
	end
end
%CMAPIMG = permute(repmat(reshape(CMAP(1:end - 2, :), [size(CMAP, 1) - 2, 1, 3]), [1, 50, 1]), [2 1 3]);
CMAPIMG = permute(repmat(reshape(CMAP, [size(CMAP, 1), 1, 3]), [1, 50, 1]), [2 1 3]);

Hemis = {'lh', 'rh'};

FaceVertexCData = cell(1, length(Hemis));
% make the colorup data for the surfaces
for HemiIDX = 1:length(Hemis)
	
	CurData = Values{HemiIDX};
	CurData(~ValuesMask{HemiIDX}) = NaN;
	%CurData = rand(size(PValues{HemiIDX})) .* 0.05 .* sign(rand(size(TValues{HemiIDX})) - 0.5);
	%IDX(IDX == 0) = 1;
	C = double(ValueVertexIDX{HemiIDX});
	C(ValueVertexIDX{HemiIDX} > 0) = CurData(ValueVertexIDX{HemiIDX}(ValueVertexIDX{HemiIDX} > 0));
	% IDX == 0 is an unknown label, make this P = 1
	C(ValueVertexIDX{HemiIDX} == 0) = NaN;
	
	FaceVertexCData{HemiIDX} = repmat(NonSignificantColour, length(C), 1);
	
	M = ~isnan(C);
	for z = 1:3
		%keyboard;
		FaceVertexCData{HemiIDX}(M, z) = interp1(CMAPX, CMAP(:, z), C(M), 'linear');
	end
end

if ~isempty(ValueLimits)
	%XTickIDX = [1, CMAPSize];
	T = cellstr(num2str([min(CMAPX), max(CMAPX)]', '%.2f'));
	LegendLabel = ScalarName;
	LegendXTick = ValueLimits;
	LegendXTickLabels = T;
else
	AllValues = cat(2, Values{:});
	if(all(AllValues(:) > 0) || all(AllValues(:) < 0))
		LegendXTick = [min(CMAPX), max(CMAPX)]';
        LegendXTickLabels = cellstr(num2str(LegendXTick, '%.2f'));
    else
        LegendXTick = [min(AllValues(:)), 0, max(AllValues(:))]';
		LegendXTickLabels = cellstr(num2str(LegendXTick, '%.2f'));
	end
	LegendLabel = ScalarName;
	LegendXTickLabels = cellstr(num2str(LegendXTick, '%.2f'));

end
% for z = 1:length(XTickIDX)
% 	text(XTickIDX(z), -1, T{z}, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top', ...
% 		'Color', 'w');
% end
%LegendXTickLabels = {{'0.05',  ['(' GroupLabels{1} ' > ' GroupLabels{2} ')']}, '0', {'0.05', ['(' GroupLabels{1} ' < ' GroupLabels{2} ')']}};
%keyboard;
LabelColour = 'm';

freesurfer_statsurf_plot(FSAverageV, FSAverageF, FaceVertexCData,  FreesurferSeedType, ...
	ValuesMask, CMAPX, CMAPIMG, MainTitle, SurfType, LegendLabel, LegendXTick, LegendXTickLabels, UseShortLabels, NoLabels, NoLegend, MedialLateralLabels, LabelColour);
%keyboard;