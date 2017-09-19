function [AX, LegAX] = freesurfer_statsurf_p(PValues, TValues, FreesurferSeedType, varargin)

 % DESCRIPTION
%	Plots p-values on Freesurfer surfaces. The aparc and aparc.a2009s
%	schemes are supported. The PValues and TValues are 2 element cell
%	arrays with PValues{1} and TValues{1} giving the p- and t-values for
%	the left hemisphere and PValues{2} and TValues{2} giving the p- and t-values for
%	the right hemisphere. Only the sign of the TValues elements are used, such that 
%	the sign of each TValues element determines which group had a greater
%	mean. FreesurferSeedType is a string that is the parcellation scheme,
%	see supported values below. The seed type determines the number
%	of elements required in the PValues and TValues vectors, see NOTES
%	below.
%	If FreesurferSeedType = 'aparc' regions that have p < 0.05 will be
%	annotated automatically.
%
% PARAMETERS
%	PValues (cell array) [2]: {LH p-values, RH p-values}
%	TValues (cell array) [2]: {LH t-values, RH t-values}
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
% NOTES
% Each element of the vectors in PValues and TValues point to a structure
% used in the parcellation scheme (FreesurferSeedType). The labels are
% listed in text files as follows:
% FreesurferSeedType = 'aparc': seedtype_aparc.txt
% FreesurferSeedType = 'dkt': seedtype_dkt.txt
% FreesurferSeedType = aparc.a2009s: seedtype_aparc.a2009s.txt
% FreesurferSeedType = voneconomo: seedtype_voneconomo.txt

Values = {PValues, TValues};

[options, ...
NonSignificantColour, CMAPSize, ... 
FSAverageV, FSAverageF, ValueVertexIDX, RGB, ...
OtherArgs] = freesurfer_statsurf_checkargs(Values, FreesurferSeedType, varargin);

options.GroupLabels = {'Group 1', 'Group 2'};

for z = 1:2:length(OtherArgs)
	if length(OtherArgs) >= z + 1
		if(~ischar(OtherArgs{z}))
			disp('Parameter not a string, ignoring');
		else
			switch(lower(OtherArgs{z}))
				case 'grouplabels'
					options.GroupLabels = OtherArgs{z + 1};
				otherwise
					disp(['Unsupported optional option (ignored): ' OtherArgs{z}]);
			end
		end
	else
		disp('Last parameter had no value associated with it, ignoring');
	end
end

if(~isempty(options.GroupLabels))
	if(~iscellstr(options.GroupLabels) || numel(options.GroupLabels) ~= 2)
		error('GroupLabels must be a 2 element cell array of strings');
	end
end

%keyboard;

NegCMAP = cool(CMAPSize);
PosCMAP = hot(CMAPSize);
% crop so that we go from red to yellow so that we dont have white or black
PosCMAPIDX = 67:200;
T = zeros(size(PosCMAP));
for z = 1:3
	T(:, z) = interp1(PosCMAPIDX, PosCMAP(PosCMAPIDX, z), linspace(min(PosCMAPIDX), max(PosCMAPIDX), CMAPSize));
end
PosCMAP = T;
clear T PosCMAPIDX z;
PosCMAP = PosCMAP / 2;
NegCMAP = NegCMAP / 2;
%NonSignificantColour = repmat(0.25, 1, 3);

CMAPX = [-1, -0.05 - eps, linspace(-0.05, -1 / CMAPSize, CMAPSize), 0, linspace(1 / CMAPSize, 0.05, CMAPSize), 0.05 + eps, 1];
CMAP = [NonSignificantColour; NonSignificantColour; NegCMAP; PosCMAP(1, :); PosCMAP; NonSignificantColour; NonSignificantColour];

Hemis = {'lh', 'rh'};

FaceVertexCData = cell(1, length(Hemis));
% make the colorup data for the surfaces
for HemiIDX = 1:length(Hemis)
	if(~isempty(TValues))
		S = sign(TValues{HemiIDX});
		S = S + double(TValues{HemiIDX} == 0); % if the T-value was zero (non-significant) this fixes the issue of those regions being displayed as p = 0
		CurData = PValues{HemiIDX} .* S;
	else
		CurData = PValues{HemiIDX};
	end
	
	clear S;
	%CurData = rand(size(PValues{HemiIDX})) .* 0.05 .* sign(rand(size(TValues{HemiIDX})) - 0.5);
	%IDX(IDX == 0) = 1;
	C = double(ValueVertexIDX{HemiIDX});
	%HemiIDX
	C(ValueVertexIDX{HemiIDX} > 0) = CurData(ValueVertexIDX{HemiIDX}(ValueVertexIDX{HemiIDX} > 0));
	% make unknown structures have non-significant p-values
	C(ValueVertexIDX{HemiIDX} == 0) = 1;
	% if structures have no p-values, then they will have NaN, make their
	% values non-significant
	C(isnan(C)) = 1;
	
	M = abs(C > 1);
	if(any(M))
		disp('Warning, p-values outside 0 <= p <= 1, making those p = 1');
		C(M) = 1;
	end

	FaceVertexCData{HemiIDX} = zeros(length(C), 3);
	M = sign(C) < 0;
	if(any(M))
		CurCMAPX = [-1, -0.05 - eps, linspace(-0.05, -1 / CMAPSize, CMAPSize), 0];
		CurCMAP = [NonSignificantColour; NonSignificantColour; NegCMAP; NegCMAP(end, :)];

		for z = 1:3
			FaceVertexCData{HemiIDX}(M, z) = interp1(CurCMAPX, CurCMAP(:, z), C(M), 'linear');
		end
	end
	M = sign(C) >= 0;
	if(any(M))
		CurCMAPX = [0, linspace(1 / CMAPSize, 0.05, CMAPSize), 0.05 + eps, 1];
		CurCMAP = [PosCMAP(1, :); PosCMAP; NonSignificantColour; NonSignificantColour];
		%keyboard;
		for z = 1:3
			FaceVertexCData{HemiIDX}(M, z) = interp1(CurCMAPX, CurCMAP(:, z), C(M), 'linear');
		end
	end
end

options.LegendLabel = '\itp';
if(~isempty(TValues))
	LegendXTick = [-0.05, 0, 0.05];
	LegendXTickLabels = {{'0.05',  ['(' options.GroupLabels{1} ' > ' options.GroupLabels{2} ')']}, '0', {'0.05', ['(' options.GroupLabels{1} ' < ' options.GroupLabels{2} ')']}};
else
	LegendXTick = [0, 0.05];
	LegendXTickLabels = {'0', '0.05'};
	CMAPX = [0, linspace(1 / CMAPSize, 0.05, CMAPSize), 0.05 + eps, 1];
	CMAP = [PosCMAP(1, :); PosCMAP; NonSignificantColour; NonSignificantColour];
end
CMAPIMG = permute(repmat(reshape(CMAP, [size(CMAP, 1), 1, 3]), [1, 50, 1]), [2 1 3]);

ValuesMask = cellfun(@(x) (x <= 0.05), PValues, 'UniformOutput', false);
freesurfer_statsurf_plot(FSAverageV, FSAverageF, FaceVertexCData, FreesurferSeedType, ...
	ValuesMask, CMAPX, CMAPIMG, LegendXTick, LegendXTickLabels, options);

%freesurfer_statsurf_plot(FSAverageV, FSAverageF, FaceVertexCData,  FreesurferSeedType, ...
%	ValuesMask, CMAPX, CMAPIMG, MainTitle, SurfType, LegendLabel, LegendXTick, LegendXTickLabels, UseShortLabels, NoLabels, NoLegend, MedialLateralLabels);