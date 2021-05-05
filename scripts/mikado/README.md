Mikado code details are available on [github](https://github.com/EI-CoreBioinformatics/mikado)
Mikado available via [bioconda](https://anaconda.org/bioconda/mikado) However I used the singularity package created by the lead develepor of BIND pipeline. 

```
ml singularity
singularity pull --name mikado.sif shub://aseetharam/mikado
```

Consolidate all the transcripts, and predict potential protein coding sequence by Mikado:

**Step 1: Make a configure file and prepare transcripts**

##### Step 1.1 Prepare a tab-delimited file called list.txt (shown below) to include gtf path (1st column), gtf abbrev (2nd column), stranded-specific or not (3rd column):
```
/path/to/file/genome_class.gtf	araip_class	False
/path/to/file/genome_transcripts.gtf	araip_cufflinks	False
/path/to/file/genome_stringtie.gtf	araip_stringtie	False
/path/to/file/genome_strawberry.gtf	araip_strawberry	False
```
##### Step 1.2 Move or generate a symoblic link to the portcullis_all.junctions.bed file and the genome file 

##### Step 1.3 Run [step1.sh](https://github.com/PeanutBase/BIND_annotation/blob/main/scripts/mikado/step1.sh) script 
```
./step1.sh <genome.fasta> 
```

##### Step 1.4 Edit the configure.yaml file created from running Mikado_step1.sh 
See [example_configuration.yaml](https://github.com/PeanutBase/BIND_annotation/blob/main/scripts/mikado/example_configuration.yaml)
```
Edit configure.yaml manually to keep all ORFs.
Mikado nosplit mode is selected in step1 and it is best to keep all ORFs if any ORFs overlapped.
Add these lines under 'subloci_out:' in configure.yaml
output_format:
report_all_orfs: true 
```

**Step 2: Generate mikado_prepared.fasta**
Run [step2.sh](https://github.com/PeanutBase/BIND_annotation/blob/main/scripts/mikado/step2.sh); this script will generate mikado_prepared.fasta file that will be used for predicting ORFs in the next step.

**Step 3: Predict potential CDS from transcripts**
There are multiple ways to conduct this step. The output needed from this step is an ORF.bed file. 
Scripts available to use for this step: 

[Transdecoder normal](https://github.com/PeanutBase/BIND_annotation/blob/main/scripts/mikado/step3.sh)

[Transdecoder strict](https://github.com/PeanutBase/BIND_annotation/blob/main/scripts/mikado/step3_strict.sh)

[ORIFPY](https://github.com/PeanutBase/BIND_annotation/blob/main/scripts/mikado/step3_orfipy.sh)

**Step 4:Pick best transcripts for each locus and annotate them as gene**
```
./step4.sh <ORFs.bed> <prefix> 
```
This script will generate a number of output files. The main output of interest will be labeled as <prefix>.loci.gff3
  
It is best to filter the mikado output (<prefix>.loci.gff3) before going to the next step. Please review filter_output.md

