ml miniconda

source activate portcullisenv

gnm=$1
bam=$2

portcullis full --threads 20 --verbose --use_csi --output portcullis_out --orientation FR $gnm $bam

conda deactivate
