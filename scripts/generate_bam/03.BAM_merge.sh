
module load  samtools/1.9

#merge all bam files from alignment program (I used STAR)
samtools merge --threads 20 merged.bam genome_PE.Aligned.sorted.bam genome_SE.Aligned.sorted.bam 

#once the bam files are merge we need to sort the bam file again 
samtools sort --threads 20 merged.bam -o genome_merged.Aligned.sorted.bam
