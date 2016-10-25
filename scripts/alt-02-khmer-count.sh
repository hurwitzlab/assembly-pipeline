#!/usr/bin/env bash
#
# Build a kmer counting graph for all the sample concat'd together
#

set -u
source ./config.sh
export CWD="$PWD"

PROG=`basename $0 ".sh"`
STDOUT_DIR="$CWD/out/$PROG"

init_dir "$STDOUT_DIR"

qsub -V -j oe -o "$STDOUT_DIR" $WORKER_DIR/alt-count-kmers.sh

