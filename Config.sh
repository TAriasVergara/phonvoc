#!/bin/sh
#
# Copyright 2015 by Idiap Research Institute, http://www.idiap.ch
# See the file COPYING for the licence associated with this software.
#
# Author(s):
#   Milos Cernak, Sept. 2015
#

# Allow setshell
software=/idiap/resource/software
source $software/initfiles/shrc $software

# SETSHELLs; replace it with your local
# export KALDI_ROOT=
# export SSP_ROOT=
SETSHELL grid
SETSHELL kaldi-gpu
# some speech common libraries
. /idiap/group/speech/common/lib/profile.sh

# Check for KALDI; add it to the path
if [ "$KALDI_ROOT" = "" ]
then
    echo
    "Please \"SETSHELL kaldi\" or point \$KALDI_ROOT to an KALDI
installation"
    exit 1
fi
# Check for SSP; add it to the path
if [ "$SSP_ROOT" = "" ]
then
    echo
    "Please install https://github.com/idiap/ssp and set \$ISS_ROOT"
    exit 1
fi

# IDIAP
export extract_cmd="queue.pl "
export train_cmd="queue.pl -l q1d,h_vmem=2G"
export decode_cmd="queue.pl -l q1d,h_vmem=2G"
export decode_nnet_cmd="queue.pl -l q1d,h_vmem=2G -v LD_LIBRARY_PATH"
export decode_big_cmd="queue.pl -l q1d,h_vmem=4G"
export mkgraph_cmd="queue.pl -l q1d,h_vmem=4G"
export cuda_cmd="queue.pl -l gpu"

export PATH=$PWD/utils/:$PWD:$PATH
export LC_ALL=C

# English training data
wsj0=/idiap/resource/database/WSJ0
wsj1=/idiap/resource/database/WSJ1

export N_JOBS=30

################################################################
### PHONVOC SETTINGS ###

# phonological speech representation
## GP       - Government Phonology of Harris and Lindsey (1995)
## SPE      - Sound Patter of English of Chomsky and Halle (1968)
## eSPE     - extended SPE
export phon=SPE

# language  - used training database for phonological analysis
## English  - WSJ db
## French   - Ester db
## Mandarin - Emime db
export lang=English

# synthesis voice
## English - Nancy voice (16.6 hours female voice)
export voice=Nancy

# Re-synthesis vocoder
## LPC     - Idiap open source LPC
## AHO     -
# export vocod=LPC
export vocod=cepgm
# training parameters
export lrate=0.001
export hlayers=4
export hdim=1024
# phonetic and phonological parametrization
# parametrization | paramType
# phonetic        | 0
# phonological    | 1
# phonetic+phonol.| 2
export paramType=2
