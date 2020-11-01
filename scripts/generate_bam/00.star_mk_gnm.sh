module load star/2.7.2b

$out="/project/peanut/annotations/01_genome.star" ## Location for output
$gmn=$1   ## genome fasta file 

STAR --runMode genomeGenerate --runThreadN 20 --genomeDir $out --genomeFastaFiles $gmn
