#!/usr/bin/env bash
#
# Merge unknown species *.fastq's  before deduplication 
#
set -u
source ./config.sh
export CWD="$PWD"
export STEP_SIZE=6
#30 files... so 5 subjobs

PROG=`basename $0 ".sh"`
STDOUT_DIR="$CWD/out/$PROG"

init_dir "$STDOUT_DIR"

#if [[ ! -d $GROUPED_DIR ]]; then
#    mkdir -p $GROUPED_DIR
#fi

cd "$GROUPED_DIR"

export FILES_TO_DEDUP=$PRJ_DIR/files-to-dedup

find ./ -type f -iname "*.out" | sed "s/^\.\///" | sort > $FILES_TO_DEDUP 

NUM_FILES=$(lc $FILES_TO_DEDUP)

if [[ $NUM_FILES = 0 ]]; then
    echo No files found
    exit 1
else
    echo Found "$NUM_FILES"
    echo splitting them up in subjobs of "$STEP_SIZE"
fi

JOB=$(qsub -J 1-$NUM_FILES:$STEP_SIZE -V -N dedup-unk -j oe -o "$STDOUT_DIR" $WORKER_DIR/dedup-unk3.sh)

if [ $? -eq 0 ]; then
    echo Submitted job \"$JOB\" for you in steps of \"$STEP_SIZE.\" Remember: time you enjoy wasting is not wasted time.
else
    echo -e "\nError submitting job\n$JOB\n"
fi

