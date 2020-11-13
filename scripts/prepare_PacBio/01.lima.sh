ml miniconda

source activate lima

lima SRR8334349.ccs.bam barcoded_primers.fasta SRR8334349.fl.bam --isoseq --peek-guess

conda deactivate
