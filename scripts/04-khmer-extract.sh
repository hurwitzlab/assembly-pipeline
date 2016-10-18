#!/usr/bin/env bash
#
# Use khmer to extract paired-end and single-end reads 
#

set -u
source ./config.sh
export CWD="$PWD"

PROG=`basename $0 ".sh"`
STDOUT_DIR="$CWD/out/$PROG"

init_dir "$STDOUT_DIR" "$READY_DIR"

for i in $SAMPLE_NAMES; do
    export SAMPLE=$i
    echo $i
    qsub -V -j oe -o "$STDOUT_DIR" $WORKER_DIR/extract-pe.sh
done

