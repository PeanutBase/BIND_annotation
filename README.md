# BIND_annotation
**Still under development: adding and editing scripts**

Scripts, notes and documents about the BIND annotation workflow (BIND: ab initio gene predictions by BRAKER combined with gene predictions INferred Directly from alignment of RNA-Seq evidence to the genome.)

[Step 1: Download data from SRA](https://github.com/PeanutBase/BIND_annotation/tree/main/scripts/download_data)

[Step 2: Run fastqc, trim reads and concatenate reads together](https://github.com/PeanutBase/BIND_annotation/tree/main/scripts/trim_data)

Step 3: Ensure fasta header names in reference genome do not have the following items:
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
  * A large BAM file could take weeks to finish 

[Step 5: Use BAM file for input for multiple genome guided transcriptome assembliers, get GFF3/GTF files as output](https://github.com/PeanutBase/BIND_annotation/tree/main/scripts/generate_GFF)
* Examples of genome guided transcriptome assembly programs
  * Cufflinks
  * Class2
  * Strawberry
  * StringTie
  * Note: Not recommonded to use Trinity because it generartes to many small incomplete transcripts 

Step 6: Run Portculli for splice junctions analysis

[Step 7: Mikado pipeline](https://github.com/PeanutBase/BIND_annotation/tree/main/scripts/mikado)

[Step 8: Quality control of Mikado pipeline output](https://github.com/PeanutBase/BIND_annotation/tree/main/scripts/DI_quality_control)

