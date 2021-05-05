ml miniconda

source activate kallisto_0.46.2

seq=$1 
prefix=$2
read1=$3
read2=$4

kallisto index --index=$prefix $seq

kallisto quant --threads=20 --index=$prefix -o ./ $read1 $read2
