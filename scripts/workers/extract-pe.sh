#!/usr/bin/env bash

#PBS -W group_list=bhurwitz
#PBS -q qualified
#PBS -l select=1:ncpus=6:mem=36gb
###and the amount of time required to run it
#PBS -l walltime=24:00:00
#PBS -l cput=24:00:00
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

#set -x
#echo sorting pe
###NOTE: sorted manually in interactive session to this isn't needed
#time fastq-sort --id "$SAMPLE".deduped.fastq.abundfilt > "$SAMPLE".temp
#
#if [[ $? -eq 0 ]]; then
#    mv "$SAMPLE".temp "$SAMPLE".deduped.fastq.abundfilt
#else
#    echo Something went wrong with fastq-sort
#    exit 1
#fi
#

echo extracting pe
time extract-paired-reads.py \
    --output-paired $READY_DIR/"$SAMPLE".fastq.pe \
    --output-single $READY_DIR/"$SAMPLE".fastq.se \
    "$SAMPLE".deduped.fastq.abundfilt

if [[ $? -eq 0 ]]; then
    echo 'It worked!'
else
    echo Something went wrong with extract-paired-reads.py
fi

echo Done at $(date)
