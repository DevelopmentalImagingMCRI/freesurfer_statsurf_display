function [FSAverageV, FSAverageF, ValueVertexIDX, RGB] = freesurfer_statsurf_loadsurfaces(SurfType, FreesurferSeedType)

% load freesurfer average surfaces

SurfTypes = {'white', 'pial', 'inflated'};

if(~ismember(SurfType, SurfTypes))
	error(['SurfType must be one of ' sprintf('%s ', SurfTypes{:})]);
end

Hemis = {'lh', 'rh'};

%MATFile = 'freesurfer_fsaverage';

%if(exist([MATFile '.mat'], 'file') ~= 2)

	%FSAverageVInflated = cell(1, 2);
	%FSAverageVPial = cell(1, 2);
	
	F = mfilename('fullpath');
	[FreesurferSubjectsDir, ~, ~] = fileparts(F);
	clear F;
	
	FSAverageV = cell(1, 2);
	FSAverageF = cell(1, 2);

	% the common parts
	for HemiIDX = 1:length(Hemis)
		Hemi = Hemis{HemiIDX};
	
		[FSAverageV{HemiIDX}, FSAverageF{HemiIDX}] = read_freesurfer_surface(fullfile(FreesurferSubjectsDir, 'fsaverage', 'surf', [Hemi '.' SurfType]));
		FSAverageF{HemiIDX} = uint32(FSAverageF{HemiIDX});
	end
	
	ValueVertexIDX = cell(1, length(Hemis));
	AnnotLabel = cell(1, length(Hemis));
	AnnotTable = cell(1, length(Hemis));
	AnnotSeg = cell(1, length(Hemis));
	RGB = cell(1, length(Hemis));
	%RegionLabels = cell(1, length(Hemis));
	
	% set up invalid structures for each seed type
	switch(lower(FreesurferSeedType))
		case 'aparc'
			InvalidStructs = {'unknown', 'corpuscallosum'};
			LabelName = 'aparc';
		case {'aparc.a2009s', 'destrieux'}
			InvalidStructs = {'Medial_wall', 'Unknown'};
			LabelName = 'aparc.a2009s';
		case 'dkt'
			InvalidStructs = {'unknown', 'corpuscallosum', ...
				    'bankssts', 'frontalpole' 'temporalpole', ... these were removed from aparc by DKT
					};
			LabelName = 'aparc.DKTatlas';
	end
	for HemiIDX = 1:length(Hemis)
		Hemi = Hemis{HemiIDX};
			
		[~, AnnotLabel{HemiIDX}, AnnotTable{HemiIDX}] = freesurfer_read_annot(fullfile(FreesurferSubjectsDir, 'fsaverage', 'label', [Hemi '.' LabelName '.annot']));
		[~, AnnotSeg{HemiIDX}] = ismember(AnnotLabel{HemiIDX}, AnnotTable{HemiIDX}.table(:, 5));
		%keyboard;
		% remove corpuscallosum and unknown from the segmentation
		ValidStructs = ~ismember(AnnotTable{HemiIDX}.struct_names, InvalidStructs);
		%ValidStructNames{HemiIDX} = AnnotTable{HemiIDX}.struct_names(ValidStructs);
		CurRGB = uint8(AnnotTable{HemiIDX}.table(ValidStructs, 1:3));
		InvalidStructsIDX = find(~ValidStructs);
		AnnotSeg{HemiIDX}(ismember(AnnotSeg{HemiIDX}, InvalidStructsIDX)) = 0;
		ValidStructRemap = cumsum(ValidStructs);
		AnnotSeg{HemiIDX}(AnnotSeg{HemiIDX} > 0) = ValidStructRemap(AnnotSeg{HemiIDX}(AnnotSeg{HemiIDX} > 0));
		ValueVertexIDX{HemiIDX} = uint32(AnnotSeg{HemiIDX});
		RGB{HemiIDX} = zeros(length(ValueVertexIDX{HemiIDX}), 3);
		M = ValueVertexIDX{HemiIDX} > 0;
		RGB{HemiIDX}(M, :) = double(CurRGB(ValueVertexIDX{HemiIDX}(M), :)) / 255;
		%keyboard;
	end
