## cap3 output generated *clustered and *singlets fasta files
## Before aligning the ESTs sequences to the genome:
### 1. Combine *clustered and *singlets fasta files
### 2. Remove any ESTs sequences that are less than 200 bp


module load gmap_gsnap/2020-04-08

gmap_build --dir=/path/to/directory/gmap.db/ \
--db=species.gmap.database.db /path/to/genome/file/gnm.fna

gmap --dir=/path/to/directory/gmap.db/ \
--db=species.gmap.database.db -B 4 -t 16 -f gff3_match_cdna \
species.ESTs.gt200.fna > species.ESTs.gt200.gff3
