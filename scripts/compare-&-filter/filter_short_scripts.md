
# Mikado.Keep == Mikado.HighConfidence
 
awk -v OFS="\t" '{print $1, $2}' mikado.keep.list > mikado.HC.list

awk -v OFS="\t" '{print $1, $2}' both.keep.list >> mikado.keep.HC.list

singularity exec --bind $PWD ../mikado.sif mikado util grep mikado.HC.list Arahy.genome.gff3 > mikado.HighConfidence.gff3

ml cufflinks

gffread mikado.HighConfidence.gff3 -g <genome> -x mikado.HighConfidence.CDS.fna

# Braker.Keep == Braker.HighConfidence

awk -v OFS="\t" '{print $4, $5}' braker.keep.list  > braker.HC.list

awk -v OFS="\t" '{print $4, $5}' both.keep.list >> braker.HC.list

singularity exec --bind $PWD ../mikado.sif mikado util grep braker.HC.list augustus.hints-filtered.gff3 > braker.HighConfidence.gff3

ml cufflinks

gffread braker.HighConfidence.gff3 -g <genome> -x braker.HighConfidence.CDS.fna

# Braker.Need2Filter.list == Braker.LowConfidence
 
awk -v OFS="\t" '{print $4, $5}' braker.Need2Filter.list >> braker.LC.list

singularity exec --bind $PWD ../mikado.sif mikado util grep braker.LC.list augustus.hints-filtered.gff3 > braker.LowConfidence.gff3

ml cufflinks

gffread  braker.LowConfidence.gff3 -g <genome> -x  braker.LowConfidence.CDS.fna
