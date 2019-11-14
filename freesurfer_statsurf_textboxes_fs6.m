function [TextBoxes, Arrows, Rectangles] = freesurfer_statsurf_textboxes_fs6(FreesurferSeedType)

if(strcmpi(FreesurferSeedType, 'aparc'))
    TextBoxes.LH.bankssts{1} = {'Position', [0.823435, 0.630588, 0.051565, 0.047059], 'String', {'Bank of', 'STS'}, 'HorizontalAlignment', 'center', 'LineStyle', '-', 'EdgeColor', 'w', 'LineWidth', 2};
    Arrows.LH.bankssts = {'X', [0.84542 0.784351145038168], 'Y', [0.676471 0.728235294117647]};
end
TextBoxes.LH.caudalanteriorcingulate{1} = {'Position', [0.270305, 0.724706, 0.097939, 0.049882], 'String', {'Caudal anterior'}, 'HorizontalAlignment', 'center', 'LineStyle', 'none', 'EdgeColor', 'none', 'LineWidth', 2};
Arrows.LH.caudalanteriorcingulate = {'X', [0.330153, 0.361641], 'Y', [0.756647, 0.775294]};
Rectangles.LH.caudalanteriorcingulate = {'Position', [0.274817, 0.724118, 0.088695, 0.032941]};
TextBoxes.LH.caudalanteriorcingulate{2} = {'Position', [0.273168, 0.724059, 0.097939, 0.022882], 'String', {'cingulate'}, 'HorizontalAlignment', 'center', 'LineStyle', 'none', 'EdgeColor', 'none', 'LineWidth', 2};
Arrows.LH.caudalanteriorcingulate = {'X', [0.330153, 0.361641], 'Y', [0.756647, 0.775294]};
Rectangles.LH.caudalanteriorcingulate = {'Position', [0.274817, 0.724118, 0.088695, 0.032941]};
TextBoxes.LH.caudalmiddlefrontal{1} = {'Position', [0.635580, 0.869412, 0.085756, 0.042353], 'String', {'Caudal middle', 'frontal'}, 'HorizontalAlignment', 'center', 'LineStyle', '-', 'EdgeColor', 'w', 'LineWidth', 2};
Arrows.LH.caudalmiddlefrontal = {'X', [0.686031, 0.678435], 'Y', [0.869412, 0.800000]};
TextBoxes.LH.cuneus{1} = {'Position', [0.126832, 0.795294, 0.053473, 0.027059], 'String', {'Cuneus'}, 'HorizontalAlignment', 'center', 'LineStyle', '-', 'EdgeColor', 'w', 'LineWidth', 2};
Arrows.LH.cuneus = {'X', [0.169809, 0.181298], 'Y', [0.797824, 0.760000]};
TextBoxes.LH.entorhinal{1} = {'Position', [0.270008, 0.607647, 0.069611, 0.027353], 'String', {'Entorhinal'}, 'HorizontalAlignment', 'center', 'LineStyle', '-', 'EdgeColor', 'w', 'LineWidth', 2};
Arrows.LH.entorhinal = {'X', [0.318206, 0.314885], 'Y', [0.633118, 0.651765]};
TextBoxes.LH.fusiform{1} = {'Position', [0.143504, 0.649412, 0.062527, 0.027059], 'String', {'Fusiform'}, 'HorizontalAlignment', 'center', 'LineStyle', '-', 'EdgeColor', 'w', 'LineWidth', 2};
Arrows.LH.fusiform = {'X', [0.206107, 0.231832], 'Y', [0.665882, 0.678824]};
TextBoxes.LH.inferiorparietal{1} = {'Position', [0.884504, 0.721765, 0.049466, 0.049412], 'String', {'Inferior', 'parietal'}, 'HorizontalAlignment', 'center', 'LineStyle', '-', 'EdgeColor', 'w', 'LineWidth', 2};
Arrows.LH.inferiorparietal = {'X', [0.885496, 0.840649], 'Y', [0.747059, 0.760000]};
TextBoxes.LH.inferiortemporal{1} = {'Position', [0.758405, 0.608118, 0.055489, 0.043529], 'String', {'Inferior', 'temporal'}, 'HorizontalAlignment', 'center', 'LineStyle', '-', 'EdgeColor', 'w', 'LineWidth', 2};
Arrows.LH.inferiortemporal = {'X', [0.789084, 0.791031], 'Y', [0.651941, 0.676471]};
TextBoxes.LH.isthmuscingulate{1} = {'Position', [0.262458, 0.693824, 0.065748, 0.031765], 'String', {'Isthmus'}, 'HorizontalAlignment', 'center', 'LineStyle', 'none', 'EdgeColor', 'none', 'LineWidth', 2};
Arrows.LH.isthmuscingulate = {'X', [0.264275, 0.244275], 'Y', [0.701353, 0.751765]};
Rectangles.LH.isthmuscingulate = {'Position', [0.263450, 0.683235, 0.065748, 0.035294]};
TextBoxes.LH.isthmuscingulate{2} = {'Position', [0.262458, 0.681235, 0.065748, 0.029412], 'String', {'cingulate'}, 'HorizontalAlignment', 'center', 'LineStyle', 'none', 'EdgeColor', 'none', 'LineWidth', 2};
Arrows.LH.isthmuscingulate = {'X', [0.264275, 0.244275], 'Y', [0.701353, 0.751765]};
Rectangles.LH.isthmuscingulate = {'Position', [0.263450, 0.683235, 0.065748, 0.035294]};
TextBoxes.LH.lateraloccipital{1} = {'Position', [0.879733, 0.670588, 0.063740, 0.047059], 'String', {'Lateral', 'occipital'}, 'HorizontalAlignment', 'center', 'LineStyle', '-', 'EdgeColor', 'w', 'LineWidth', 2};
Arrows.LH.lateraloccipital = {'X', [0.879771 0.848282442748092], 'Y', [0.692941 0.717647058823529]};
TextBoxes.LH.lateralorbitofrontal{1} = {'Position', [0.566076, 0.627059, 0.080885, 0.041880], 'String', {'Lateral', 'orbito-frontal'}, 'HorizontalAlignment', 'center', 'LineStyle', '-', 'EdgeColor', 'w', 'LineWidth', 2};
Arrows.LH.lateralorbitofrontal = {'X', [0.634504, 0.652672], 'Y', [0.670588, 0.682353]};
TextBoxes.LH.lingual{1} = {'Position', [0.107756, 0.687059, 0.050603, 0.028529], 'String', {'Lingual'}, 'HorizontalAlignment', 'center', 'LineStyle', '-', 'EdgeColor', 'w', 'LineWidth', 2};
Arrows.LH.lingual = {'X', [0.159351, 0.203244], 'Y', [0.697647, 0.702353]};
TextBoxes.LH.medialorbitofrontal{1} = {'Position', [0.422985, 0.637059, 0.084420, 0.046471], 'String', {'Medial', 'orbito-frontal'}, 'HorizontalAlignment', 'center', 'LineStyle', '-', 'EdgeColor', 'w', 'LineWidth', 2};
Arrows.LH.medialorbitofrontal = {'X', [0.42175572519084 0.392175572519084], 'Y', [0.658823529411765 0.688235294117647]};
TextBoxes.LH.middletemporal{1} = {'Position', [0.741954, 0.683529, 0.058160, 0.025882], 'String', {'Middle'}, 'HorizontalAlignment', 'center', 'LineStyle', 'none', 'EdgeColor', 'none', 'LineWidth', 2};
TextBoxes.LH.middletemporal{2} = {'Position', [0.707061, 0.662353, 0.073473, 0.030588], 'String', {'temporal'}, 'HorizontalAlignment', 'center', 'LineStyle', 'none', 'EdgeColor', 'none', 'LineWidth', 2};
TextBoxes.LH.parahippocampal{1} = {'Position', [0.160313, 0.602353, 0.104916, 0.031765], 'String', {'Parahippocampal'}, 'HorizontalAlignment', 'center', 'LineStyle', '-', 'EdgeColor', 'w', 'LineWidth', 2};
Arrows.LH.parahippocampal = {'X', [0.258550, 0.269084], 'Y', [0.635471, 0.677647]};
TextBoxes.LH.paracentral{1} = {'Position', [0.250962, 0.820588, 0.074427, 0.047059], 'String', {'Paracentral', 'lobule'}, 'HorizontalAlignment', 'left', 'LineStyle', 'none', 'EdgeColor', 'none', 'LineWidth', 2};
TextBoxes.LH.parsopercularis{1} = {'Position', [0.532565, 0.775294, 0.069458, 0.041880], 'String', {'Pars', 'opercularis'}, 'HorizontalAlignment', 'center', 'LineStyle', '-', 'EdgeColor', 'w', 'LineWidth', 2};
Arrows.LH.parsopercularis = {'X', [0.602061, 0.669847], 'Y', [0.783529, 0.745882]};

