# FLORE: Functional and structuraL annOtation of pRotEins

## Description

FLORE is a nextflow workflow allowing you to carry out a functional and structural annotation of one or more protein sequences present in a fasta file. \
To do this, it uses [InterProScan5](https://interproscan-docs.readthedocs.io/en/latest/) which allows you to scan several databases such as Pfam, CATH-Gene3D, SUPERFAMILY. \
FLORE thus makes it possible to obtain information for the sequences. \
It also allows you to obtain, thanks to [InterProScan5](https://interproscan-docs.readthedocs.io/en/latest/), the GO annotations as soon as they are available.

## Utilisation

### Step 1 - Singularity
Construction of containers with [Singularity](https://docs.sylabs.io/guides/4.0/user-guide/):
```bash
bash build_container.sh 
```

### Step 2 - Run 

To get help:
```bash
nextflow run main.nf --help
```
To carry out the functional and structural annotation:
```bash
nextflow run main.nf --fasta /path/your/fasta/file.fasta -profile custom,singularity
```
* *--fasta*: allows you to indicate the location of the fasta file
* *--profile custom,singularity*: needed to run the workflow

To test the workflow:
```bash
nextflow run main.nf -profile test,singularity
```

## Citation

[SeqKit](https://bioinf.shenwei.me/seqkit/):
* W Shen, S Le, Y Li*, F Hu*. SeqKit: a cross-platform and ultrafast toolkit for FASTA/Q file manipulation. PLOS ONE. doi:10.1371/journal.pone.0163962.

[InterProScan5](https://interproscan-docs.readthedocs.io/en/latest/) and [InterPro](https://www.ebi.ac.uk/interpro/):
* The InterPro protein families and domains database: 20 years on Matthias Blum, Hsin-Yu Chang, Sara Chuguransky, Tiago Grego, Swaathi Kandasaamy, Alex Mitchell, Gift Nuka, Typhaine Paysan-Lafosse, Matloob Qureshi, Shriya Raj, Lorna Richardson, Gustavo A Salazar, Lowri Williams, Peer Bork, Alan Bridge, Julian Gough, Daniel H Haft, Ivica Letunic, Aron Marchler-Bauer, Huaiyu Mi, Darren A Natale, Marco Necci, Christine A Orengo, Arun P Pandurangan, Catherine Rivoire, Christian J A Sigrist, Ian Sillitoe, Narmada Thanki, Paul D Thomas, Silvio C E Tosatto, Cathy H Wu, Alex Bateman, Robert D Finn Nucleic Acids Research (2020), gkaa977, PMID: 33156333
* InterProScan 5: genome-scale protein function classification Philip Jones, David Binns, Hsin-Yu Chang, Matthew Fraser, Weizhong Li, Craig McAnulla, Hamish McWilliam, John Maslen, Alex Mitchell, Gift Nuka, Sebastien Pesseat, Antony F. Quinn, Amaia Sangrador-Vegas, Maxim Scheremetjew, Siew-Yit Yong, Rodrigo Lopez, Sarah Hunter Bioinformatics (2014), PMID: 24451626