function NewIMG = imautocropblack(IMG, Padding)

if nargin < 2
	Padding = 0;
end

if ~isa(IMG, 'uint8')
	error('IMG must be a uint8');
end

M = any(IMG > 0, 3);

[I, J] = find(M);

NewIMG = cell(3, 3);

I = min(I):max(I);
J = min(J):max(J);

% put padding in the corners
NewIMG{1, 1} = zeros([Padding, Padding, size(IMG, 3)], 'uint8');
NewIMG{3, 1} = zeros([Padding, Padding, size(IMG, 3)], 'uint8');
NewIMG{1, 3} = zeros([Padding, Padding, size(IMG, 3)], 'uint8');
NewIMG{3, 3} = zeros([Padding, Padding, size(IMG, 3)], 'uint8');

% put padding in the northern and southern parts
NewIMG{1, 2} = zeros([Padding, length(J), size(IMG, 3)], 'uint8');
NewIMG{3, 2} = zeros([Padding, length(J), size(IMG, 3)], 'uint8');

% put padding in the western and eastern parts
NewIMG{2, 1} = zeros([length(I), Padding, size(IMG, 3)], 'uint8');
NewIMG{2, 3} = zeros([length(I), Padding, size(IMG, 3)], 'uint8');

% put cropped image in the middle
NewIMG{2, 2} = IMG(I, J, :);

%SZ = cellfun(@size, NewIMG, 'UniformOutput', false);
%keyboard;
NewIMG = cell2mat(NewIMG);