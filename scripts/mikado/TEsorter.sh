seq=$1

ml miniconda

source activate TEsorter_v1.2.5.2

TEsorter -p 20 -db rexdb-plant $seq
 
conda deactivate
