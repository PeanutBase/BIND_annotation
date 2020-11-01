  
module load star/2.7.2b 

index="/project/peanut/annotations/01_genome.star/"
read="species.SE.fastq.gz"
out="species.SE.rd1."

STAR --genomeDir $index --runThreadN 20 --runMode alignReads --readFilesIn $read --readFilesCommand zcat --outFileNamePrefix $out --outSAMtype None

## slurm job trick: You can submit star.SE.rd2.sh right after star.SE.rd1.sh by using "sbatch --dependency=afterok:" 
### EXAMPLE: sbatch --dependency=afterok:5136041 star.SE.rd2.sh (where '5136041' is star.SE.rd1.sh job number
