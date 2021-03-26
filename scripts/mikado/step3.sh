ml miniconda

source activate transdecoder
 
TransDecoder.LongOrfs -t DI_prepared.fasta
TransDecoder.Predict -t DI_prepared.fasta --cpu 20 
