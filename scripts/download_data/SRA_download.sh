module load sratoolkit

cat SRR.numbers | while read line; 
do

        fasterq-dump --split-files ${line}

done
