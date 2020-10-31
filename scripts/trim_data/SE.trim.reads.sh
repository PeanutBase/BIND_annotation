module load trimmomatic/0.38

java -jar /software/7/apps/trimmomatic/0.38/trimmomatic-0.38.jar SE -phred33 -threads 20 \
SRR1234567_R1.fastq SRR1234567.trimmed.fastq \
ILLUMINACLIP:/software/7/apps/trimmomatic/0.38/adapters/TruSeq3-SE.fa:2:30:10 LEADING:20 TRAILING:20 MINLEN:25
