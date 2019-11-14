function [NewFaceVertexCData] = freesurfer_statsurf_nonsigwithcurv(FaceVertexCData, FSAverageCurv, NonSignificantColour)

% replace the non-significant colour in FaceVertexCData with curvature
% values from FSAverageCurv

NewFaceVertexCData = FaceVertexCData;

for HemiIDX = 1:length(FaceVertexCData)
    
    M = all(repmat(NonSignificantColour(:)', size(FaceVertexCData{HemiIDX}, 1), 1) == FaceVertexCData{HemiIDX}, 2);
    
    BrighterIDX = sign(FSAverageCurv{HemiIDX}) == -1;
    DarkerIDX = sign(FSAverageCurv{HemiIDX}) > -1;
    
    if any(M)
        NewFaceVertexCData{HemiIDX}(M & BrighterIDX, :) = NonSignificantColour(1) + 0.1;
        NewFaceVertexCData{HemiIDX}(M & DarkerIDX, :) = NonSignificantColour(1);
    end
end

%keyboard;%