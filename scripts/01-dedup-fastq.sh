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

init_dir "$STDOUT_DIR" "$DEDUPED_DIR"

cd "$GROUPED_DIR"

for i in $SAMPLE_NAMES; do
    export SAMPLE=$i
    echo $i
    qsub -V -j oe -o "$STDOUT_DIR" $WORKER_DIR/run-dedup.sh
done

