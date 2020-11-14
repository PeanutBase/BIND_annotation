# CLASS2 was installed in my project directory 
# http://ccb.jhu.edu/people/florea/research/CLASS2/

bam=$1
out=$2

/project/peanut_annotation/CLASS-2.1.7/run_class.pl -a $bam -o ${out}_class.gtf -p 20 --verbose --clean
