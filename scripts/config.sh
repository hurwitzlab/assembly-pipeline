export CWD=$PWD
export SCRIPT_DIR=$CWD
export WORKER_DIR="$SCRIPT_DIR/workers"
#where programs are
export BIN_DIR="/rsgrps/bhurwitz/hurwitzlab/bin"
#root project dir
export PRJ_DIR="/rsgrps/bhurwitz/scottdaniel/assembly-pipeline"

# 
# Sample names
#
export SAMPLE_NAMES="DNA_1 DNA_2 DNA_3 DNA_4"


#place for sorted and merged PE'd reads and orphaned single reads
export SORTNMG_DIR="/rsgrps/bhurwitz/scottdaniel/fastq-taxoner-patric/sort-and-merged"

#place to store merged fastq's by sample
export GROUPED_DIR="$PRJ_DIR/grouped"
#place to store deduped fastq's by sample
export DEDUPED_DIR="$PRJ_DIR/deduped"
#will store graphs in $DEDUPED_DIR

#place to store read trimmed of low-abundance kmers
export TRIMMED_DIR="$PRJ_DIR/trimmed"
#place to store gzipped paired-end / single-end reads that are ready for assembly
export READY_DIR="$PRJ_DIR/ready"
#place to store assembled contigs 
export CONTIG_DIR="$PRJ_DIR/contigs"
#place to store quality reports from quast
export QUAST_DIR="$PRJ_DIR/quast"

# Usefull functions
# --------------------------------------------------
function init_dir {
    for dir in $*; do
        if [ -d "$dir" ]; then
            rm -rf $dir/*
        else
            mkdir -p "$dir"
        fi
    done
}

# --------------------------------------------------
function lc() {
    wc -l $1 | cut -d ' ' -f 1
}
