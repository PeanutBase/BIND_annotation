# Trinity normalization requires that you download SRA libraries with this code. 
# https://github.com/trinityrnaseq/trinityrnaseq/wiki/Trinity-Insilico-Normalization
# what Trinity normalization does  http://ivory.idyll.org/blog/trinity-in-silico-normalize.html
# slow way to download data
# If you want to do no read normalization - either look at better ways to download data or look at using khmer
# https://github.com/dib-lab/khmer

module load sratoolkit/2.9.6

cat list.sra | while read line; 
do
        fastq-dump --split-files --defline-seq '@$sn[_$rn]/$ri' --gzip ${line}
done
