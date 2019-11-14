function [AX, LegAX] = freesurfer_statsurf_rsq(RSQ, RSQMask, FreesurferSeedType, varargin)

% freesurfer_statsurf_rsq(RSQ, RSQMask, FreesurferSeedType, param1, val1, param2, val2, ...)
% 
% DESCRIPTION
%	Plots arbitrary scalar on Freesurfer surfaces. The aparc and aparc.a2009s
%	schemes are supported. The RSQ and RSQMask are 2 element cell
%	arrays with RSQ{1} and RSQMask{1} giving the d-RSQ and d-value masks for
%	the left hemisphere and RSQ{2} and RSQMask{2} giving the d-RSQ and d-value masks for
%	the right hemisphere. The d-value masks are logical arrays that determine which regions should
%   have their d-RSQ plotted. FreesurferSeedType is a string that is the parcellation scheme,
%	see supported values below. The seed type determines the number
%	of elements required in the PRSQ and RSQMask vectors, see NOTES
%	below.
% PARAMETERS
%	RSQ (cell array) [2]: {LH RSQ, RH RSQ}
%	RSQMask (cell array) [2]: {LH RSQ, RH RSQ}
%   FreesurferSeedType (string): supported seed types are:
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
%	'UseShortLabels' (logical): whether to use abbreviated aparc
%	labels on the regions themselves rather than use boxes and arrows
%	'NoLabels' (logical): whether to not use labels at all
%	'MedialLateralLabels' (logical): whether to place 'Medial' and
%	'Lateral' on the left and right of the figure, respectively
%	'ScalarName' (string): the name of the variable. Used to annotated the
%	legend. '\itr^2' by default
%	'PatchProps' (cell): NAME/VALUE pairs of patch properties appended to defaults. See "Patch Properties" in "doc patch".
%   'BackgroundNoCurv' (logical): affects "background" or non-significant vertices, their colouring:
%   if true, use solid grey
%   if false (default), use the average surface curvature
% NOTES
% Each element of the vectors in PValues and TValues point to a structure
% used in the parcellation scheme (FreesurferSeedType). The labels are
% listed in text files as follows:
% FreesurferSeedType = 'aparc': seedtype_aparc.txt
% FreesurferSeedType = 'dkt': seedtype_dkt.txt
% FreesurferSeedType = aparc.a2009s: seedtype_aparc.a2009s.txt
% FreesurferSeedType = voneconomo: seedtype_voneconomo.txt

[options, ...
NonSignificantColour, CMAPSize, ... 
FSAverageV, FSAverageF, FSAverageCurv, ValueVertexIDX, ~, ...
OtherArgs] = freesurfer_statsurf_checkargs({RSQ, RSQMask}, FreesurferSeedType, varargin);

options.ScalarName = '\itr^2';

for z = 1:2:length(OtherArgs)
	if length(OtherArgs) >= z + 1
		if(~ischar(OtherArgs{z}))
			disp('Parameter not a string, ignoring');
		else
			switch(lower(OtherArgs{z}))
				case 'scalarname'
					options.ScalarName = OtherArgs{z + 1};
				otherwise
					disp(['Unsupported optional option (ignored): ' OtherArgs{z}]);
			end
		end
	else
		disp('Last parameter had no value associated with it, ignoring');
	end
end

if isempty(RSQMask)
	RSQMask = cellfun(@(x) (true(size(x))), RSQ, 'UniformOutput', false);
end

CMAP = jet(CMAPSize);
CMAPX = linspace(0, 1, 256);
CMAPIMG = permute(repmat(reshape(CMAP(1:end - 2, :), [size(CMAP, 1) - 2, 1, 3]), [1, 50, 1]), [2 1 3]);

Hemis = {'lh', 'rh'};

FaceVertexCData = cell(1, length(Hemis));
% make the colorup data for the surfaces
for HemiIDX = 1:length(Hemis)
	
	CurData = RSQ{HemiIDX};
	CurData(~RSQMask{HemiIDX}) = NaN;
	%CurData = rand(size(PRSQ{HemiIDX})) .* 0.05 .* sign(rand(size(TRSQ{HemiIDX})) - 0.5);
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

options.LegendLabel = options.ScalarName;
LegendXTick = [0 1];
LegendXTickLabels = cellstr(num2str([min(CMAPX), max(CMAPX)]', '%.2f'));
if ~options.BackgroundNoCurv
    FaceVertexCData = freesurfer_statsurf_nonsigwithcurv(FaceVertexCData, FSAverageCurv, NonSignificantColour);
end


freesurfer_statsurf_plot(FSAverageV, FSAverageF, FaceVertexCData, FreesurferSeedType, ...
	RSQMask, CMAPX, CMAPIMG, LegendXTick, LegendXTickLabels, options);
