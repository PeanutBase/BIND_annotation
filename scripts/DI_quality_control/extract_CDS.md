module load cufflinks

gffread mikado.loci.gff3 -g <GENOME>  -x <nucleotide_output>.fna 

gffread mikado.loci.gff3  -g <GENOME>  -y <protein_output>.faa 
