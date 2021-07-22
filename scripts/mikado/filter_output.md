**Extract CDS from the prefix.loci.gff3**

```
ml cufflinks
gffread <prefix>.loci.gff3 -g <genome.fasta> -x <prefix.CDS.fasta>
```
  
**Run [TEsorter](https://github.com/PeanutBase/BIND_annotation/blob/main/scripts/mikado/TEsorter.sh) to determine which CDS are TEs**
```
./TEsorter.sh <prefix.CDS.fasta>
```
**Filter TEsorter results**

This is mess and not the best way to handle this. 

Use the file that ends with prefix.CDS.fasta.rexdb-plant.cls.tsv

```
awk 'NR!=1 {print $1}' <prefix.CDS.fasta>.rexdb-plant.cls.tsv > <prefix.CDS.fasta>.rexdb-plant.cls.list 
    ##get list of genes that are TEs

grep '^>' <prefix.CDS.fasta> | awk '{print $1}' | sed 's/^>//' > <prefix.CDS.list  
    ##get complete list of genes from mikado

cat *.list | sort | uniq -c > counts  
    ##combine the two list - now if there is a 2 in front of a gene name that means it is a TE gene

awk '{if ($1 == 1) print $2}' counts > <prefix>.CDS.TE_FILTERED.list  
    ##extract the gene names that just have a 1 in front of it

ml seqtk

seqtk subseq <prefix.CDS.fasta> <prefix>.CDS.TE_FILTERED.list > <prefix>.CDS.TE_FILTERED.fasta

```

**Run [kallisto](https://github.com/PeanutBase/BIND_annotation/blob/main/scripts/mikado/kallisto.sh) to determine the quantifying abundances to support CDS sequences** 
```
./kallisto.sh <prefix>.CDS.TE_FILTERED.fasta INDEX Read_PE1.fq Read_PE2.fq
```

**Filter kallisto results**

```
awk -v OFS="\t" '{if (NR!=1 && $5 > 0) print $1}' abundance.tsv > <prefix>.TMP0.list  
      ##Filters CDS sequence with greater than 0 TMP associated with the CDS sequnce. 
      ##Increase the TMP filter value to get a more stringent filter value

ml seqtk

seqtk subseq <prefix>.CDS.TE_FILTERED.fasta <prefix>.TMP0.list  > <prefix>.TMP0.Final.fasta
```
**Create a new filter gff3 file**
```
grep '^>' <prefix>.TMP0.Final.fasta | awk -v OFS="\t" '{print $1,$2 }' | sed 's/gene=//; s/^>//' > list
singularity exec --bind $PWD mikado.sif mikado util grep list <prefix>.loci.gff3 > <prefix>.TMP0.Final.gff3
    ### important the mikado.sif signiularity images needs to in the same location you are working in.
```

**Extract CDS from the prefix.filtered.gff3**

```
ml cufflinks
gffread <prefix>.TMP0.Final.gff3 -g <genome.fasta> -x <prefix.TMP0.Final.CDS.fasta>
```

**Extract PEP from the prefix.filtered.gff3**

```
ml cufflinks
gffread <prefix>.TMP0.Final.gff3 -g <genome.fasta> -y <prefix.TMP0.Final.PEP.fasta>
```
