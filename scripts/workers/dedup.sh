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

cd $GROUPED_DIR

#export MERGER="$WORKER_DIR/mergeShuffledFastqSeqs.pl"

echo Doing sample $SAMPLE

set -x

time fastq filter --adjust 64 --unique \
    $(cat "$SAMPLE".1.fastq "$SAMPLE".2.fastq "$SAMPLE".nomatch.fastq) \
    > $DEDUPED_DIR/"$SAMPLE".deduped.fastq

echo Done at $(date)
