
module load fastx/0.0.14

## convert fastq to fasta and more N's
fastq_to_fasta -r -v -i species.ESTs.fastq -o species.ESTs.fasta

## convert fastq to fasta
fastq_to_fasta -r -n -v -i species.ESTs.fastq -o species.ESTs.KeepNs.fasta
