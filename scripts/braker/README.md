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


The output files that are important are within the `barker` folder. Following files are important:

  - `augustus.hints.gtf` : final preidctions
  - `augustus.hints.codingseq` : transcripts
  - `augustus.hints.aa` : proteins

### 3. Tidy the `augustus.hints.gtf` file using genometools 


### 4. Run TE-sorter

Using `augustus.hints.codingseq` as input file, TE-sorter was run as follows:

```bash
TEsorter.py -p 36 -db rexdb-plant augustus.hints.codingseq
```

The result file `augustus.hints.codingseq.rexdb-plant.cls.tsv` provides the list of transcript ids that has potential TE elements in it.
