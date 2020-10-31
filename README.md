# BIND_annotation
Scripts, notes and documents about the BIND annotation workflow (BIND: ab initio gene predictions by BRAKER combined with gene predictions INferred Directly from alignment of RNA-Seq evidence to the genome.)

[Step 1: Download data from SRA](https://github.com/PeanutBase/BIND_annotation/tree/main/scripts/download_data)

[Step 2: Run fastqc, trim reads and concatenate reads together](https://github.com/PeanutBase/BIND_annotation/tree/main/scripts/trim_data)

Step 3: Ensure fasta header names in reference genome do not have the following items:
* Training white space
* A colon 
* An underscore

[Step 4: If EST data is available: prepare ESTs data and align to reference genome](https://github.com/PeanutBase/BIND_annotation/tree/main/scripts/prepare_ESTs)

Step 5: If PacBio data is available: prepare PacBio data and align to reference genome


Step #: Align reads to a reference genome & generate a BAM file 
* Examples of alignment programs
  * STAR
  * HiStat2
  * TopHat2
* If using both Paired-end and Single end reads: merge and sort BAM files
* If combined BAM file is larger than 100 GB it is recommened to split the BAM file by chromsome 
  * A large BAM file could take weeks to finish 
