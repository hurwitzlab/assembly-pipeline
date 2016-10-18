#!/usr/bin/env bash

#PBS -W group_list=bhurwitz
#PBS -q qualified
#PBS -l jobtype=cluster_only
#PBS -l select=1:ncpus=2:mem=3gb:pcmem=2gb
#PBS -l pvmem=6gb
###and the amount of time required to run it
#PBS -l walltime=2:00:00
#PBS -l cput=2:00:00
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

cd $TRIMMED_DIR

echo Doing sample $SAMPLE

set -x
echo extracting pe
time extract-paired-reads.py --gzip \
    --output-dir $READY_DIR \
    --output-paired "$SAMPLE".fastq.pe.gz \
    --output-single "$SAMPLE".fastq.se.gz \
    "$SAMPLE".deduped.fastq.abundfilt

echo Done at $(date)
