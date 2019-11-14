function [AX, LegAX] = freesurfer_statsurf_fsrgb(ValuesMask, FreesurferSeedType, varargin)

% freesurfer_statsurf_fsrgb(ValuesMask, FreesurferSeedType, param1, val1, param2, val2, ...)
% 
% DESCRIPTION
%	Highlights regions selected in ValuesMask with the Freesurfer specified
%	RGB colours (see FreeSurferColorLUT.txt).
%   FreesurferSeedType is a string that should be
%	either 'aparc', 'aparc.a2009s', 'dkt'. The seed type determines the number
%	of elements required in the ValuesMask vectors, see NOTES below.
% PARAMETERS
%	ValuesMask (cell array) [2]: {LH mask, RH mask}
%	FreesurferSeedType (string): supported seed types are:
% 'aparc', Desikan-Killiany et al.
% 'aparc.a2009s', Destrieux et al.
% 'dkt' Desikan-Killiany-Tourville et al.
% PARAMETER/VALUE PAIRS
%	'GroupLabels' (cell array of strings) [2]: the two group labels used to
%	annotate the legend, the groups are called 'Group 1' and 'Group 2' if
%	this parameter is not given
%	'MainTitle' (string): optional title to be placed at the top of the
%	middle of the plot, if [] this parameter is ignored
%	'UseShortLabels' (logical): whether to use abbreviated aparc, dkt
%	labels on the regions themselves rather than use boxes and arrows,
%	default = false
%	'NoLabels' (logical) : true disables annotation of regions, default = false
%	'MedialLateralLabels' (logical): whether to place 'Medial' and
%	'Lateral' on the left and right of the figure, respectively
%	'SurfType' (string): 'white', 'pial', or 'inflated' will use that
%	surface for display. 'inflated' by default. Only 'inflated' is annotated.
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

Values = {ValuesMask};

[options, ...
NonSignificantColour, ~, ... 
FSAverageV, FSAverageF, FSAverageCurv, ValueVertexIDX, FaceVertexCData, ...
~] = freesurfer_statsurf_checkargs(Values, FreesurferSeedType, varargin);

if ~isempty(ValuesMask)
	for HemiIDX = 1:2
		I = ~ismember(ValueVertexIDX{HemiIDX}, find(ValuesMask{HemiIDX}));
		if any(I)
			FaceVertexCData{HemiIDX}(I, :) = repmat(NonSignificantColour, sum(I), 1);
		end
	end
else
	for z = 1:length(FaceVertexCData)
		M = find(ValueVertexIDX{z} == 0);
		FaceVertexCData{z}(M, :) = repmat(NonSignificantColour, length(M), 1);
	end
end

%ValuesMask = cellfun(@(x) (x <= 0.05), PValues, 'UniformOutput', false);

%freesurfer_statsurf_plot(FSAverageV, FSAverageF, FaceVertexCData,  FreesurferSeedType, ...
%	ValuesMask, [], [], MainTitle, SurfType, [], [], [], UseShortLabels, NoLabels, NoLegend, MedialLateralLabels);
if ~options.BackgroundNoCurv
    FaceVertexCData = freesurfer_statsurf_nonsigwithcurv(FaceVertexCData, FSAverageCurv, NonSignificantColour);
end

if ~strcmp(options.SurfType, 'inflated')
	options.NoLabels = true;
end

freesurfer_statsurf_plot(FSAverageV, FSAverageF, FaceVertexCData, FreesurferSeedType, ...
	ValuesMask, [], [], [], [], options);
