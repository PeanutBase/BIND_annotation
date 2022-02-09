
# Mikado.Keep == Mikado.HighConfidence
 
```
awk -v OFS="\t" '{print $1, $2}' mikado.keep.list > mikado.HC.list
awk -v OFS="\t" '{print $1, $2}' both.keep.list >> mikado.HC.list
sort mikado.HC.list | uniq > mikado.HC.list.uniq (*See Special Note below*)

singularity exec --bind $PWD mikado.sif mikado util grep mikado.HC.list arahy.Tifrunner.gnm2.J5K5.TMP_0.5.gff3 > arahy.Tifrunner.gnm2.J5K5.DI.HighConfidence.gff3
```
##### *Special note*: Double check your mikado.keep.list and both.keep.list. I have encountered genomes where the number of genes in the mikado.keep.list and mikado.HC.list is higher then the number of genes in the HC.gff3 file. The reason is because one mikado gene model will make more than one BRAKER gene model and will be listed two or more time. 



```
ml cufflinks
gffread arahy.Tifrunner.gnm2.J5K5.DI.HighConfidence.gff3 -g arahy.Tifrunner.gnm2.J5K5.genome_main.fna -x arahy.Tifrunner.gnm2.J5K5.DI.HighConfidence.CDS.fna
```

# Braker.Keep == Braker.HighConfidence
```
awk -v OFS="\t" '{print $4, $5}' braker.keep.list  > braker.HC.list
awk -v OFS="\t" '{print $4, $5}' both.keep.list >> braker.HC.list
singularity exec --bind $PWD mikado.sif mikado util grep braker.HC.list Arahy.genome.augustus.hints.CDS.TE_FILTERED_CLEAN.gff3 > arahy.Tifrunner.gnm2.J5K5.BRAKER.HighConfidence.gff3
```

```
ml cufflinks
gffread arahy.Tifrunner.gnm2.J5K5.BRAKER.HighConfidence.gff3 -g arahy.Tifrunner.gnm2.J5K5.genome_main.fna -x arahy.Tifrunner.gnm2.J5K5.BRAKER.HighConfidence.CDS.fna
```

# Braker.Need2Filter.list == Braker.LowConfidence
``` 
awk -v OFS="\t" '{print $4, $5}' braker.Need2Filter.list >> braker.LC.list
singularity exec --bind $PWD mikado.sif mikado util grep braker.LC.list Arahy.genome.augustus.hints.CDS.TE_FILTERED_CLEAN.gff3 > arahy.Tifrunner.gnm2.J5K5.BRAKER.LowConfidence.gff3
```

```
ml cufflinks
gffread arahy.Tifrunner.gnm2.J5K5.BRAKER.LowConfidence.gff3 -g arahy.Tifrunner.gnm2.J5K5.genome_main.fna -x arahy.Tifrunner.gnm2.J5K5.BRAKER.LowConfidence.CDS.fna
```
