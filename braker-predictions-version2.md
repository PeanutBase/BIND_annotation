# BRAKER predictions
For generating _ab initio_ predictions, for each spp. following files were gathered.

1. Genome sequence (`fasta` format)
2. RNA-Seq reads aligned to the respective genomes (coordinate sorted `bam` format)
3. Proteins -from Mikado pipeline (`fasta` format)
4. Repeat library (`fasta` format)

### Steps overview:

1. Repeat mask genomes using `Repeatmasker`
2. Use the hard-masked genomes for BRAKER predictions, using RNA-Seq and proteins as evidence.
3. Use soft-masked genomes for re-running BRAKER, but use the hints files (RNAseq) and GFF3 (aligned proteins) instead.
4. Run `TE-sorter` to find BRAKER predictions (genes/transcripts), that contain TE.
5. Run `phylostratr` to classify BRAKER predictions to various phylostrata


### 1. Repeat Masking

Using the script `runRpepeatmasker.sh`, RepeatMasker was run to find all the repeats in the genome. The obtained `gff3` of repeats was then used to generate soft-masked and hard-masked genome sequences.

```bash
runRepeatmasker.sh <genome-file> <repeat-library>
bioawk -c fastx '{print ">"$name"\n"toupper($seq)}' original-genome.fna > genome.fasta
bedtools maskfasta -soft -fi genome.fasta -bed repeat-masker.out.gff -fo genome.softmasked.fasta
bedtools maskfasta -fi genome.fasta -bed repeat-masker.out.gff -fo genome.hardmasked.fasta
```

### 2. Run BRAKER, round 1

For this run, we will use the `proteins.faa` (mikado generated, high confidence proteins), `rna-seq-mapped.bam` and the `genome.hardmasked.fasta` files as input. Using the script `runBRAKER_r1.sh`

```bash
./runBRAKER_r1.sh genome.hardmasked.fasta rna-seq-mapped.bam proteins.faa
```

The purpose of running this on hardmasked genome is to quickly get the hintsfile and aligned proteins file for the next round of BRAKER predictions. From the output folder, we will need:
`rnaseq=hintsfile.gff` and `protein_alignment_gth.gff3` files.


### 3. Run BRAKER, round 2

For this run, we will use the `rnaseq=hintsfile.gff`, `protein_alignment_gth.gff3` (both from previous BRAKER run) and the `genome.softmasked.fasta` files as input. Using the script `runBraker-prot-and-rnaseq.sh`. We can copy these files to the run directory and run it as follows:

```bash
runBraker-prot-and-rnaseq.sh
```
The output files that are important are within the `barker` folder ( eg: braker/araca.K10017_prot-rna_20201102.1). Following files are important:

  - `augustus.hints.gtf` : final preidctions
  - `augustus.hints.codingseq` : transcripts
  - `augustus.hints.aa` : proteins


### 4. Run TE-sorter

Using `augustus.hints.codingseq` as input file, TE-sorter was run as follows:

```bash
TEsorter.py -p 36 -db rexdb-plant --tmp-dir $TMPDIR  augustus.hints.codingseq
```

The result file `augustus.hints.codingseq.rexdb-plant.cls.tsv` provides the list of transcript ids that has potential TE elements in it.

### 5. Determine phylostrata for BRAKER predictions

Using `augustus.hints.aa` as input file, phylostrata was determined using `phylostratr` R package.

```bash
runPhylostratr.sh
```
to speed up the BLAST step, diamond was used and ran it outside the phylostratr script using `runDiamondBlasP.sh` script.

The final results summary is provided in the `phylostrata_stats.csv` and detailed report are in `phylostrata_table.csv`.


### 6. Putting it all together

Using the outputs of TE-sorter and phylostratr, we can now filter BRAKER predictions using the `filterTE-from-braker.sh` script.

This script will use the transcript ids with TE elements from TE sorter results and the phylostrata information from the phylostratr results to generate table of BRAKER ids (and can remove it from the braker gff file).

```bash
filterTE-from-braker.sh
```
