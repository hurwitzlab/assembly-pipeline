#!/usr/bin/env bash

#PBS -W group_list=bhurwitz
#PBS -q qualified
#PBS -l select=1:ncpus=1:mem=6gb
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

cd $SORTNMG_DIR

echo Concatenating fastq\'s for sample $SAMPLE

echo Orphan first
time find ./ -iname \*$SAMPLE\*nomatch\* -print0 | xargs -0 -I file cat file \
    > $GROUPED_DIR/"$SAMPLE".nomatch.fastq
echo First member of pair
time find ./ -iname \*$SAMPLE\*.1.fastq -print0 | xargs -0 -I file cat file \
    > $GROUPED_DIR/"$SAMPLE".1.fastq
echo Second member of pair
time find ./ -iname \*$SAMPLE\*.2.fastq -print0 | xargs -0 -I file cat file \
    > $GROUPED_DIR/"$SAMPLE".2.fastq

echo Done at $(date)
