Mikado code details are available on [github](https://github.com/EI-CoreBioinformatics/mikado)
Mikado available via [bioconda](https://anaconda.org/bioconda/mikado) However I used the singularity package created by the lead develepor of BIND pipeline. 

```
ml singularity

singularity pull --name mikado.sif shub://aseetharam/mikado
```



After completion of Mikado step 4 it is important to filter the results to remove TEs and verify abundance of transcripts. 
Step 1: Pull the CDS from the Mikado gff3 output file
```
module load cufflinks

gffread DI-mikado-output.gff3 -g <genome file>  -V -x <CDS output file>  
#Determine the number of Transcripts and genes in Mikado gff3 output file
grep -c '^>' <CDS output file>
grep '^>' <CDS output file> | awk '{print $2}' | sort | uniq | wc -l 
```

