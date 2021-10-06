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

Sometime the genometools gff tidy fails because the gff3 is really messed up (this happens often with BRAKER & augustus.hints.gff3 files) 
```
grep -v "^#" Arahy.genome.augustus.hints.CDS.fna.rexdb-plant.cls.tsv | cut -f1 | sort -u > TE-trans.txt

# Get the transcript and gene ID not mapped to TE.
grep ">" Arahy.genome.augustus.hints.CDS.fna | cut -f1 -d" " | sed 's/>//' | sort -u > CDS.txt
comm -23 CDS.txt TE-trans.txt > nonTE-trans.txt
cut -f1 -d"." nonTE-trans.txt | sort -u > nonTE-gene.txt

# Obtain a gff file filter out TE mapped proteins.
grep -Fwf nonTE-trans.txt augustus.hints.gff3 > trans.gff3
awk '$3=="gene"' augustus.hints.gff3 | grep -Fwf nonTE-gene.txt - > gene.gff3
cat gene.gff3 trans.gff3 | sed '1 i\##gff-version 3' | gt gff3 -sort -tidy -retainids > FINAL_noTE.gff3
```


### Singularity mikado compare failed

Run mikado compare interactively
```
singularity run ../mikado.sif 
mikado compare -r <gff3 file> -p <gff3 file>
exit
```
