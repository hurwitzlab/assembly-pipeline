#!/usr/bin/env bash
#
# deduplication of fastq reads
#

if [[ $# = 0 ]]; then
    echo "Need to know what to deduplicate"
    exit 1
fi

set -u
source ./config.sh
export CWD="$PWD"

PROG=`basename $0 ".sh"`
STDOUT_DIR="$CWD/out/$PROG"

init_dir "$STDOUT_DIR"

if [[ ! -d $DEDUPED_DIR ]]; then
    mkdir -p $DEDUPED_DIR
fi

cd "$GROUPED_DIR"

export FILE_TO_DEDUP=$1

qsub -V -j oe -o "$STDOUT_DIR" $WORKER_DIR/dedup.sh

