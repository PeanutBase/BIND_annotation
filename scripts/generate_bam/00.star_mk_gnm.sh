module load star/2.7.11b
# Input Agruements
OUT="$1"
GNM="$2"
GTF="$3"

STAR \
--runThreadN 10 \
--runMode genomeGenerate \
--genomeDir /project/Mikado_transcriptome/02.star.genomes/"$OUT" \
--genomeFastaFiles "$GNM" \
--sjdbGTFfile "$GTF"
