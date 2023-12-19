/*
* This process puts each fasta sequence on a single line (1 line = 1 sequence).
* Thus, it makes it possible to avoid multiple lines for fasta sequences.
* The end goal is to be able to easily analyze stop codons
*
* Script:
*	- ml_to_sl_fasta.sh
* Input:
*	- *.fasta
* Output:
*	- SL_file_*.fasta (single line)
*
* Utilisation of seqkit/2.6.1 (https://bioinf.shenwei.me/seqkit/)
*/

process MLtoSLfasta {

	tag "fasta sequence on one line"

	label 'seqkit'
	
	input:
		path fasta

	output:
		path "SL_*", emit: fasta_sl

	script:
	"""
	
	ml_to_sl_fasta.sh "$fasta"
	
	"""
}