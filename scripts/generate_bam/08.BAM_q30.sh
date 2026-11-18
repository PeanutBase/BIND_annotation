#!/bin/bash
#job standard output will go to the file slurm-%j.out (where %j is the job ID)

#SBATCH --time=24:00:00   # walltime limit (HH:MM:SS)
#SBATCH --nodes=1   # number of nodes
#SBATCH --ntasks-per-node=4   # 2 processor core(s) per node X 2 threads per core
#SBATCH --mem=4G   # maximum memory per node
#SBATCH --partition="NAME"   # undefined node(s)
#SBATCH --job-name="BAM_q30"
#SBATCH --account="PROJECT_NAME"
#SBATCH --mail-user=EMAIL   # email address
#SBATCH --mail-type=END,FAIL

ml samtools


BAM="$1"
OUT="$2"
samtools view -b -q 30 "$BAM"  > "$OUT"
