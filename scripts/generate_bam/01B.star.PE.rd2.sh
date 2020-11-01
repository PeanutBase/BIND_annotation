module load star/2.7.2b 

index="/project/peanut/annotations/01_genome.star/"
SJ="species.PE.rd1.SJ.out"
read1="species.PE1.fastq.gz"
read2="species.PE2.fastq.gz"
out="species.PE.rd2."

STAR --genomeDir $index --runThreadN 20 --sjdbFileChrStartEnd $SJ --runMode alignReads --readFilesIn $read1 $read2 --readFilesCommand zcat --outFileNamePrefix $out --outSAMstrandField intronMotif --outBAMsortingThreadN 20 --limitBAMsortRAM 500000000000 --outSAMtype BAM SortedByCoordinate