TextBoxes.LH.parsorbitalis{1} = {'Position', [0.537412, 0.677647, 0.057015, 0.039527], 'String', {'Pars', 'orbitalis'}, 'HorizontalAlignment', 'center', 'LineStyle', '-', 'EdgeColor', 'w', 'LineWidth', 2};
switch(lower(FreesurferSeedType))
	case 'aparc'
		Arrows.LH.parsorbitalis = {'X', [0.594389, 0.625954], 'Y', [0.691765, 0.695294]};
	case 'dkt'
		Arrows.LH.parsorbitalis = {'X', [0.594389, 0.651717], 'Y', [0.691765, 0.695294]};
end

TextBoxes.LH.parstriangularis{1} = {'Position', [0.523061, 0.725882, 0.069458, 0.041880], 'String', {'Pars', 'triangularis'}, 'HorizontalAlignment', 'center', 'LineStyle', '-', 'EdgeColor', 'w', 'LineWidth', 2};
Arrows.LH.parstriangularis = {'X', [0.593397, 0.643130], 'Y', [0.742353, 0.723529]};
TextBoxes.LH.pericalcarine{1} = {'Position', [0.075191, 0.742353, 0.081298, 0.029412], 'String', {'Pericalcarine'}, 'HorizontalAlignment', 'center', 'LineStyle', '-', 'EdgeColor', 'w', 'LineWidth', 2};
switch(lower(FreesurferSeedType))
	case 'aparc'
		Arrows.LH.pericalcarine = {'X', [0.1565, 0.180344], 'Y', [0.752941, 0.732941]};
	case 'dkt'
		Arrows.LH.pericalcarine = {'X', [0.1565, 0.188931], 'Y', [0.752941, 0.729411]};
