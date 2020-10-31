# A messy way to check the adapters in Illumia RNA-Seq data

module load trimmomatic/0.38

ls /software/7/apps/trimmomatic/0.38/adapters/TruSeq2-PE.fa
zcat SRR1234567_R1.fastq.gz | grep -f /software/7/apps/trimmomatic/0.38/adapters/TruSeq2-PE.fa | wc -l
zcat SRR1234567_R2.fastq.gz | grep -f /software/7/apps/trimmomatic/0.38/adapters/TruSeq2-PE.fa | wc -l

ls /software/7/apps/trimmomatic/0.38/adapters/TruSeq3-PE-2.fa
zcat SRR1234567_R1.fastq.gz | grep -f /software/7/apps/trimmomatic/0.38/adapters/TruSeq3-PE-2.fa | wc -l
zcat SRR1234567_R2.fastq.gz | grep -f /software/7/apps/trimmomatic/0.38/adapters/TruSeq3-PE-2.fa | wc -l

ls /software/7/apps/trimmomatic/0.38/adapters/TruSeq3-PE.fa
zcat SRR1234567_R1.fastq.gz | grep -f /software/7/apps/trimmomatic/0.38/adapters/TruSeq3-PE.fa | wc -l
zcat SRR1234567_R2.fastq.gz | grep -f /software/7/apps/trimmomatic/0.38/adapters/TruSeq3-PE.fa | wc -l
