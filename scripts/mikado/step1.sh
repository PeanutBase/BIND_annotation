## Make sure the list and junctions file name is the same. Or change the names to ensure that the script works. 

list="list.txt"
junctions="portcullis_all.junctions.bed"
genome=$1

singularity exec --bind $PWD mikado.sif mikado configure \
   --list $list \
   --reference $genome \
   --mode nosplit \
   --scoring HISTORIC/plants.yaml \
   --copy-scoring plants.yaml \
   --junctions $junctions configuration.yaml

## NOTE: Before going to step 2:  
### Need to revised configure.yaml manually to keep all ORFs.
### We choose nosplit mode, and want to keep all ORFs if any ORFs overlapped.
### Add this under pick in configure.yaml
##### output_format:
#####    report_all_orfs: true 
### see example_configuration.yaml within this folder
