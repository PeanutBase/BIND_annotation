**Filter TEsorter results**

This is mess and not the best way to handle this. 

Use the file that ends with augustus.hints.codingseq.rexdb-plant.cls.tsv

```
awk 'NR!=1 {print $1}' augustus.hints.CDS.fasta.rexdb-plant.cls.tsv > augustus.hints.CDS.fasta.rexdb-plant.cls.list 
    ##get list of genes that are TEs

grep '^>' augustus.hints.CDS.fasta | awk '{print $1}' | sed 's/^>//' > augustus.hints.CDS.list  
    ##get complete list of genes from BRAKER

cat *.list | sort | uniq -c > counts  
    ##combine the two list - now if there is a 2 in front of a gene name that means it is a TE gene

awk '{if ($1 == 1) print $2}' counts > augustus.hints.CDS.TE_FILTERED.list  
    ##extract the gene names that just have a 1 in front of it
    
ml seqtk

seqtk subseq augustus.hints.CDS.fasta augustus.hints.CDS.TE_FILTERED.list > augustus.hints.CDS.TE_FILTERED.fasta
```
**Create a new filter gff3 file**
```
grep '^>' augustus.hints.codingseq.TE_FILTERED.fasta | awk -v OFS="\t" '{print $1,$2 }' | sed 's/gene=//; s/^>//' > list
singularity exec --bind $PWD mikado.sif mikado util grep list augustus.hints-clean.gff3 > augustus.hints.clean.TE_FILTERED.gff3
    ### important the mikado.sif signiularity images needs to in the same location you are working in.
```
