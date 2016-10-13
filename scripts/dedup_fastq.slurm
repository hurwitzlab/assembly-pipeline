#!/bin/bash

#SBATCH -J dedup           # Job name
#SBATCH -o ./logs/dedup.%j.out    # Specify stdout output file (%j expands to jobId)
#SBATCH -p largemem           # Queue name
#SBATCH -N 1                     # Total number of nodes requested (16 cores/node)
#SBATCH -n 32                  # Total number of tasks
#SBATCH -t 12:00:00              # Run time (hh:mm:ss) - 1.5 hours
#SBATCH --mail-user=scottdaniel@email.arizona.edu
#SBATCH --mail-type=all
#SBATCH -A iPlant-Collabs         # Specify allocation to charge against

echo "Started at $(date)"

#automagic offloading for the xeon phi co-processor
#in case anything uses Intel's Math Kernel Library
export MKL_MIC_ENABLE=1
export OMP_NUM_THREADS=32
export MIC_OMP_NUM_THREADS=480
export OFFLOAD_REPORT=2

cd $WORK 

export MERGER="/work/03859/sdaniel/fastq-taxoner-patric/scripts/workers/mergeShuffledFastqSeqs.pl"
export FINAL_DIR="/work/03859/sdaniel/all_fastq"
export DEDUP_DIR="/work/03859/sdaniel/all_fastq_dedupped"

if [ ! -d $DEDUP_DIR ]; then
    mkdir -p $DEDUP_DIR
fi

#echo "Dedupeing left reads"
#fastq filter --adjust 64 --unique $FINAL_DIR/all_left_reads.fastq > $DEDUP_DIR/all_left_dedup.fastq
#
#echo "Deduping right reads"
#fastq filter --adjust 64 --unique $FINAL_DIR/all_right_reads.fastq > $DEDUP_DIR/all_right_dedup.fastq
#
#echo "Deduping single reads"
#fastq filter --adjust 64 --unique $FINAL_DIR/all_unpaired_reads.fastq > $DEDUP_DIR/all_unpaired_dedup.fastq
#
echo "Reshuffling paired reads due to any lost pairs"
perl $MERGER \
    -f1 $DEDUP_DIR/all_left_dedup.fastq \
    -f2 $DEDUP_DIR/all_right_dedup.fastq \
    -r '^@(\S+)-[1|2]$' \
    -o $DEDUP_DIR/all_dedup \
    -t

if [ ! -s $DEDUP_DIR/all_dedup.nomatch1.fastq ]; then
    if [ ! -s $DEDUP_DIR/all_dedup.nomatch2.fastq ]; then
        cat $DEDUP_DIR/all_dedup.nomatch1.fastq $DEDUP_DIR/all_dedup.nomatch2.fastq $DEDUP_DIR/all_unpaired_dedup.fastq > $DEDUP_DIR/final_unpaired_dedup.fastq
    else
        echo "Error, shufflemergefasta.pl didn't work properly"
        break
    fi
fi

echo "Done at $(date)"
