#!/usr/bin/env bash

# file    : interproscan.sh
# time    : 2023/12/18
# author  : Jeremy Rousseau
# version : 1.0
# desc    : 

# Goal: InterProScan 5: genome-scale protein function classification

# Input:
# 	- fasta file
# Output:
#	- functional and structural annotation files (TSV, GFF3, XML and JSON)

# Utilisation of interproscan/5.65-97.0 (https://interproscan-docs.readthedocs.io/en/latest/)

# fasta file list
lst=${1}
cpu=${2}

echo $lst
echo $cpu

for i in $lst
do

name_tmp=`echo $i | cut -d "_" -f 3-`
name=${name_tmp::-6}

echo $name_tmp
echo $name

interproscan.sh -i $i -b $name -f tsv gff3 xml json --goterms --pathways --seqtype p --cpu $cpu

done

for i in $lst
do

name_tmp=`echo $i | cut -d "_" -f 3-`
name=${name_tmp::-15}

cat $name*.tsv > $name.tsv
sed -i '1iprotein_accession\tsequence_MD5_digest\tsequence_length\tanalysis\tsignature_accession\tsignature_description\tstart_location\tstop_location\tscore\tstatus\tdate\tinterpro_accession\tinterpro_description\tgo_annotation\tpathways_annotation' $name.tsv
cat $name*.gff3 > $name.gff3
cat $name*.xml > $name.xml
cat $name*.json > $name.json

rm $name.part*.tsv
rm $name.part*.gff3
rm $name.part*.xml
rm $name.part*.json

done