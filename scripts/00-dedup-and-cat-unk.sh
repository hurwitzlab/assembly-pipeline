#!/usr/bin/env bash
#
# Merge unknown species *.fastq's  before deduplication 
#
set -u
source ./config.sh
export CWD="$PWD"
export STEP_SIZE=10
#about 200 directories... so 20 subjobs

PROG=`basename $0 ".sh"`
STDOUT_DIR="$CWD/out/$PROG"

init_dir "$STDOUT_DIR"

#if [[ ! -d $GROUPED_DIR ]]; then
#    mkdir -p $GROUPED_DIR
#fi

cd "$UNK_DIR"

export DIRS_TO_DEDUP=$PRJ_DIR/dirs-to-dedup

find ./ -type d | sed "s/^\.\///" > $DIRS_TO_DEDUP 

NUM_DIRS=$(lc $DIRS_TO_DEDUP)

if [[ $NUM_DIRS = 0 ]]; then
    echo No dirs found
    exit 1
else
    echo Found "$NUM_DIRS"
    echo splitting them up in subjobs of "$STEP_SIZE"
fi

JOB=$(qsub -J 1-$NUM_DIRS:$STEP_SIZE -V -N dedup-unk -j oe -o "$STDOUT_DIR" $WORKER_DIR/dedup-unk.sh)

if [ $? -eq 0 ]; then
    echo Submitted job \"$JOB\" for you in steps of \"$STEP_SIZE.\" Remember: time you enjoy wasting is not wasted time.
else
    echo -e "\nError submitting job\n$JOB\n"
fi
