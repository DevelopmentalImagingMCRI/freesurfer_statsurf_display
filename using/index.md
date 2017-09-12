---
layout: default
title: Using freesurfer_statsurf_display
---
<br>
{: .content}

# Using

The following functions can be called to create a specific display type:

* *p*-values: `freesurfer_statsurf_p(PValues, TValues, FreesurferSeedType, NAME/VALUE OPTIONS ...)`
* Scalars: `freesurfer_statsurf_scalar(Values, ValuesMask, FreesurferSeedType, NAME/VALUE OPTIONS ...)`
* R squared: `freesurfer_statsurf_rsq(RSQ, RSQMask, FreesurferSeedType, NAME/VALUE OPTIONS ...)`
* Effect sizes: `freesurfer_statsurf_effectsize(EffectSizes, EffectSizesMask, FreesurferSeedType, NAME/VALUE OPTIONS ...)`
* Freesurfer colours: `freesurfer_statsurf_fsrgb(RegionMask, FreesurferSeedType, NAME/VALUE OPTIONS ...)`

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

* 'GroupLabels' (cell array of strings) [2]: labels for the two groups, {'Group 1', 'Group 2'} by default