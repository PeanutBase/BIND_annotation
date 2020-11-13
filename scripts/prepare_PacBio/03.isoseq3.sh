ml miniconda

source activate isoseq3

isoseq3 refine SRR8334349.fl.Clontech_5p--NEB_Clontech_3p.bam barcoded_primers.fasta SRR8334349.flnc.bam --require-polya

isoseq3 cluster SRR8334349.flnc.bam SRR8334349.unpolished.bam --verbose
