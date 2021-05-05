
orfs=$1
prefix=$2

singularity exec --bind $PWD mikado.sif mikado serialise \
   --start-method spawn \
   --procs 40 \
   --json-conf configuration.yaml \
   --orfs ${orfs} \
   -mr 1

singularity exec --bind $PWD mikado.sif mikado pick \
   --start-method spawn \
   --loci-out ${prefix}.loci.gff3 \
   --procs 40 \
   --json-conf configuration.yaml \
   --subloci-out ${prefix}.subloci.gff3 \
   --pad
   
   
