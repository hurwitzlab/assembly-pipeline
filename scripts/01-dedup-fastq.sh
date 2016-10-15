#!/usr/bin/env bash
#
# Merge *.fastq's by sample before deduplication 
#

set -u
source ./config.sh
export CWD="$PWD"
export STEP_SIZE=1

PROG=`basename $0 ".sh"`
STDOUT_DIR="$CWD/out/$PROG"

init_dir "$STDOUT_DIR"
#init_dir "$DEDUPED_DIR"

cd "$GROUPED_DIR"

#overriding config just this once
export SAMPLE_NAMES="DNA_1 DNA_2 DNA_3"

for i in $SAMPLE_NAMES; do
    export SAMPLE=$i
    echo $i
    qsub -V -j oe -o "$STDOUT_DIR" $WORKER_DIR/dedup.sh
done

