export CWD=$PWD
export SCRIPT_DIR=$CWD
export WORKER_DIR="$SCRIPT_DIR/workers"
#where programs are
export BIN_DIR="/rsgrps/bhurwitz/hurwitzlab/bin"
#assemblies of ALL the reads
export ALL_DIR="/rsgrps/bhurwitz/scottdaniel/assembly-pipeline"
#project dir
export PRJ_DIR="/rsgrps/bhurwitz/scottdaniel/unknown-assembly"
#source dir for fastqs
export SRC_DIR="/rsgrps/bhurwitz/scottdaniel/fastq-taxoner-patric"
# 
# Sample names
#
export SAMPLE_NAMES="DNA_1 DNA_2 DNA_3 DNA_4"

#place for sorted and merged PE'd reads and orphaned single reads (if we need them)
export SORTNMG_DIR="$SRC_DIR/sort-and-merged"
#lq-reads
export LQ_DIR="$SRC_DIR/lq-out"
#unknown species reads
export UNK_DIR="$SRC_DIR/unk-out2"

#place to store cat'd fastqs 
export GROUPED_DIR="$PRJ_DIR/concat"
#name for concat'd low alignment score reads
export LOWALN="all-low-qual.fastq"
#name for concat'd unknown species reads
export UNKSPEC="all-unk.fastq"
#place to store deduped fastqs
export DEDUPED_DIR="$PRJ_DIR/deduped"
#will store graphs in $DEDUPED_DIR

#place for sorted fastq (since extract-paired-reads.py needs that)
export SORTED_DIR="$PRJ_DIR/sorted"

#place for fastqs ready to assembly
export READY_DIR="$PRJ_DIR/ready"
#place to store assembled contigs 
export CONTIG_DIR="$PRJ_DIR/contigs"

#place to store quality reports from quast
#will use old "assembly-pipeline" dir because that will allows us to compare
export QUAST_DIR="$SRC_DIR/quast_results"
#place to store alignment of original reads to contigs for calculation of depth
export ALIGN_DIR="$PRJ_DIR/aligned"

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
