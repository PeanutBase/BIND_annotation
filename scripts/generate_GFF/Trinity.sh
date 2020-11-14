module load trinityrnaseq/2.10.0

bam=$1
out=$2

Trinity --genome_guided_bam $bam --max_memory 750G --min_contig_length 100 --genome_guided_max_intron 10000 --full_cleanup --CPU 20 --output TrinityOut_${out} 
