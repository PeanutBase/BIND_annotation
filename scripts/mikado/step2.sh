## NOTE: Before running this command: 
### Need to revised configure.yaml manually to keep all ORFs.
### We choose nosplit mode, and want to keep all ORFs if any ORFs overlapped.
### Add this under pick in configure.yaml
##### output_format:
#####    report_all_orfs: true 


singularity exec --bind $PWD mikado.sif mikado prepare \
   --json-conf \
   configuration.yaml
