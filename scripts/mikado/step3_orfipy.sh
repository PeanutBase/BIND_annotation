#paper: https://academic.oup.com/bioinformatics/advance-article/doi/10.1093/bioinformatics/btab090/6134074
#conda package: https://anaconda.org/bioconda/orfipy

orfipy DI_prepared.fasta \
  --outdir orfipy_out  \
  --bed12 orfs.bed \
  --include-stop \
  --start ATG
