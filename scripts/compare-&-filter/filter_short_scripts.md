
# Mikado.Keep == Mikado.HighConfidence
 
```
awk -v OFS="\t" '{print $1, $2}' mikado.keep.list > mikado.HC.list
awk -v OFS="\t" '{print $1, $2}' both.keep.list >> mikado.keep.HC.list
singularity exec --bind $PWD mikado.sif mikado util grep mikado.HC.list arahy.Tifrunner.gnm2.J5K5.TMP_0.5.gff3 > arahy.Tifrunner.gnm2.J5K5.DI.HighConfidence.gff3
```

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
