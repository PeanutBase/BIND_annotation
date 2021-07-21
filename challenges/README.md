# Challenges I encounterd during this work

### Genome BAM file is too big 

Split the BAM file by reference 
```
module load bamtools/2.5.1
bamtools split -in genome.bam -reference
```

**Note:** Merge the scaffold bam files with the last chromosome bam file
```
module load  samtools/1.9
samtools merge --threads 20 merged.bam genome.REF_genome.scaffold_*
samtools sort --threads 20 merged.bam -o genome.scaffolds.bam
```




### Something is wrong with the GFF3 file

Sort and tidy the gff3 file
```
ml genometools
gt gff3 -sort -tidy --retainids -o output.gff3 input.gff3
```

### Singularity mikado compare failed

Run mikado compare interactively
```
singularity run ../mikado.sif 
mikado compare -r <gff3 file> -p <gff3 file>
exit
```
