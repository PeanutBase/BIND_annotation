
module load fastx/0.0.14

## convert fastq to fasta and remove N's
fastq_to_fasta -r -v -i species.ESTs.fastq -o species.ESTs.fasta


module load cap3/3

## cluster ESTs
cap3 species.ESTs.fasta


