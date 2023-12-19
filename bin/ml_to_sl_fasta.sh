#!/usr/bin/env bash

# file    : ml_to_sl_fasta.sh
# time    : 2023/12/18
# author  : Jeremy Rousseau
# version : 1.0
# desc    : 

# Goal: put the fasta sequences on a single line in order to simplify the search for stop codons

# Input:
# 	- folder containing files renamed
# Output:
#	- fasta file with sequences on a single line (1 line = 1 sequence)

# Utilisation of seqkit/2.6.1 (https://bioinf.shenwei.me/seqkit/)

# fasta file list
lst=${1}

for i in $lst
do

seqkit seq -w0 $i > SL_$i

done