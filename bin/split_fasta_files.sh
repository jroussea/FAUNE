#!/usr/bin/env bash

# file    : split_fasta_files.sh
# time    : 2023/12/18
# author  : Jeremy Rousseau
# version : 1.0
# desc    : 

# Goal: Split the fasta files into X files containing a maximum of 10000 sequences

# Input:
# 	- fasta file
# Output:
#	- split fasta file

# Utilisation of seqkit/2.6.1 (https://bioinf.shenwei.me/seqkit/)

# fasta file list
lst=${1}

for file in $lst
do

# file_*
name_int=${file::-6}
name=`echo $name_int | cut -d "_" -f 3-`

# Creation of a folder for each file containing a correspondence table
# between the original names and the new names for the fasta sequences
mkdir $name

# split of fasta files (10000 per file)
seqkit split2 $file -O $name -f -s 10000

done