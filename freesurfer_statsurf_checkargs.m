function [options, ...
NonSignificantColour, CMAPSize, ... % constants
FSAverageV, FSAverageF, ValueVertexIDX, RGB, ... % from loadsurfaces
OtherArgs] = freesurfer_statsurf_checkargs(Values, FreesurferSeedType, Args)

options.MainTitle = [];
options.UseShortLabels = false;
options.NoLabels = false;
options.NoLegend = false;
options.SurfType = 'inflated';
options.MedialLateralLabels = true;
options.LabelColour = 'w';
options.BackgroundTextColour = 'w';

OtherArgs = {};

for z = 1:2:length(Args)
	if length(Args) >= z + 1
		if(~ischar(Args{z}))
			disp('Parameter not a string, ignoring');
		else
			switch(lower(Args{z}))
				case 'maintitle'
					options.MainTitle = Args{z + 1};
				case {'shortlabels', 'useshortlabels'}
					options.UseShortLabels = Args{z + 1};
				case 'nolabels'
					options.NoLabels = Args{z + 1};
				case 'nolegend'
					options.NoLegend = Args{z + 1};
				case 'surftype'
					options.SurfType = Args{z + 1};
				case {'medlatlabels', 'mediallaterallabels'}
					options.MedialLateralLabels = Args{z + 1};
				case {'labelcolour', 'labelcolor'}
					options.LabelColour = Args{z + 1};
					
				otherwise
					OtherArgs = [OtherArgs; Args{z}; Args{z + 1}];
			end
		end
	else
		disp('Last parameter had no value associated with it, ignoring');
	end
end

FreesurferSeedTypes = {'aparc', 'aparc.a2009s', 'destreiux', 'dkt', 'voneconomo'};

if ~ismember(FreesurferSeedType, FreesurferSeedTypes)
	error('Unsupported seed type');
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
			case 'voneconomo'
				if(any(L ~= 43))
					error('Number of elements must be 43');
				end
				
		end
	end
end

if(~isempty(options.MainTitle))
	if(~ischar(options.MainTitle))
		error('MainTitle must be a string');
	end
end

NonSignificantColour = repmat(0.25, 1, 3);
CMAPSize = 256;

[FSAverageV, FSAverageF, ValueVertexIDX, RGB] = freesurfer_statsurf_loadsurfaces(options.SurfType, FreesurferSeedType);