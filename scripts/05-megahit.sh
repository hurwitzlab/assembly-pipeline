#!/usr/bin/env bash
#
# Use megahit to assemble reads 
#

set -u
source ./config.sh
export CWD="$PWD"

PROG=`basename $0 ".sh"`
STDOUT_DIR="$CWD/out/$PROG"

init_dir "$STDOUT_DIR"

for i in $SAMPLE_NAMES; do
    export SAMPLE=$i
    echo $i
    init_dir "$CONTIG_DIR"/"$SAMPLE"
    qsub -V -j oe -o "$STDOUT_DIR" $WORKER_DIR/megahit.sh
done

