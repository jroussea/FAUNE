#!/usr/bin/env nextflow

/*
=============================================================================================
FAUNE: Functional And strUcturaL aNntation of protEins 
Workflow Nextflow to easily functionally and structurally annotate proteins with interproscan
=============================================================================================
*/

// Enable modules
nextflow.enable.dsl = 2

def helpMessage() {
	log.info ABIHeader()
	log.info """
	FAUNE: Functional And strUcturaL aNntation of protEins 
	- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	Description: Workflow Nextflow to easily functionally and structurally
				 annotate proteins with interproscan
	=============================================================================

			The typical command to run the pipeline is:
				nextflow run main.nf -c nextflow.config -profile custom [params]
	
		Setting [params]
	Mandatory:
		--fasta         : path containing the fasta file to analyze
	"""
}

if (params.help) {
	helpMessage()
	exit 0
}

// check if fasta path exist
fasta_path = file(params.fasta)
if ( !fasta_path.exists() )
    exit 1, helpMessage()


// Import modules
include { MLtoSLfasta                  } from './modules/ml_to_sl_fasta.nf'
include { StopCodonsCheckDeletion      } from './modules/stop_codons_check_and_deletion.nf'
include { SplitFastaFiles              } from './modules/split_fasta_files.nf'
include { InterProScan                 } from './modules/interproscan.nf'

// channel initialization
fasta_file_ch = Channel.fromPath(params.fasta, checkIfExists: true)

/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	RUN WORKFLOW
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/

workflow {

	// ------------------------------------------------------------
	// Preparation of fasta files
	// ------------------------------------------------------------

	// Converting multi-line fasta files to single-line fasta files
	fasta_sl_ch = MLtoSLfasta(fasta_file_ch)

	// Checking and removing asterisks in sequences (stop codon)
	StopCodonsCheckDeletion(fasta_sl_ch)
	fasta_sl_rm_ch = StopCodonsCheckDeletion.out.fasta_sl_rm

	// Split files fasta (10000 sequences per files)
	SplitFastaFiles(fasta_sl_rm_ch)
	fasta_sl_rm_split_ch = SplitFastaFiles.out.fasta_split

	// ------------------------------------------------------------
	// Functional annotation -- InterProScan
	// ------------------------------------------------------------

	// run interproscan
	InterProScan(fasta_sl_rm_split_ch)
}

/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	END
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/

workflow.onComplete {

	println "- Workflow info: FAUNE workflow completed successfully -"

	log.info ABIHeader()
}


workflow.onError = {

    println "- Workflow info: FAUNE workflow completed with errors -"

	log.info ABIHeader()
}

def ABIHeader() {
	return """ 
		========================================
			  ╔═══╗ ╔═══╗   ╔═╗
			  ║╔═╗║ ║╔═╗║   ╚═╝
			  ║╚═╝║ ║╚═╝╚═╗ ╔═╗
			  ╠═══╣ ║ ╔═╗ ║ ║ ║
			  ║   ║ ║ ╚═╝ ║ ║ ║
			  ╩   ╩ ╚═════╝ ╚═╝
	              (https://bioinfo.mnhn.fr/abi/)
		========================================
	"""
	.stripIndent()
}
