singularity exec --bind $PWD mikado.sif mikado serialise \
   --start-method spawn \
   --procs 32 \
   --json-conf configuration.yaml \
   --orfs DI_prepared.fasta.transdecoder.bed \
   -mr 1

singularity exec --bind $PWD mikado.sif mikado pick \
   --start-method spawn \
   --loci-out DI.loci.gff3 \
   --procs 32 \
   --json-conf configuration.yaml \
   --subloci-out DI.subloci.gff3
