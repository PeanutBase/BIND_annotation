module load star/2.7.11b

# Input Agruements
GNM="$1"
READS="$2" # manifest.tsv


STAR \
--runThreadN 20 \
--genomeDir /project/legume_project/jacqueline.campbell/Mikado_transcriptome/02.star.genomes/"$GNM" \
--readFilesManifest /project/legume_project/jacqueline.campbell/Mikado_transcriptome/03.star.align/"$READS" \
--readFilesCommand zcat \
--outFileNamePrefix "$GNM".rd1. \
--outSAMtype None 


## slurm job trick: You can submit star.PE.rd2.sh right after star.PE.rd1.sh by using "sbatch --dependency=afterok:" 
### EXAMPLE: sbatch --dependency=afterok:5136041 star.PE.rd2.sh (where '5136041' is star.PE.rd1.sh job number
