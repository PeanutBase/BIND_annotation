module load stringtie/2.1.1

bam=$1
out=$2

stringtie ${bam} -m 100 -p 20 -v -o ${out}_stringtie.gtf
