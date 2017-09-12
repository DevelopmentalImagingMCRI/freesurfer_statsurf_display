function [GroupLabels, ...
MainTitle, ...
MedialLateralLabels, ...
NonSignificantColour, ...
CMAPSize, NoLabels, NoLegend, UseShortLabels, SurfType, ...
FSAverageV, FSAverageF, ValueVertexIDX, RGB, ... % from loadsurfaces
OtherArgs] = freesurfer_statsurf_checkargs(Values, FreesurferSeedType, Args)

GroupLabels = {'Group 1', 'Group 2'};
MainTitle = [];
UseShortLabels = false;
NoLabels = false;
NoLegend = false;
SurfType = 'inflated';
MedialLateralLabels = true;

OtherArgs = {};

for z = 1:2:length(Args)
	if length(Args) >= z + 1
		if(~ischar(Args{z}))
			disp('Parameter not a string, ignoring');
		else
			switch(lower(Args{z}))
				case 'grouplabels'
					GroupLabels = Args{z + 1};
				case 'maintitle'
					MainTitle = Args{z + 1};
				case {'shortlabels', 'useshortlabels'}
					UseShortLabels = Args{z + 1};
				case 'nolabels'
					NoLabels = Args{z + 1};
				case 'nolegend'
					NoLegend = Args{z + 1};
				case 'surftype'
					SurfType = Args{z + 1};
				case {'medlatlabels', 'mediallaterallabels'}
					MedialLateralLabels = Args{z + 1};
				otherwise
					OtherArgs = [OtherArgs; Args{z}; Args{z + 1}];
			end
		end
	else
		disp('Last parameter had no value associated with it, ignoring');
	end
end

FreesurferSeedTypes = {'aparc', 'aparc.a2009s', 'destreiux', 'dkt'};

if ~ismember(FreesurferSeedType, FreesurferSeedTypes)
	error('Unsupported seed type');
end

if(~isempty(GroupLabels))
	if(~iscellstr(GroupLabels) || numel(GroupLabels) ~= 2)
		error('GroupLabels must be a 2 element cell array of strings');
	end
end

if(~iscell(Values))
	error('Values must be a cell array');
else
	for z = 1:length(Values)
		
		if(isempty(Values{z}))
			continue;
		end
		
		if(~iscell(Values{z}))
			error('Values must be a cell array');
		end
		if(numel(Values{z}) ~= 2)
			error('Values must have 2 elements, 1 for each hemisphere');
		end
		
		L = cellfun(@numel, Values{z});
		
		switch(lower(FreesurferSeedType))
			case 'aparc'
				if(any(L ~= 34))
					error('Number of elements must be 34');
				end
			case {'aparc.a2009s', 'destrieux'}
				if(any(L ~= 75))
					error('Number of elements must be 75');
				end
			case 'dkt'
				if(any(L ~= 31))
					error('Number of elements must be 31');
				end
		end
	end
end

if(~isempty(MainTitle))
	if(~ischar(MainTitle))
		error('MainTitle must be a string');
	end
end

NonSignificantColour = repmat(0.25, 1, 3);
CMAPSize = 256;

[FSAverageV, FSAverageF, ValueVertexIDX, RGB] = freesurfer_statsurf_loadsurfaces(SurfType, FreesurferSeedType);