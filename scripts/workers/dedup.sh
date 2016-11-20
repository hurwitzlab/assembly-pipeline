#!/usr/bin/env bash

#PBS -W group_list=bhurwitz
#PBS -q qualified
#PBS -l select=1:ncpus=12:mem=96gb
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

cd $GROUPED_DIR

echo Filtering out duplicate reads
time fastq filter --unique $FILE_TO_DEDUP \
    > $DEDUPED_DIR/deduped."$FILE_TO_DEDUP"
if [[ $? -eq 0 ]]; then
    echo Yay, it worked
else
    echo Something went wrong with fastq filter
fi

echo Done at $(date)
