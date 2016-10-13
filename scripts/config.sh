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
