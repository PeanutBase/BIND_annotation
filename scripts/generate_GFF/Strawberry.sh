# Strawberry was downloaded/installed using singularity

bam=$1
out=$2

singularity exec --cleanenv strawberry_v1.1.1.sif /home/strawberry/bin/strawberry --output-gtf ${out}_strawberry.gtf \
--logfile ${out}_strawberry_assembled.log --no-quant --num-threads 20 --verbose --min-transcript-size 100 ${bam}
