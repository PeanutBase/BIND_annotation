#!/bin/bash
source /work/LAS/mhufford-lab/arnstrm/miniconda/etc/profile.d/conda.sh
source /work/LAS/mhufford-lab/arnstrm/programs/sourceme
conda activate braker

genome=$(find $(pwd) -name "*.softmasked.fasta")
rnaseq=hintsfile.gff
proteins=protein_alignment_gth.gff3

today=$(date +"%Y%m%d")
name=$(basename $(pwd))
profile="${name}_prot-rna_${today}.1"
GENEMARK_PATH="/work/LAS/mhufford-lab/arnstrm/programs/genemark-et-4.33/bin"

braker.pl \
   --genome=$genome \
   --hints=$rnaseq \
   --prot_aln=${proteins} \
   --prg=gth \
   --gth2traingenes \
   --species=${profile} \
   --softmasking \
   --cores 36
