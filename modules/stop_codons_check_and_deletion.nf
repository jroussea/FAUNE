/*
* Process to remove asterisks (stop codon)
* The goal of the process is to remove the stop codons located at the end of the sequences.
* In addition it also removes sequences with stop codons in the middle
*
* Script:
*	- stop_codons_check_deletion.sh
* Input:
*	- SL_RENAME_file_*.fasta
* Output:
*	- checking_stop_codon.tsv
*	- RMast_SL_RENAME_file_*.fasta
*/

process StopCodonsCheckDeletion {

	tag "check stop codons"

	label 'seqkit'

	publishDir "${params.outdir}", mode: 'link', pattern: "*.tsv"

	input:
		path fasta_sl

	output:
		path "checking_stop_codon.tsv", emit: dataframe_stop_codon
		path "RMast_SL_*", emit: fasta_sl_rm

	script:
	"""

	stop_codons_check_deletion.sh "$fasta_sl"

	"""
}