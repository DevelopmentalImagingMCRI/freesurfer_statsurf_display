clear;

P = cell(1, 2);
T = cell(1, 2);

for z = 1:2
	P{z} = rand(31, 1) * 0.05 - 0.025;
	T{z} = rand(31, 1) * 5 - 3;
end
%freesurfer_statsurf_fsrgb([], 'voneconomo', 'MainTitle', 'Von Economo and Koskinas');
%freesurfer_statsurf_savefig('voneconomo.png');

%freesurfer_statsurf_p(P, T, 'dkt', 'useShortLabels', true, 'MainTitle', 'dsaffdsa');
freesurfer_statsurf_fsrgb([], 'dkt', 'SurfType', 'white', 'useShortLabels', true);
freesurfer_statsurf_savefig('fsrgb_white.png');
freesurfer_statsurf_fsrgb([], 'dkt', 'SurfType', 'pial');
freesurfer_statsurf_savefig('fsrgb_pial.png');
freesurfer_statsurf_fsrgb([], 'aparc', 'SurfType', 'inflated', 'useShortLabels', true);
freesurfer_statsurf_savefig('fsrgb_inflated.png');
%freesurfer_statsurf_scalar(P, [], 'dkt', 'MainTitle', 'dsaffdsa');
%freesurfer_statsurf_savefig('voneconomo.png');
%IMG = imread('voneconomo.png');
%IMG = imresize(IMG, [NaN, 500]);
%imwrite(IMG, 'voneconomo.png');
delete(gcf);