#http://www.usadellab.org/cms/uploads/supplementary/Trimmomatic/TrimmomaticManual_V0.32.pdf
#http://www.usadellab.org/cms/?page=trimmomatic

module load trimmomatic/0.38

java -jar /software/7/apps/trimmomatic/0.38/trimmomatic-0.38.jar  PE -phred33 -threads 20 \
SRR1234567_R1.fastq SRR1234567_R2.fastq \
SRR1234567.trimmed.R1.fastq SRR1234567.frags1.fastq \
SRR1234567.trimmed.R2.fastq SRR1234567.leaf.frags2.fastq \
ILLUMINACLIP:/software/7/apps/trimmomatic/0.38/adapters/TruSeq3-PE-2.fa:2:30:10 \
LEADING:20 TRAILING:20 MINLEN:25
