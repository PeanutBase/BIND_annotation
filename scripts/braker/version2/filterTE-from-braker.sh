#!/bin/bash
te_results="te-sorter/augustus.hints.codingseq.rexdb-plant.cls.tsv"
braker="braker/augustus.hints.aa"
braker_gff=$(find ./braker -name "augustus.hints.gtf")
ps="phylostratr/phylostrata_table.csv"

cut -f 2- -d "," ${ps} | sed -e 's/"//g' -e 's/ /_/g' -e 's/,/\t/g' | cut -f 1,4 > clean_ps-tra.tsv
cut -f 2- -d "," ${ps} | sed -e 's/"//g' -e 's/ /_/g' -e 's/,/\t/g' | cut -f 1,4 | sed 's/\./\t/1' | sort -k1,1 -u | cut -f 1,3 > clean_ps-genes.tsv

cut -f 1 ${te_results} | grep -v "^#" |sort | uniq > te.tids
cut -f 1 ${te_results} | grep -v "^#" | cut -f 1 -d "." | sort | uniq > te.gids

bioawk -c fastx '{print $name}' $braker > braker.tids
bioawk -c fastx '{print $name}' $braker | cut -f 1 -d "." | sort | uniq > braker.gids

grep -Fwv -f te.tids braker.tids > braker-no-TE.tids
grep -Fwv -f te.gids braker.gids > braker-no-TE.gids


# merge:

grep -Fwvf te.tids braker.tids | awk '{print $1"\tgene"}' > .nonte
awk '{print $1"\tTE-gene"}' te.tids > .te
cat .nonte .te |sort -k1,1 > .te-full.tids
rm .te .nonte
cut -f 1 clean_ps-tra.tsv |sort |uniq > .temp
grep -Fwvf .temp braker.tids | awk '{print $1"\tunassigned"}' > .rest
cat clean_ps-tra.tsv .rest | sort -k1,1 > .ps-full.tids
rm .rest .temp
awk 'BEGIN{OFS=FS="\t"}FNR==NR{a[$1]=$2 FS $3;next}{ print $0, a[$1]}' .ps-full.tids .te-full.tids > braker_transcripts-with-ps-and-te-info.tsv
rm .te-full.tids .ps-full.tids

grep -Fwvf te.gids braker.gids | awk '{print $1"\tgene"}' > .nonte
awk '{print $1"\tTE-gene"}' te.gids > .te
cat .nonte .te |sort -k1,1 > .te-full.gids
rm .te .nonte
cut -f 1 clean_ps-genes.tsv |sort |uniq > .temp
grep -Fwvf .temp braker.gids | awk '{print $1"\tunassigned"}' > .rest
cat clean_ps-genes.tsv .rest | sort -k1,1 > .ps-full.gids
rm .rest .temp
awk 'BEGIN{OFS=FS="\t"}FNR==NR{a[$1]=$2 FS $3;next}{ print $0, a[$1]}' .ps-full.gids .te-full.gids > braker_genes-with-ps-and-te-info.tsv
rm .te-full.gids .ps-full.gids

rm clean_ps-tra.tsv
rm clean_ps-genes.tsv
rm te.tids
rm te.gids
rm braker.tids
rm braker.gids
rm braker-no-TE.tids
rm braker-no-TE.gids

awk '$2=="gene"' braker_genes-with-ps-and-te-info.tsv > ids-to-retain.txt
#mikado util grep --genes ids-to-retain.txt $braker_gff  > final_abinitio_braker.gff3
