function NewIMG = imautocrop(IMG, Padding)

if nargin < 2
	Padding = 0;
end

if ~isa(IMG, 'uint8')
	error('IMG must be a uint8');
end

BGColour = IMG(1, 1, :);

M = any(IMG ~= repmat(BGColour, [size(IMG, 1), size(IMG, 2), 1]), 3);

[I, J] = find(M);

NewIMG = cell(3, 3);

I = min(I):max(I);
J = min(J):max(J);

% put padding in the corners
NewIMG{1, 1} = repmat(BGColour, [Padding, Padding, 1]);
NewIMG{3, 1} = repmat(BGColour, [Padding, Padding, 1]);
NewIMG{1, 3} = repmat(BGColour, [Padding, Padding, 1]);
NewIMG{3, 3} = repmat(BGColour, [Padding, Padding, 1]);

% put padding in the northern and southern parts
NewIMG{1, 2} = repmat(BGColour, [Padding, length(J), 1]);
NewIMG{3, 2} = repmat(BGColour, [Padding, length(J), 1]);

% put padding in the western and eastern parts
NewIMG{2, 1} = repmat(BGColour, [length(I), Padding, 1]);
NewIMG{2, 3} = repmat(BGColour, [length(I), Padding, 1]);

% put cropped image in the middle
NewIMG{2, 2} = IMG(I, J, :);

%SZ = cellfun(@size, NewIMG, 'UniformOutput', false);
%keyboard;
NewIMG = cell2mat(NewIMG);
