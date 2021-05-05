* Extract CDS from the <prefix>.loci.gff3
  
* Run TEsorter to determine which CDS are TEs
```
./TEsorter.sh <prefix.CDS.fasta>
```
* Filter TEsorter results

This is mess and not the best way to handle this. 

Use the file that ends with <prefix.CDS.fasta>.rexdb-plant.cls.tsv

```
awk 'NR!=1 {print $1}' <prefix.CDS.fasta>.rexdb-plant.cls.tsv > <prefix.CDS.fasta>.rexdb-plant.cls.list ##get list of genes that are TEs

grep '^>' <prefix.CDS.fasta> | awk '{print $1}' | sed 's/^>//' > <prefix.CDS.list  ##get complete list of genes from mikado

cat *.list | sort | uniq -c > counts  ##combine the two list - now if there is a 2 in front of a gene name that means it is a TE gene

awk '{if ($1 == 1) print $2}' counts > <prefix>.CDS.TE_FILTERED.list  ##extract the gene names that just have a 1 in front of it

ml seqtk

seqtk subseq <prefix.CDS.fasta> <prefix>.CDS.TE_FILTERED.list > <prefix>.CDS.TE_FILTERED.fasta

```

* Run kallisto 

Use <prefix>.CDS.TE_FILTERED.fasta for input for kallisto
```
 ./TEsorter.sh <prefix>.CDS.TE_FILTERED.fasta
```

* Filter kallisto results