end
TextBoxes.LH.postcentral{1} = {'Position', [0.749008, 0.872941, 0.075382, 0.028235], 'String', {'Postcentral'}, 'HorizontalAlignment', 'center', 'LineStyle', '-', 'EdgeColor', 'w', 'LineWidth', 2};
Arrows.LH.postcentral = {'X', [0.786221, 0.760496], 'Y', [0.872941, 0.843529]};
TextBoxes.LH.posteriorcingulate{1} = {'Position', [0.262908, 0.770588, 0.072473, 0.052941], 'String', {'Posterior', 'cingulate'}, 'HorizontalAlignment', 'center', 'LineStyle', 'none', 'EdgeColor', 'none', 'LineWidth', 2};
TextBoxes.LH.precentral{1} = {'Position', [0.684084, 0.825882, 0.075382, 0.028235], 'String', {'Pre-'}, 'HorizontalAlignment', 'center', 'LineStyle', 'none', 'EdgeColor', 'none', 'LineWidth', 2};
TextBoxes.LH.precentral{2} = {'Position', [0.682137, 0.811765, 0.075382, 0.028235], 'String', {'central'}, 'HorizontalAlignment', 'center', 'LineStyle', 'none', 'EdgeColor', 'none', 'LineWidth', 2};
TextBoxes.LH.precuneus{1} = {'Position', [0.191565, 0.795294, 0.081298, 0.029412], 'String', {'Precuneus'}, 'HorizontalAlignment', 'center', 'LineStyle', 'none', 'EdgeColor', 'none', 'LineWidth', 2};
TextBoxes.LH.rostralanteriorcingulate{1} = {'Position', [0.432756, 0.759412, 0.062931, 0.062353], 'String', {'Rostral', 'anterior', 'cingulate'}, 'HorizontalAlignment', 'center', 'LineStyle', '-', 'EdgeColor', 'w', 'LineWidth', 2};
Arrows.LH.rostralanteriorcingulate = {'X', [0.432756, 0.397901], 'Y', [0.768235, 0.723529]};
TextBoxes.LH.rostralmiddlefrontal{1} = {'Position', [0.541114, 0.823529, 0.085756, 0.042353], 'String', {'Rostral middle', 'frontal'}, 'HorizontalAlignment', 'center', 'LineStyle', '-', 'EdgeColor', 'w', 'LineWidth', 2};
Arrows.LH.rostralmiddlefrontal = {'X', [0.627863, 0.642176], 'Y', [0.834118, 0.775294]};
TextBoxes.LH.superiorfrontal{1} = {'Position', [0.305733, 0.797758, 0.114862, 0.054771], 'String', {'Superior'}, 'HorizontalAlignment', 'center', 'LineStyle', 'none', 'EdgeColor', 'none', 'LineWidth', 2};
TextBoxes.LH.superiorfrontal{2} = {'Position', [0.316191, 0.782464, 0.114862, 0.054771], 'String', {'frontal'}, 'HorizontalAlignment', 'center', 'LineStyle', 'none', 'EdgeColor', 'none', 'LineWidth', 2};
TextBoxes.LH.superiorparietal{1} = {'Position', [0.830153, 0.842353, 0.058168, 0.044706], 'String', {'Superior', 'parietal'}, 'HorizontalAlignment', 'center', 'LineStyle', '-', 'EdgeColor', 'w', 'LineWidth', 2};
Arrows.LH.superiorparietal = {'X', [0.830153, 0.801527], 'Y', [0.843529, 0.832941]};
TextBoxes.LH.superiortemporal{1} = {'Position', [0.694702, 0.688824, 0.071519, 0.030588], 'String', {'Superior'}, 'HorizontalAlignment', 'center', 'LineStyle', 'none', 'EdgeColor', 'none', 'LineWidth', 2};
TextBoxes.LH.superiortemporal{2} = {'Position', [0.685115, 0.677059, 0.066794, 0.031765], 'String', {'temporal'}, 'HorizontalAlignment', 'center', 'LineStyle', 'none', 'EdgeColor', 'none', 'LineWidth', 2};
TextBoxes.LH.supramarginal{1} = {'Position', [0.747145, 0.767059, 0.046710, 0.035294], 'String', {'Supra-', 'marginal'}, 'HorizontalAlignment', 'left', 'LineStyle', 'none', 'EdgeColor', 'none', 'LineWidth', 2};
TextBoxes.LH.frontalpole{1} = {'Position', [0.447031, 0.698824, 0.050069, 0.046471], 'String', {'Frontal', 'pole'}, 'HorizontalAlignment', 'center', 'LineStyle', '-', 'EdgeColor', 'w', 'LineWidth', 2};
Arrows.LH.frontalpole = {'X', [0.447031, 0.432252], 'Y', [0.707235, 0.712941]};
TextBoxes.LH.temporalpole{1} = {'Position', [0.354550, 0.617647, 0.060198, 0.044882], 'String', {'Temporal', 'pole'}, 'HorizontalAlignment', 'center', 'LineStyle', '-', 'EdgeColor', 'w', 'LineWidth', 2};
Arrows.LH.temporalpole = {'X', [0.354962, 0.339695], 'Y', [0.638824, 0.649412]};
TextBoxes.LH.transversetemporal{1} = {'Position', [0.859473, 0.783529, 0.069840, 0.048235], 'String', {'Transverse', 'temporal'}, 'HorizontalAlignment', 'center', 'LineStyle', '-', 'EdgeColor', 'w', 'LineWidth', 2};
Arrows.LH.transversetemporal = {'X', [0.857786, 0.741412], 'Y', [0.816471, 0.731765]};
TextBoxes.LH.insula{1} = {'Position', [0.676573, 0.705882, 0.046710, 0.031765], 'String', {'Insula'}, 'HorizontalAlignment', 'center', 'LineStyle', 'none', 'EdgeColor', 'none', 'LineWidth', 2};
TextBoxes.RH.bankssts{1} = {'Position', [0.577290, 0.344706, 0.055344, 0.044706], 'String', {'Bank of', 'STS'}, 'HorizontalAlignment', 'center', 'LineStyle', '-', 'EdgeColor', 'w', 'LineWidth', 2};
Arrows.RH.bankssts = {'X', [0.606870, 0.691794], 'Y', [0.3894, 0.449412]};
TextBoxes.RH.caudalanteriorcingulate{1} = {'Position', [0.235038, 0.454706, 0.097939, 0.049882], 'String', {'Caudal anterior'}, 'HorizontalAlignment', 'center', 'LineStyle', 'none', 'EdgeColor', 'none', 'LineWidth', 2};
Arrows.RH.caudalanteriorcingulate = {'X', [0.254771, 0.235687], 'Y', [0.487235, 0.508235]};
Rectangles.RH.caudalanteriorcingulate = {'Position', [0.240504, 0.454118, 0.088695, 0.032941]};
TextBoxes.RH.caudalanteriorcingulate{2} = {'Position', [0.235038, 0.454706, 0.097939, 0.022882], 'String', {'cingulate'}, 'HorizontalAlignment', 'center', 'LineStyle', 'none', 'EdgeColor', 'none', 'LineWidth', 2};
Arrows.RH.caudalanteriorcingulate = {'X', [0.254771, 0.235687], 'Y', [0.487235, 0.508235]};
Rectangles.RH.caudalanteriorcingulate = {'Position', [0.240504, 0.454118, 0.088695, 0.032941]};
TextBoxes.RH.caudalmiddlefrontal{1} = {'Position', [0.828366, 0.567059, 0.085756, 0.042353], 'String', {'Caudal middle', 'frontal'}, 'HorizontalAlignment', 'center', 'LineStyle', '-', 'EdgeColor', 'w', 'LineWidth', 2};
Arrows.RH.caudalmiddlefrontal = {'X', [0.83874 0.797709923664122], 'Y', [0.567059 0.530588235294118]};
TextBoxes.RH.cuneus{1} = {'Position', [0.403588, 0.534118, 0.053473, 0.027059], 'String', {'Cuneus'}, 'HorizontalAlignment', 'center', 'LineStyle', '-', 'EdgeColor', 'w', 'LineWidth', 2};
Arrows.RH.cuneus = {'X', [0.420802, 0.408397], 'Y', [0.534118, 0.485882]};
TextBoxes.RH.entorhinal{1} = {'Position', [0.263366, 0.327647, 0.069611, 0.027353], 'String', {'Entorhinal'}, 'HorizontalAlignment', 'center', 'LineStyle', '-', 'EdgeColor', 'w', 'LineWidth', 2};
Arrows.RH.entorhinal = {'X', [0.288664, 0.286260], 'Y', [0.356647, 0.376471]};
TextBoxes.RH.fusiform{1} = {'Position', [0.379771, 0.376471, 0.062527, 0.027059], 'String', {'Fusiform'}, 'HorizontalAlignment', 'center', 'LineStyle', '-', 'EdgeColor', 'w', 'LineWidth', 2};
Arrows.RH.fusiform = {'X', [0.380725, 0.358779], 'Y', [0.387235, 0.404706]};
TextBoxes.RH.inferiorparietal{1} = {'Position', [0.546756, 0.451176, 0.049466, 0.049412], 'String', {'Inferior', 'parietal'}, 'HorizontalAlignment', 'center', 'LineStyle', '-', 'EdgeColor', 'w', 'LineWidth', 2};
Arrows.RH.inferiorparietal = {'X', [0.597328 0.654580152671756], 'Y', [0.483706 0.487058823529412]};
TextBoxes.RH.inferiortemporal{1} = {'Position', [0.639168, 0.339882, 0.055489, 0.043529], 'String', {'Inferior', 'temporal'}, 'HorizontalAlignment', 'center', 'LineStyle', '-', 'EdgeColor', 'w', 'LineWidth', 2};
Arrows.RH.inferiortemporal = {'X', [0.679389, 0.687977], 'Y', [0.386059, 0.405882]};
TextBoxes.RH.isthmuscingulate{1} = {'Position', [0.260588, 0.422882, 0.065748, 0.031765], 'String', {'Isthmus'}, 'HorizontalAlignment', 'center', 'LineStyle', 'none', 'EdgeColor', 'none', 'LineWidth', 2};
Arrows.RH.isthmuscingulate = {'X', [0.327290, 0.347328], 'Y', [0.431941, 0.480000]};
Rectangles.RH.isthmuscingulate = {'Position', [0.260588, 0.412647, 0.065748, 0.035294]};
TextBoxes.RH.isthmuscingulate{2} = {'Position', [0.260588, 0.411471, 0.065748, 0.029412], 'String', {'cingulate'}, 'HorizontalAlignment', 'center', 'LineStyle', 'none', 'EdgeColor', 'none', 'LineWidth', 2};
Arrows.RH.isthmuscingulate = {'X', [0.327290, 0.347328], 'Y', [0.431941, 0.480000]};
Rectangles.RH.isthmuscingulate = {'Position', [0.260588, 0.412647, 0.065748, 0.035294]};
TextBoxes.RH.lateraloccipital{1} = {'Position', [0.531489, 0.396471, 0.063740, 0.047059], 'String', {'Lateral', 'occipital'}, 'HorizontalAlignment', 'center', 'LineStyle', '-', 'EdgeColor', 'w', 'LineWidth', 2};
Arrows.RH.lateraloccipital = {'X', [0.595344, 0.625000], 'Y', [0.424706, 0.441176]};
TextBoxes.RH.lateralorbitofrontal{1} = {'Position', [0.759817, 0.321176, 0.080885, 0.041880], 'String', {'Lateral', 'orbito-frontal'}, 'HorizontalAlignment', 'center', 'LineStyle', '-', 'EdgeColor', 'w', 'LineWidth', 2};
Arrows.RH.lateralorbitofrontal = {'X', [0.795802, 0.821565], 'Y', [0.364706, 0.409412]};
TextBoxes.RH.lingual{1} = {'Position', [0.441763, 0.409412, 0.050603, 0.028529], 'String', {'Lingual'}, 'HorizontalAlignment', 'center', 'LineStyle', '-', 'EdgeColor', 'w', 'LineWidth', 2};
Arrows.RH.lingual = {'X', [0.440840, 0.383588], 'Y', [0.416471, 0.432941]};
TextBoxes.RH.medialorbitofrontal{1} = {'Position', [0.083328, 0.344118, 0.084420, 0.046471], 'String', {'Medial', 'orbito-frontal'}, 'HorizontalAlignment', 'center', 'LineStyle', '-', 'EdgeColor', 'w', 'LineWidth', 2};
Arrows.RH.medialorbitofrontal = {'X', [0.167061, 0.191794], 'Y', [0.371353, 0.422353]};
TextBoxes.RH.middletemporal{1} = {'Position', [0.668481, 0.412941, 0.058160, 0.025882], 'String', {'Middle'}, 'HorizontalAlignment', 'center', 'LineStyle', 'none', 'EdgeColor', 'none', 'LineWidth', 2};
TextBoxes.RH.middletemporal{2} = {'Position', [0.680344, 0.394118, 0.073473, 0.030588], 'String', {'temporal'}, 'HorizontalAlignment', 'center', 'LineStyle', 'none', 'EdgeColor', 'none', 'LineWidth', 2};
TextBoxes.RH.parahippocampal{1} = {'Position', [0.336878, 0.340000, 0.104916, 0.031765], 'String', {'Parahippocampal'}, 'HorizontalAlignment', 'center', 'LineStyle', '-', 'EdgeColor', 'w', 'LineWidth', 2};
Arrows.RH.parahippocampal = {'X', [0.342557, 0.325382], 'Y', [0.373118, 0.402353]};
TextBoxes.RH.paracentral{1} = {'Position', [0.277718, 0.544118, 0.074427, 0.047059], 'String', {'Paracentral', 'lobule'}, 'HorizontalAlignment', 'center', 'LineStyle', 'none', 'EdgeColor', 'none', 'LineWidth', 2};
TextBoxes.RH.parsopercularis{1} = {'Position', [0.878023, 0.435294, 0.069458, 0.041880], 'String', {'Pars', 'opercularis'}, 'HorizontalAlignment', 'center', 'LineStyle', '-', 'EdgeColor', 'w', 'LineWidth', 2};
Arrows.RH.parsopercularis = {'X', [0.878817 0.804389312977099], 'Y', [0.456471 0.478823529411765]};
TextBoxes.RH.parsorbitalis{1} = {'Position', [0.845656, 0.340000, 0.057015, 0.039527], 'String', {'Pars', 'orbitalis'}, 'HorizontalAlignment', 'center', 'LineStyle', '-', 'EdgeColor', 'w', 'LineWidth', 2};
Arrows.RH.parsorbitalis = {'X', [0.851107, 0.837786], 'Y', [0.378824, 0.422353]};
TextBoxes.RH.parstriangularis{1} = {'Position', [0.878061, 0.384706, 0.069458, 0.041880], 'String', {'Pars', 'triangularis'}, 'HorizontalAlignment', 'center', 'LineStyle', '-', 'EdgeColor', 'w', 'LineWidth', 2};
Arrows.RH.parstriangularis = {'X', [0.877786 0.826335877862595], 'Y', [0.398824 0.451764705882353]};
TextBoxes.RH.pericalcarine{1} = {'Position', [0.442557, 0.492941, 0.081298, 0.029412], 'String', {'Pericalcarine'}, 'HorizontalAlignment', 'center', 'LineStyle', '-', 'EdgeColor', 'w', 'LineWidth', 2};
Arrows.RH.pericalcarine = {'X', [0.444656, 0.408397], 'Y', [0.495294, 0.455294]};
TextBoxes.RH.postcentral{1} = {'Position', [0.655534, 0.598824, 0.075382, 0.028235], 'String', {'Postcentral'}, 'HorizontalAlignment', 'center', 'LineStyle', '-', 'EdgeColor', 'w', 'LineWidth', 2};
Arrows.RH.postcentral = {'X', [0.695573, 0.713740], 'Y', [0.600000, 0.568235]};
TextBoxes.RH.posteriorcingulate{1} = {'Position', [0.251496, 0.495294, 0.072473, 0.052941], 'String', {'Posterior', 'cingulate'}, 'HorizontalAlignment', 'center', 'LineStyle', 'none', 'EdgeColor', 'none', 'LineWidth', 2};
TextBoxes.RH.precentral{1} = {'Position', [0.704160, 0.567059, 0.075382, 0.028235], 'String', {'Pre-'}, 'HorizontalAlignment', 'center', 'LineStyle', 'none', 'EdgeColor', 'none', 'LineWidth', 2};
TextBoxes.RH.precentral{2} = {'Position', [0.713664, 0.555294, 0.075382, 0.028235], 'String', {'central'}, 'HorizontalAlignment', 'center', 'LineStyle', 'none', 'EdgeColor', 'none', 'LineWidth', 2};
TextBoxes.RH.precuneus{1} = {'Position', [0.325191, 0.512941, 0.081298, 0.029412], 'String', {'Precuneus'}, 'HorizontalAlignment', 'center', 'LineStyle', 'none', 'EdgeColor', 'none', 'LineWidth', 2};
TextBoxes.RH.rostralanteriorcingulate{1} = {'Position', [0.086420, 0.470000, 0.062931, 0.062353], 'String', {'Rostral', 'anterior', 'cingulate'}, 'HorizontalAlignment', 'center', 'LineStyle', '-', 'EdgeColor', 'w', 'LineWidth', 2};
Arrows.RH.rostralanteriorcingulate = {'X', [0.149809, 0.196565], 'Y', [0.494882, 0.454118]};
TextBoxes.RH.rostralmiddlefrontal{1} = {'Position', [0.876076, 0.498824, 0.085756, 0.042353], 'String', {'Rostral middle', 'frontal'}, 'HorizontalAlignment', 'center', 'LineStyle', '-', 'EdgeColor', 'w', 'LineWidth', 2};
Arrows.RH.rostralmiddlefrontal = {'X', [0.87687 0.833969465648855], 'Y', [0.518824 0.496470588235294]};
TextBoxes.RH.superiorfrontal{1} = {'Position', [0.174091, 0.522464, 0.114862, 0.054771], 'String', {'Superior'}, 'HorizontalAlignment', 'center', 'LineStyle', 'none', 'EdgeColor', 'none', 'LineWidth', 2};
TextBoxes.RH.superiorfrontal{2} = {'Position', [0.162641, 0.508346, 0.114862, 0.054771], 'String', {'frontal'}, 'HorizontalAlignment', 'center', 'LineStyle', 'none', 'EdgeColor', 'none', 'LineWidth', 2};
TextBoxes.RH.superiorparietal{1} = {'Position', [0.592595, 0.568235, 0.058168, 0.044706], 'String', {'Superior', 'parietal'}, 'HorizontalAlignment', 'center', 'LineStyle', '-', 'EdgeColor', 'w', 'LineWidth', 2};
Arrows.RH.superiorparietal = {'X', [0.650763, 0.673664], 'Y', [0.580000, 0.560000]};
TextBoxes.RH.superiortemporal{1} = {'Position', [0.708061, 0.422941, 0.071519, 0.030588], 'String', {'Superior'}, 'HorizontalAlignment', 'center', 'LineStyle', 'none', 'EdgeColor', 'none', 'LineWidth', 2};
TextBoxes.RH.superiortemporal{2} = {'Position', [0.722328, 0.407647, 0.066794, 0.031765], 'String', {'temporal'}, 'HorizontalAlignment', 'center', 'LineStyle', 'none', 'EdgeColor', 'none', 'LineWidth', 2};
TextBoxes.RH.supramarginal{1} = {'Position', [0.686115, 0.495294, 0.046710, 0.035294], 'String', {'Supra-', 'marginal'}, 'HorizontalAlignment', 'left', 'LineStyle', 'none', 'EdgeColor', 'none', 'LineWidth', 2};

