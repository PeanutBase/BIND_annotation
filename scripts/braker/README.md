# BRAKER predictions using RNA-Seq data only
For generating _ab initio_ predictions, for each spp. following files were gathered.
If you have difficulty to install BRAKER, we suggest you to download the singularity container for this step at [here](https://github.com/aseetharam/braker).

1. Genome sequence (`fasta` format)
2. RNA-Seq reads aligned to the respective genomes (coordinate sorted `bam` format)
4. Repeat library (`fasta` format)

### Steps overview:

1. Repeat mask genomes using `Repeatmasker`
2. Use the hard-masked genomes for BRAKER predictions, using RNA-Seq as evidence.
3. Tidy the `augustus.hints.gtf` file using genometools 
4. Run `TE-sorter` to find BRAKER predictions (genes/transcripts), that contain TE.


### 1. Repeat Masking

Using the script `runRpepeatmasker.sh`, RepeatMasker was run to find all the repeats in the genome. The obtained `gff3` of repeats was then used to generate soft-masked and hard-masked genome sequences.

```bash
runRepeatmasker.sh <genome-file> <repeat-library>
bioawk -c fastx '{print ">"$name"\n"toupper($seq)}' original-genome.fna > genome.fasta 
	##above code not required - above code changes the original-genome from a softmasked genome to a non-masked genome 
bedtools maskfasta -fi genome.fasta -bed repeat-masker.out.gff -fo genome.hardmasked.fasta
```

### 2. Run BRAKER

**If you have difficulty to install BRAKER, we suggest you to download the singularity container for this step at [here](https://github.com/aseetharam/braker).**

Required input to use the `runBRAKER_singularity.sh` script: **(1)** path to Braker Singularity Image, **(2)** path to RNA-Seq BAM file and **(3)** path to hard masked genome. 
The output files that are important are within the `barker` folder. Following files are important:

  - `augustus.hints.gtf` : final predictions (most important file) 
  - `augustus.hints.codingseq` : transcripts
  - `augustus.hints.aa` : proteins

### 3. Tidy the gtf file using genometools 

Using the program `genometools` with the `gtf_to_gff3` option to generate a clean version of a gff3 file for further filtering. **Note: In my experience - somethings `genometools` did not work. Review the Challenges ReadMe file.**
```bash
module load genometools
gt gtf_to_gff3 -tidy -o augustus.hints-clean.gff3 augustus.hints.gtf
```

### 4. Run TE-sorter

Create an CDS file using Cufflinks gffread from the `augustus.hints.gtf` file. 
```bash
module load cufflinks
gffread augustus.hints.gtf -g /path/to/the/genome_main.fasta -x augustus.hints.CDS.fasta
```
Use `augustus.hints.CDS.fasta` for TE-sorter run as follows:

```bash
TEsorter.py -p 20 -db rexdb-plant augustus.hints.CDS.fasta
```

The result file `augustus.hints.CDS.fasta.rexdb-plant.cls.tsv` provides the list of transcript ids that has potential TE elements in it. Review the script [filter_TE.md](https://github.com/PeanutBase/BIND_annotation/blob/main/scripts/braker/filter_TE.md) to see how I filtered the TE sequences and generated a TE_Filtered GFF3 for the final [compare & filter step](https://github.com/PeanutBase/BIND_annotation/tree/main/scripts/compare-%26-filter) 
