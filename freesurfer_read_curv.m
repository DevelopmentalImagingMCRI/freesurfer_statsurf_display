function [Values, NumVertices, NumFaces] = freesurfer_read_curv(FileName)

% [Values, NumVertices, NumFaces] = freesurfer_read_curv(FileName)

if(exist(FileName, 'file') ~= 2)
	error(['File does not exist: ' FileName]);
end

FID = fopen(FileName, 'r', 'b');

MagicNumber = fread(FID, 3, '*int8');

if(~isequal(MagicNumber, -int8(ones(3, 1))))
	fclose(FID);
	error('Magic number wrong');
end
	
NumVertices = fread(FID, 1, '*int32');
NumFaces = fread(FID, 1, '*int32');

NumValuesPerVertex = fread(FID, 1, '*int32');

Values = fread(FID, NumVertices * NumValuesPerVertex, 'single');
Values = single(Values);
fclose(FID);

%Type
%	Comment
%0 	FileTypeId 	Int3 	"Magic" number identifies file format. For this file type, this is a 3-byte -1 = 0x00ffffff = 16777215
%3 	VertexCount 	Int4 	Count of vertices (must match that of surface file to which this data is being associated.)
%7 	FaceCount 	Int4 	Count of faces (not useful?)
%11 	ValsPerVertex 	Int4 	Number of values supplied per vertex (currently only 1 is supported).

%15 + 4n VertexValue
