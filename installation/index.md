---
layout: default
title: Installation
---
<br>
{: .content}

# Installing MANTiS
MANTiS is provided as a combination of matlab and c++ code. It needs to be built for your
platform. So far we have only tested on Linux systems. In principle it should also work
on OSX if SPM works.

## Prerequisites
The build process requires the following tools:

1. git
1. cmake
1. c++ compiler

## Decisions to make
MANTiS eventually needs to reside in the _spm/toolbox_ folder. You can carry out the commands
below in that folder or perform them elsewhere and copy the results to _spm/toolbox_. The 
advantage of doing everything in the _spm/toolbox_ is that it is easier to update the installation.

## Downloading
The source code must be fetched using _git_, and there are several steps. Type the following into
a terminal. These commands fetch the MANTiS code, plus some dependencies.

``` bash
git clone https://github.com/DevelopmentalImagingMCRI/mantis.git
cd mantis
git submodule init
git submodule update
```

Updates to mantis can be fetched using

``` bash
git pull
```

Updates to c++ parts will require a rebuild to take effect.

## Developers

[MANTiS is hosted on github](https://github.com/DevelopmentalImagingMCRI/mantis)

## Build ITK components
The following commands use the SuperBuild process, that fetches a
specific ITK version and builds it. This takes a while. If you know
what you are doing you may be able to use a system version of
ITK. Make sure you match up the installation directory with the
SuperBuild version

The build process requires cmake and git and a compiler.

``` bash
cd ITKStuff
```

On linux/mac:

``` bash
## Make a build directory with the matlab architecture in the name

export ARCH=$(echo "disp(sprintf('\n%s', computer)),quit" | matlab -nojvm -nodesktop -nosplash |tail -1)

mkdir Build.${ARCH} 
```

Finally, trigger a build:

``` bash
cd Build.${ARCH}

cmake ../SuperBuild
## increase if you have lots of cores
make -j2
```

executables named _segCSF_ , _cleanWM_ and _neonateScalper_ will be in

``` bash
mantis/ITKStuff/Build.${ARCH}/MANTiS-build/bin/
```

You can delete build files to save space:

``` bash

rm -rf ITK-build ITK-prefix ITK

```

