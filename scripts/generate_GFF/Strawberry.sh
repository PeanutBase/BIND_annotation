ml apptainer


BAM="$1"
OUT="$2"

apptainer exec --cleanenv /project/legume_project/containers/strawberry_v1.1.1.sif \
  /home/strawberry/bin/strawberry --output-gtf "$OUT"_strawberry.gtf \
  --logfile "$OUT"_strawberry_assembled.log --no-quant --num-threads 10 \
  --verbose --min-transcript-size 100 "$BAM"
