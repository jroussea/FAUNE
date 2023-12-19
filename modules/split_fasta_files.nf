/*
* 
* Split the fasta files into X files containing a maximum of 10000 sequences
*
* Script:
*	- split_fasta_file.sh
* Input:
*	- *.fasta
* Output:
*	- RMast_SL_*.part_*.fasta
*
* Utilisation of seqkit/2.6.1 (https://bioinf.shenwei.me/seqkit/)
*/

process SplitFastaFiles {

	tag "split fasta files"

	label 'seqkit'

	publishDir "${params.data}", mode: 'link', pattern: '*/*.part_*.fasta'

	input:
		path fasta_sl_rm

	output:
		path "*/*.part_*.fasta", emit: fasta_split

	script:
	"""

	split_fasta_files.sh "$fasta_sl_rm"
	
	"""
}