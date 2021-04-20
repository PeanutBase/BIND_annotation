Mikado code details are available on [github](https://github.com/EI-CoreBioinformatics/mikado)
Mikado available via [bioconda](https://anaconda.org/bioconda/mikado) However I used the singularity package created by the lead develepor of BIND pipeline. 

```
ml singularity
singularity pull --name mikado.sif shub://aseetharam/mikado
```



After completion of Mikado step 4 it is important to filter the results to remove TEs and verify abundance of transcripts. 

###### Step 1: Pull the CDS from the Mikado gff3 output file
```
module load cufflinks
gffread DI-mikado-output.gff3 -g <genome file>  -V -x <CDS output file>

#Determine the number of Transcripts and genes in Mikado gff3 output file
grep -c '^>' <CDS output file>
grep '^>' <CDS output file> | awk '{print $2}' | sort | uniq | wc -l 
```

###### Step 2: Run TEsorter and filter the results
```
sbatch TEsorter.sh
```
Filter the results
```
Use the file that ends with FILE.rexdb-plant.cls.tsv
  # Get the list of TE transcripts
awk 'NR!=1 {print $1}' FILE.rexdb-plant.cls.tsv > FILE.rexdb-plant.cls.list

  # Get the list of all transcripts from mikado
grep '^>' FILE.fna | awk '{print $1}' | sed 's/^>//' > FILE.list

  # Combine all the two list files, sort/uniq -c - now if there is a 2 in front of a gene name that means it is a TE gene
cat FILE.list | sort | uniq -c > FILE.rexdb-plant.cls.counts 

  # extract the gene names that just have a 1 in front of it - genes with a 1 in front of it mean that gene is NOT a TE
awk '{if ($1 == 1) print $2}' FILE.rexdb-plant.cls.counts > FILE.TE_FILTERED.list extract the gene names that just have a 1 in front of it

ml seqtk

seqtk subseq FILE.fna FILE.TE_FILTERED.list > FILE.TE_FILTERED.fna
```

