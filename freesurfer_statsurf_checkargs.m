function [options, ...
NonSignificantColour, CMAPSize, ... % constants
FSAverageV, FSAverageF, FSAverageCurv, ValueVertexIDX, RGB, ... % from loadsurfaces
OtherArgs] = freesurfer_statsurf_checkargs(Values, FreesurferSeedType, Args)

options.MainTitle = [];
options.UseShortLabels = false;
options.NoLabels = false;
options.NoLegend = false;
options.LegendNoZero = false;
options.SurfType = 'inflated';
options.MedialLateralLabels = true;
options.LabelColour = 'w';
options.BackgroundTextColour = 'w';
options.PatchProps = [];
options.SurfaceSource = 'fs6';
options.HorizontalCompact = false;
options.BackgroundNoCurv = false;
options.LargeFonts = false;

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
                case 'largefonts'
					options.LargeFonts = Args{z + 1};
				case 'nolegend'
					options.NoLegend = Args{z + 1};
				case 'legendnozero'
					options.LegendNoZero = Args{z + 1};
				case 'surftype'
					options.SurfType = Args{z + 1};
				case {'medlatlabels', 'mediallaterallabels'}
					options.MedialLateralLabels = Args{z + 1};
				case {'labelcolour', 'labelcolor'}
					options.LabelColour = Args{z + 1};
				case 'patchprops'
					options.PatchProps = Args{z + 1};
				case 'surfacesource'
					options.SurfaceSource = lower(Args{z + 1});
                case 'horizontalcompact'
                    options.HorizontalCompact = Args{z + 1};
                case 'backgroundnocurv'
                    options.BackgroundNoCurv = Args{z + 1};
                otherwise
                    if iscell(Args{z + 1}) || isa(Args{z + 1}, 'function_handle')
                        OtherArgs = [OtherArgs; Args{z}; {Args{z + 1}}];
                    else
                        OtherArgs = [OtherArgs; Args{z}; Args{z + 1}];
                    end
			end
		end
	else
		disp('Last parameter had no value associated with it, ignoring');
	end
end
%keyboard;
SupportedSurfaceSources = {'fs6', 'mcribs'};
SupportedSurfaceSources = {'fs6'};

if ~ismember(options.SurfaceSource, SupportedSurfaceSources)
	error('Unsupported seed type');
end

FreesurferSeedTypes.fs6 = {'aparc', 'desikan', 'aparc.a2009s', 'destreiux', 'dkt', 'voneconomo'};
FreesurferSeedTypes.mcribs = {'aparc', 'desikan', 'dkt'};

if ~ismember(FreesurferSeedType, FreesurferSeedTypes.(options.SurfaceSource))
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
			case {'aparc', 'desikan'}
				if(any(L ~= 34))
					error('Number of elements must be 34');
				end
			case {'aparc.a2009s', 'destrieux'}
				if(any(L ~= 74))
					error('Number of elements must be 74');
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

% type check all arguments

if(~isempty(options.MainTitle))
	if(~ischar(options.MainTitle))
		error('MainTitle must be a string');
	end
end

LogicalScalarFields = {'UseShortLabels', 'NoLabels', 'NoLegend', 'MedialLateralLabels'};

for z = 1:length(LogicalScalarFields)
	CurField = LogicalScalarFields{z};
	
	if(~islogical(options.(CurField)) || ~isscalar(options.(CurField)))
		error([CurField ' option must be a logical scalar']);
	end
end

SupportedSurfTypes = {'white', 'pial', 'inflated'};

if(~ismember(options.SurfType,SupportedSurfTypes))
	error(['SurfType must be one of the following:' sprintf(' ''%s''', SupportedSurfTypes{:})]);
end

if(~ischar(options.LabelColour) || ~isscalar(options.LabelColour))
	error('LabelColour must be a single char');
end

if(~isempty(options.PatchProps))
	if(~iscell(options.PatchProps))
		error('PatchProps must be a cell array');
	end
end



NonSignificantColour = repmat(0.25, 1, 3);
CMAPSize = 256;

[FSAverageV, FSAverageF, FSAverageCurv, ValueVertexIDX, RGB] = freesurfer_statsurf_loadsurfaces(options.SurfType, FreesurferSeedType, options.SurfaceSource);
