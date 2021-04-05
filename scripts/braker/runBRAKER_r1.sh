#!/bin/bash
source /work/LAS/mhufford-lab/arnstrm/miniconda/etc/profile.d/conda.sh
source /work/LAS/mhufford-lab/arnstrm/programs/sourceme
#cp /work/LAS/mhufford-lab/arnstrm/programs/gm_key_64 ~/.gm_key
conda activate braker
genome="$1" # hard-masked
bam="$2" # RNAseq aligned bam
proteins="$3" # proteins fasta
nam=$(echo ${bam%.*} | sed 's/merged_//g')
today=$(date +"%Y%m%d")
echo "the profile created is: ${nam}_prot-rna_${today}.1"
GENEMARK_PATH="/work/LAS/mhufford-lab/arnstrm/programs/genemark-et-4.33/bin"
braker.pl \
   --genome=$genome \
   --bam=$bam \
   --prot_seq=${proteins} \
   --prg=gth \
   --gth2traingenes \
   --species=${nam}_prot-rna_${today}.1 \
   --cores 36 \
   --gff3
