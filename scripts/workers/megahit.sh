#!/usr/bin/env bash

#PBS -W group_list=bhurwitz
#PBS -q qualified
#PBS -l select=1:ncpus=12:mem=72gb
###and the amount of time required to run it
#PBS -l walltime=24:00:00
#PBS -l cput=96:00:00
#PBS -M scottdaniel@email.arizona.edu
#PBS -m bea

echo Started at $(date)

if [ -n "$PBS_O_WORKDIR" ]; then
    cd $PBS_O_WORKDIR
fi

set -u

COMMON="$WORKER_DIR/common.sh"

if [ -e $COMMON ]; then
  . "$COMMON"
else
  echo Missing common \"$COMMON\"
  exit 1
fi

megahit \
    --num-cpu-threads 12 \
    --memory 0.9 \
    --presets meta-large \
    --12 $READY_DIR/"$SAMPLE".fastq.pe.gz \
    -r $READY_DIR/"$SAMPLE".fastq.pe.gz \
    -o $CONTIG_DIR/"$SAMPLE" \
    --out-prefix "$SAMPLE"

echo "Ended at $(date)"
