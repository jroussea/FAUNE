#!/usr/bin/env bash

# file    : stop_codons_check_deletion.sh
# time    : 2023/12/18
# author  : Jeremy Rousseau
# version : 2.0
# desc    : 

# Goal: filter asterisks present in sequences in order to use tools such as InterProScan

# Input:
# 	- fasta file with sequences on one line
# Output:
#	- fasta file no longer containing an asterisk (or stop codon)
#	- TSV file containing the information: number of total sequence before and after filtration;
#			sequence number with an asterisk at the end;
#			sequence number with at least one asterisk in the middle

# WARNING: it is possible that sequences with asterisks in the middle of the sequence also have them at the end.
#		   thus, the sum of columns A and B does not correspond to the total number of sequence with an asterisk

# Utilisation of seqkit/2.6.1 (https://bioinf.shenwei.me/seqkit/)

# Fasta file list
lst=${1}

# Creation of the table: checking_stop_codon.tsv
if [ -f "checking_stop_codon.tsv" ]
then
	echo "checking_stop_codon.tsv exists"
else
	echo -e "data_name\tnumber_sequences\tnumber_sequences_with_asterisk_end\tnumber_sequences_with_asterisk_middle\tnumber_sequences_after_filtration" > checking_stop_codon.tsv
fi


for file in $lst
do

# Recovery of the file name, example: file_1.fasta, file_2.fasta, ...
file_name=`echo $file | cut -d "_" -f 2-`

# Total number of sequences in file
seq=`grep -c ">" $file` 

# Total number of sequence with asterisks at the end
EndStar=`grep -c "*$" $file` 
# Remove asterisks at the end of sequences
sed "s/\*$//g" $file -i

# Counts sequences with at least one asterisk in the middle
MiddleStar=`grep -c "*" $file`
# Remove sequences with at least one asterisk in the middle
seqkit grep --by-seq --invert-match --pattern '*' $file > RMast_$file # RMast = ReMove asterisks

# Total number of sequences after filtration
seqEnd=`grep -c ">" RMast_$file`

# Saving the different information in the table: checking_stop_codon.tsv
echo -e $file_name"\t"$seq"\t"$EndStar"\t"$MiddleStar"\t"$seqEnd >> checking_stop_codon.tsv

done