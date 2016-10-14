#!/usr/bin/env bash

#PBS -W group_list=bhurwitz
#PBS -q qualified
#PBS -l select=1:ncpus=12:mem=72gb
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

#set -x

#echo Concatenating all fastqs into temp file
#time cat "$SAMPLE".1.fastq "$SAMPLE".2.fastq "$SAMPLE".nomatch.fastq > "$SAMPLE".temp
echo Filtering out duplicate reads
time fastq filter --adjust 64 --unique "$SAMPLE".temp \
    > $DEDUPED_DIR/"$SAMPLE".deduped.fastq
if [[ $? -eq 0 ]]; then
    echo Removing temp file
    rm "$SAMPLE".temp
else
    echo Something went wrong with fastq filter
    echo Keeping temp file for another try
fi

echo Done at $(date)
