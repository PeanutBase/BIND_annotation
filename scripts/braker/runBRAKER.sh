## using signularity image braker2_2.1.6--hdfd78af_2-v1.sif

readonly SINGULARITY_IMAGE=/path/to/BRAKER/singularity/image/braker2_2.1.6--hdfd78af_2-v1.sif
readonly BAM=/path/to/bam/file/FILE.bam
readonly GENOME=/path/to/hardmaskerd/genome/file/genome.hardmasked.fna
readonly SPECIES=Arahy

# optimization: 
cp ${BAM} .


singularity exec ${SINGULARITY_IMAGE} cp -R /usr/local/config augustus_config

env time -v singularity run \
    --no-home \
    --home /opt/gm_key \
    --cleanenv \
    --env AUGUSTUS_CONFIG_PATH=${PWD}/augustus_config \
    ${SINGULARITY_IMAGE} \
        --cores ${SLURM_JOB_CPUS_PER_NODE} \
        --species=${SPECIES} \
        --genome=${GENOME} \
        --bam=./${BAM##*/} \
        --nocleanup \
        --gff3

# remove local bam
rm -f ./${BAM##*/} 

