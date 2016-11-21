#!/usr/bin/env bash

#PBS -W group_list=bhurwitz
#PBS -q qualified
#PBS -l select=1:ncpus=12:mem=72gb
###and the amount of time required to run it
#PBS -l walltime=24:00:00
#PBS -l cput=24:00:00
#PBS -M scottdaniel@email.arizona.edu
#PBS -m bea

echo STARTED at $(date)

set -u

COMMON="$WORKER_DIR/common.sh"

if [ -e $COMMON ]; then
  . "$COMMON"
else
  echo Missing common \"$COMMON\"
  exit 1
fi

FILES_TO_PROC=$(mktemp)

get_lines $FILES_TO_DEDUP $FILES_TO_PROC $PBS_ARRAY_INDEX $STEP_SIZE

NUM_FILES=$(lc $FILES_TO_PROC)

echo Found \"$NUM_FILES\" files to cat and/or deduplicate
echo They are $(cat $FILES_TO_PROC)

cd $GROUPED_DIR

if [[ ! -e "$PBS_ARRAY_INDEX".2out ]]; then
    cat $(cat $FILES_TO_PROC) > "$PBS_ARRAY_INDEX".2out
    echo Finished catting files
fi

echo Deduplicating...
fastq filter --unique "$PBS_ARRAY_INDEX".2out > $GROUPED_DIR/"$PBS_ARRAY_INDEX".deduped.2out 

echo Removing old files if successful
if [[ ! -z "$PBS_ARRAY_INDEX".deduped.2out ]]; then
    rm $(cat $FILES_TO_PROC)
    rm "$PBS_ARRAY_INDEX".2out
else
    echo Oops, something went wrong, keeping old files
    exit 1
fi

echo DONE at $(date)

