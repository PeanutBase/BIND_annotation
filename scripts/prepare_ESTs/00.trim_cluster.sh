
module load fastx/0.0.14

## convert fastq to fasta and remove N's
fastq_to_fasta -r -v -i species.ESTs.fastq -o species.ESTs.fasta


module load cap3/3

## cluster ESTs
cap3 species.ESTs.fasta


## cap3 output generated *clustered and *singlets fasta files
## Before aligning the ESTs sequences to the genome:
### 1. Combine *clustered and *singlets fasta files
### 2. Remove any ESTs sequences that are less than 200 bp


