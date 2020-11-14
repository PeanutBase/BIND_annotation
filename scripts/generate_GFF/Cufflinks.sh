
module load  cufflinks/2.2.1

out="/project/peanut_annotation/BIND_annotations/03.cufflinks/"
bam=".Aligned.sorted.bam"

cufflinks --output-dir $out --num-threads 20 --frag-len-mean 100 --verbose --no-update-check $bam
