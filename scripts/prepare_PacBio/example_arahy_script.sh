module load gmap_gsnap/2020-04-08

for i in {1..9}
do

        gmap_build --dir=/path/to/gmap.db \
        --db=arahy.gnm2.Arahy.0$i.db /path/to/genome/arahy.Tifrunner.gnm2.Arahy.0$i

        gmap --dir=/path/to/gmap.db \
        --db=arahy.gnm2.Arahy.0$i.db --batch=4 --nthreads=20 \
        --format=gff3_match_cdna SRR8334349.unpolished.fasta > arahy.Tifrunner.gnm2.J5K5.SRR8334349.Arahy.0$i.gff3

done

for i in {10..20}
do

        gmap_build --dir=/path/to/gmap.db \
        --db=arahy.gnm2.Arahy.$i.db /path/to/genome/arahy.Tifrunner.gnm2.Arahy.$i

        gmap --dir=/path/to/gmap.db \
        --db=arahy.gnm2.Arahy.$i.db --batch=4 --nthreads=20 \
        --format=gff3_match_cdna SRR8334349.unpolished.fasta > arahy.Tifrunner.gnm2.J5K5.SRR8334349.Arahy.$i.gff3

done
