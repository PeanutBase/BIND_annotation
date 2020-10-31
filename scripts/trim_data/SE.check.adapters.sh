# A messy way to check the number of Illumina adapters in SE reads

module load trimmomatic/0.38

ls /software/7/apps/trimmomatic/0.38/adapters/TruSeq2-SE.fa 
zcat SRR1234567_R1.fastq.gz | grep -f /software/7/apps/trimmomatic/0.38/adapters/TruSeq2-SE.fa | wc -l

ls /software/7/apps/trimmomatic/0.38/adapters/TruSeq3-SE.fa
zcat SRR1234567_R1.fastq.gz | grep -f /software/7/apps/trimmomatic/0.38/adapters/TruSeq3-SE.fa | wc -l
