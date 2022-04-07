# BIND annotation
##### BIND = Braker combined with gene predictions INferred Directly
## Still under development
## Scripts, notes and documents about the BIND annotation workflow (BIND: ab initio gene predictions by BRAKER combined with gene predictions INferred Directly from alignment of RNA-Seq evidence to the genome.) 
[Published December 20, 2021](https://doi.org/10.1093/nar/gkab1238) [GitHub Repo](https://github.com/eswlab/orphan-prediction)

## Overview of Steps
Step 1: Download data from SRA
Step 2: SRA data quality control
Step 3: Whole genome quality control
Step 4: Align reads to a reference genome
Step 5: Genome guided transcriptome assemblies
Step 6: 

#### Note: I recommend that you review the [challenges document/scripts](https://github.com/PeanutBase/BIND_annotation/tree/main/challenges#readme).

[Step 1: Download data from SRA](https://github.com/PeanutBase/BIND_annotation/tree/main/scripts/download_data)

[Step 2: Run fastqc, trim reads and concatenate reads together](https://github.com/PeanutBase/BIND_annotation/tree/main/scripts/trim_data)

Step 3: Ensure fasta header names in reference genome ***do not*** have the following items:
* Training white space
* White space between numbers or letters
* A colon 
* An underscore

[Step 4: Align reads to a reference genome & generate a BAM file](https://github.com/PeanutBase/BIND_annotation/tree/main/scripts/generate_bam)
* Examples of alignment programs
  * STAR
  * HiStat2
  * TopHat2
* If using both Paired-end and Single end reads: merge PE and SE BAM files and sort combined BAM files
* If combined BAM file is larger than 100 GB it is recommened to split the BAM file by chromsome 
  * A large BAM file could take weeks to finish. See [challenges](https://github.com/PeanutBase/BIND_annotation/tree/main/challenges#readme).

[Step 5: Use BAM file for input for multiple genome guided transcriptome assembliers, get GFF3/GTF files as output](https://github.com/PeanutBase/BIND_annotation/tree/main/scripts/generate_GFF)
* Examples of genome guided transcriptome assembly programs
  * Cufflinks
  * Class2
  * Strawberry
  * StringTie
  * Note: Not recommonded to use Trinity because it generartes too many small incomplete transcripts 

[Step 6: Run Portcullis for splice junctions analysis](https://github.com/PeanutBase/BIND_annotation/blob/main/scripts/portcullis.sh)

[Step 7: Mikado pipeline & Quality control of Mikado pipeline output](https://github.com/PeanutBase/BIND_annotation/tree/main/scripts/mikado)

[Step 8: BRAKER & Filter TE sequences](https://github.com/PeanutBase/BIND_annotation/tree/main/scripts/braker)
* **NOTE:** There are multiple ways to run BRAKER. I recommend reviewing documentation for [BRAKER2](https://github.com/Gaius-Augustus/BRAKER#keys-to-successful-gene-prediction) and review [BRAKER2 tutorial](https://bioinformaticsworkbook.org/dataAnalysis/GenomeAnnotation/Intro_to_Braker2.html#gsc.tab=0)
  * [Manual](https://github.com/Gaius-Augustus/BRAKER#braker-with-rna-seq-data) about BRAKER with RNA-Seq data
    * [Scripts and notes in this repo](https://github.com/PeanutBase/BIND_annotation/blob/main/scripts/braker/README.md) about running BRAKER with RNA-Seq data only
  * [Manual](https://github.com/Gaius-Augustus/BRAKER#braker-with-rna-seq-and-protein-data) about BRAKER with RNA-Seq and Protein data
    * [Scripts and notes in this repo](https://github.com/PeanutBase/BIND_annotation/blob/main/scripts/braker/version2/braker-predictions.md) about running BRAKER with RNA-Seq and protein data

[Step 9: Merge & Filter -- Mikado output & BRAKER output]


## Tools needed: 

| Tool  | Purpose |
| ------------- | ------------- |
| [SRA Toolkit](https://github.com/ncbi/sra-tools)(v )| SRA access |
| [FASTQC](https://github.com/s-andrews/FastQC) (v ) | Quality Control |
| [Trimmomatic](https://github.com/timflutre/trimmomatic) (v ) | Quality Control |
| [STAR](https://github.com/alexdobin/STAR) (v ) | Alignment |
| [SamTools](https://github.com/samtools/samtools) (v ) | Tool |
| [Strawberry](https://github.com/ruolin/strawberry) (v1.1.1) | Transcript Assembly  |
| [CLASS2](http://ccb.jhu.edu/people/florea/research/CLASS2/) (v ) | Transcript Assembly  |
| [StringTie](https://github.com/gpertea/stringtie) (v ) | Transcript Assembly  |
| [Cufflinks](http://cole-trapnell-lab.github.io/cufflinks/) (v ) | Transcript Assembly  |
| [Portcullis](https://github.com/EI-CoreBioinformatics/portcullis) (v ) | Splice junctions |
| [Mikado](https://github.com/EI-CoreBioinformatics/mikado) (v ) | Direct Inference prediction |
| [Transdecoder](https://github.com/TransDecoder/TransDecoder) (v ) | CDS prediction |
| [TeSorter](https://github.com/zhangrengang/TEsorter) (v ) | identify retrotransposons |
| [Kallisto](https://pachterlab.github.io/kallisto/) (v ) | Quality Control |
| [Braker](https://github.com/Gaius-Augustus/BRAKER) (v ) | *Ab initio* prediction |
| [GeneMark](http://exon.gatech.edu/GeneMark/) (v ) | *Ab initio* prediction |

## Flow Chart