if(strcmpi(FreesurferSeedType, 'aparc'))
	TextBoxes.RH.frontalpole{1} = {'Position', [0.093061, 0.407059, 0.050069, 0.046471], 'String', {'Frontal', 'pole'}, 'HorizontalAlignment', 'center', 'LineStyle', '-', 'EdgeColor', 'w', 'LineWidth', 2};
	Arrows.RH.frontalpole = {'X', [0.144084, 0.159351], 'Y', [0.417824, 0.424706]};
	TextBoxes.RH.temporalpole{1} = {'Position', [0.179969, 0.332941, 0.060198, 0.044882], 'String', {'Temporal', 'pole'}, 'HorizontalAlignment', 'center', 'LineStyle', '-', 'EdgeColor', 'w', 'LineWidth', 2};
	Arrows.RH.temporalpole = {'X', [0.241412, 0.258588], 'Y', [0.361353, 0.377647]};
end

TextBoxes.RH.transversetemporal{1} = {'Position', [0.551305, 0.514118, 0.069840, 0.048235], 'String', {'Transverse', 'temporal'}, 'HorizontalAlignment', 'center', 'LineStyle', '-', 'EdgeColor', 'w', 'LineWidth', 2};
Arrows.RH.transversetemporal = {'X', [0.6211, 0.734733], 'Y', [0.534118, 0.460000]};
TextBoxes.RH.insula{1} = {'Position', [0.747183, 0.434118, 0.046710, 0.031765], 'String', {'Insula'}, 'HorizontalAlignment', 'center', 'LineStyle', 'none', 'EdgeColor', 'none', 'LineWidth', 2};
