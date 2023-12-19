/*
* InterProScan 5: genome-scale protein function classification
*
* Script:
*	- 
* Input:
*	- fasta file
* Output:
*	- functional and structural annotation files (TSV, GFF3, XML and JSON) 
*/

process InterProScan {

	tag "InterProScan"

	label 'interproscan'

	publishDir "${params.outdir}/interproscan/TSV", mode: 'link', pattern: "*.tsv"
	publishDir "${params.outdir}/interproscan/GFF3", mode: 'link', pattern: "*.gff3"
	publishDir "${params.outdir}/interproscan/XML", mode: 'link', pattern: "*.xml"
	publishDir "${params.outdir}/interproscan/JSON", mode: 'link', pattern: "*.json"

	input:
		path fasta_split

	output:
		path "*.tsv"
		path "*.gff3"
		path "*.xml"
		path "*.json"

	script:
	"""

	run_interproscan.sh "$fasta_split" ${task.cpus}

	"""
}

