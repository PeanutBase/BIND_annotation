### This is messy -- I think there is another way. 

**Use the file that ends with FILE.rexdb-plant.cls.tsv**

awk 'NR!=1 {print $1}' FILE.rexdb-plant.cls.tsv > FILE.rexdb-plant.cls.list  *get list of genes that are TEs*

grep '^>' FILE.fna | awk '{print $1}' | sed 's/^>//' > FILE.list *get complete list of genes from mikado*
  
cat FILE.list | sort | uniq -c > FILE.rexdb-plant.cls.counts  *combine the two list - now if there is a 2 in front of a gene name that means it is a TE gene* 

awk '{if ($1 == 1) print $2}' FILE.rexdb-plant.cls.counts > FILE.TE_FILTERED.list *extract the gene names that just have a 1 in front of it* 

ml seqtk

seqtk subseq FILE.fna FILE.TE_FILTERED.list > FILE.TE_FILTERED.fna
