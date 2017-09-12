---
layout: default
title: Using freesurfer_statsurf_display
---
<br>
{: .content}

# Using

The following functions can be called to create a specific display type:

*<I>p</I>-values: `freesurfer_statsurf_p(PValues, TValues, FreesurferSeedType, NAME/VALUE OPTIONS ...)`
*Scalars: `freesurfer_statsurf_scalar(Values, ValuesMask, FreesurferSeedType, NAME/VALUE OPTIONS ...)`
*R squared: `freesurfer_statsurf_rsq(RSQ, RSQMask, FreesurferSeedType, NAME/VALUE OPTIONS ...)`
*Effect sizes: `freesurfer_statsurf_effectsize(EffectSizes, EffectSizesMask, FreesurferSeedType, NAME/VALUE OPTIONS ...)`
*Freesurfer colours: `freesurfer_statsurf_fsrgb(RegionMask, FreesurferSeedType, NAME/VALUE OPTIONS ...)`

The arguments `PValues, TValues, Values, ValuesMask, RSQ, RSQMask, RegionMask, EffectSizes, EffectSizesMask` must be two-element cell arrays with element 1 contains the left hemisphere values  and element 2 containing right hemisphere values. Each cell array element must be a vector of size corresponding to the number of labels in the parcellation scheme chosen in FreesurferSeedType. The parcellation schemes supported are as follows:

*'aparc'`: Desikan-Killiany, 34 elements per hemisphere, lable names in seedtype_aparc.txt
*'dkt'`: Desikan-Killiany-Tourville, 31 elements per hemisphere, lable names in seedtype_dkt.txt
*'aparc.a2009s'`: Destreiux, 75 elements per hemisphere, lable names in seedtype_aparc.a2009s.txt


The non-"Mask" arguments `PValues, TValues, Values, RSQ, RegionMask, EffectSizes` contain values for the relevant and may be any numeric type. The "Mask" arguments `ValuesMask, RSQMask, RegionMask, EffectSizesMask` must be of type `logical` such that only elements that are true will be coloured, elements that are false will be grey.

## NAME/VALUE OPTIONS

There are a number of NAME/VALUE options that are common to all plot types. 

# Detailed synopsis

## P-value display

`freesurfer_statsurf_p(PValues, TValues, FreesurferSeedType, NAME/VALUE OPTIONS ...)`

The <I>p</I>-value plot is intended to colour statistically significant regions after hypothesis testing. The `PValues` argument contains the <I>p</I>-values for each region. The `TValues` contains the values of the test statistic. The sign of the test statistic, based on a 2-group test, values will be used to separate "Group 1 > Group 2" (positive test statistic) and "Group 2 > Group 1" (negative test statistic).

### Specific NAME/VALUE arguments

<UL>
<LI>'GroupLabels' (cell array of strings) [2]: labels for the two groups, {'Group 1', 'Group 2'} by default
</UL>

<UL>
<LI>Scalars: `freesurfer_statsurf_scalar(Values, ValuesMask, FreesurferSeedType, NAME/VALUE OPTIONS ...)`
<LI>R squared: `freesurfer_statsurf_rsq(RSQ, RSQMask, FreesurferSeedType, NAME/VALUE OPTIONS ...)`
<LI>Effect sizes: `freesurfer_statsurf_effectsize(EffectSizes, EffectSizesMask, FreesurferSeedType, NAME/VALUE OPTIONS ...)`
<LI>Freesurfer colours: `freesurfer_statsurf_fsrgb(RegionMask, FreesurferSeedType, NAME/VALUE OPTIONS ...)`
</UL>

## Getting started

MANTiS is an SPM toolbox and can be accessed as follows.

1. Select mantis from the toolbox dropdown menu:
![mantis from toolbox menu](https://github.com/DevelopmentalImagingMCRI/mantis/raw/master/Instructions/mantis_toolbox_menu.png)
1. Select the complete pipeline option to load the pipeline in the batch editor.
![mantis from local menu](https://github.com/DevelopmentalImagingMCRI/mantis/raw/master/Instructions/mantis_menu2.png)
1. Select scalped T2 structural scans from the batch editor file selection:
![mantis from batch](https://github.com/DevelopmentalImagingMCRI/mantis/raw/master/Instructions/mantis_file_selection.png)
1. Click the green run button, and wait. The results for each phase will be stored in two folders, named Phase1 and Phase2.
1. The components from which the pipeline is constructed are available from the batch editor tools menu.

## Brain Extraction
[A preliminary tool:](extraction) is available for brain extraction in
T2 weighted images.

## Setting image origin
SPM segmentation utilises the image origin from the nifti files if it
is set on the assumption that is positioned similarly to the origin of
standard space. Strange results can occur if this isn't the
case. [A tool for setting image origin:](origin) based on the centre
of mass of the brain is available. It should be applied to brain
extracted images.

# Preprocessing pipeline
A pipeline performing brain extraction and origin setting can be
constructed in the batch editor as per the image below:

![Brain extraction tool](https://github.com/DevelopmentalImagingMCRI/mantis/raw/gh-pages/img/mantis_scalp_com.png)

Make sure that the input volumes for the "Origin to COM" tool are set using the *Dependency* button and select *Simple watershed scalping: scalped structurals* from the options.

Check the output images for successful scalping, then feed into MANTiS tissue classification.

# Changing templates
The template image used by mantis is specified in a defaults file: *mantis/cg\_mantis\_defaults.m*
A custom template can be used by changing the *mantis.opts.tpm* and *mantis.opts.tpm2*
variables in this file to reference your own template. The components
of the custom template must match those in the original (at least for
gray, white and csf tissue classes), and changes will affect all
toolbox users. Use multiple copies of the toolbox to simultaneously
test different templates.
