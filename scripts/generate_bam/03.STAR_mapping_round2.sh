module load star/2.7.11b

# Input Agruements
GNM="$1"
READS="$2" # manifest.tsv

STAR \
--runThreadN 10 \
--genomeDir /project/legume_project/jacqueline.campbell/Mikado_transcriptome/02.star.genomes/"$GNM" \
--sjdbFileChrStartEnd "$GNM".rd1.SJ.out.tab \
--readFilesManifest /project/legume_project/jacqueline.campbell/Mikado_transcriptome/03.star.align/"$READS" \
--readFilesCommand zcat \
--outFileNamePrefix "$GNM".rd2. \
--outSAMstrandField intronMotif \
--outBAMsortingThreadN 10 \
--limitBAMsortRAM 50000000000 \
--outSAMtype BAM SortedByCoordinate 
