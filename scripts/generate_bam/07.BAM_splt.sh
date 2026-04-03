module load bamtools/2.5.1

bamtools split -in genome.Aligned.sorted.bam -reference
## split the large bam file by reference, this will split all the scaffolds into separate files - I used BAM_merge to put all the scaffolds into one BAM file. 
