module load star/2.7.2b 

index="/project/peanut/annotations/01_genome.star/"
read1="species.PE1.fastq.gz"
read2="species.PE2.fastq.gz"
out="species.PE.rd1."

STAR --genomeDir $index --runThreadN 20 --runMode alignReads --readFilesIn $read1 $read2 --readFilesCommand zcat --outFileNamePrefix $out --outSAMtype None

## slurm job trick: You can submit star.PE.rd2.sh right after star.PE.rd1.sh by using "sbatch --dependency=afterok:" 
### EXAMPLE: sbatch --dependency=afterok:5136041 star.PE.rd2.sh (where '5136041' is star.PE.rd1.sh job number
