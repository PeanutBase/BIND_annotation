

 
awk -v OFS="\t" '{print $4, $5}' braker.keep.list  > braker.keep.edited.list

awk -v OFS="\t" '{print $4, $5}' both.keep.list >> braker.keep.edited.list

awk '{print $10}' good_genes.lst | sort | uniq | sed 's/_g";//; s/^"/gene/' > good_genes.sorted.list
 
grep -Fwf good_genes.sorted.list braker.keep.edited.list > braker.keep.final.list

singularity exec --bind $PWD ../mikado.sif mikado util grep braker.keep.final.list augustus.hints-filtered.gff3 > braker.keep.final.gff3

awk -v OFS="\t" '{print $1, $2}' mikado.keep.list > mikado.keep.final.list

awk -v OFS="\t" '{print $1, $2}' both.keep.list >> mikado.keep.final.list

singularity exec --bind $PWD ../mikado.sif mikado util grep mikado.keep.final.list arahy.Tifrunner.gnm2.DI.Arahy02.TMP10.gff3 > mikado.keep.final.gff3

ml cufflinks


------ braker low confidence -- 

cat braker.keep.edited.list braker.keep.final.list | sort | uniq -c > braker.counts

awk -v OFS="\t" '{if ($1 == 1) print $2, $3}' braker.counts > braker.LowConfidence

singularity exec --bind $PWD ../mikado.sif mikado util grep braker.LowConfidence augustus.hints-filtered.gff3 > braker.LowConfidence.gff3

