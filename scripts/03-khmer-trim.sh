#!/usr/bin/env bash
#
# Use khmer to trim reads so that there are no kmers with counts greater than 2
#

set -u
source ./config.sh
export CWD="$PWD"
export MAXKMER_COUNT=2

PROG=`basename $0 ".sh"`
STDOUT_DIR="$CWD/out/$PROG"

init_dir "$STDOUT_DIR" "$TRIMMED_DIR"

for i in $SAMPLE_NAMES; do
    export SAMPLE=$i
    echo $i
    qsub -V -j oe -o "$STDOUT_DIR" $WORKER_DIR/trim-kmers.sh
done

