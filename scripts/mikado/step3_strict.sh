ml miniconda

source activate transdecoder
 
TransDecoder.LongOrfs -m 200 -t DI_prepared.fasta
TransDecoder.Predict --retain_long_orfs_mode strict --retain_long_orfs_length 200 -t DI_prepared.fasta --cpu 20 
