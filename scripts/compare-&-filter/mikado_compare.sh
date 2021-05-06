## the singularity image mikado.sif (or a symbolic link to the mikado.sif) needs to be in the same location as the input data and script
#### or change to the path to the mikado.sif in the script

## ref is considered the evidence based gff3 file 
## pre is the predictive based gff3 file

ref=$1
pre=$2

singularity exec --bind $PWD mikado.sif mikado compare \
   --processes 40 \
    -r ${ref} \
    -p ${pre} \
   --log compare.log  
   
 
