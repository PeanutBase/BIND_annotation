module load star/2.7.2b 

index="/project/peanut/annotations/01_genome.star/"
SJ="species.SE.SJ.out"
read="species.SE.fastq.gz"
out="species.SE.rd2."

STAR --genomeDir $index --runThreadN 20 --sjdbFileChrStartEnd $SJ --runMode alignReads --readFilesIn $read --readFilesCommand zcat --outFileNamePrefix $out --outSAMstrandField intronMotif --outBAMsortingThreadN 20 --limitBAMsortRAM 500000000000 --outSAMtype BAM SortedByCoordinate
