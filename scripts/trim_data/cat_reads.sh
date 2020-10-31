
module load pigz/2.3.3

pigz -d -p 20 *.gz

SRR1234560.R1.fastq SRR1234561.trimmed.R1.fastq SRR1234562.trimmed.R1.fastq SRR1234563.R1.fastq SRR1234564.R1.fastq > species.PE1.fastq

SRR1234560.R2.fastq SRR1234561.trimmed.R2.fastq SRR1234562.trimmed.R2.fastq SRR1234563.R2.fastq SRR1234564.R2.fastq > species.PE2.fastq

pigz -p 20 *.fastq
