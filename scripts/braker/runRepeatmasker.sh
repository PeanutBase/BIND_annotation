
conda activate repeatmasker

lib="$1"
genome="$2"

RepeatMasker \
  -e ncbi \
  -pa 36 \
  -q \
  -lib ${lib} \
  -nocut \
  -gff \
  ${genome}
