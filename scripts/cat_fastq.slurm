#!/bin/bash

#SBATCH -J catcat           # Job name
#SBATCH -o ./logs/cat.%j.out    # Specify stdout output file (%j expands to jobId)
#SBATCH -p normal           # Queue name
#SBATCH -N 1                     # Total number of nodes requested (16 cores/node)
#SBATCH -n 16                     # Total number of tasks
#SBATCH -t 12:00:00              # Run time (hh:mm:ss) - 1.5 hours
#SBATCH --mail-user=scottdaniel@email.arizona.edu
#SBATCH --mail-type=all
#SBATCH -A iPlant-Collabs         # Specify allocation to charge against

#automagic offloading for the xeon phi co-processor
#in case anything uses Intel's Math Kernel Library
export MKL_MIC_ENABLE=1
export OMP_NUM_THREADS=16
export MIC_OMP_NUM_THREADS=240
export OFFLOAD_REPORT=2

cd $WORK 

export FASTQ_DIR="/work/03859/sdaniel/fastq-taxoner-patric/sort-and-merged"
export FINAL_DIR="/work/03859/sdaniel/all_fastq"

if [ ! -d $FINAL_DIR ]; then
    mkdir -p $FINAL_DIR
fi

echo "Getting all the left reads together"
find $FASTQ_DIR -iname \*.1.fastq -print0 | xargs -0 -I files cat files \
    > $FINAL_DIR/all_left_reads.fastq

echo "Getting all the right reads together"
find $FASTQ_DIR -iname \*.2.fastq -print0 | xargs -0 -I files cat files \
    > $FINAL_DIR/all_right_reads.fastq

echo "Getting all the single reads together"
find $FASTQ_DIR -iname \*nomatch\* -print0 | xargs -0 -I files cat files \
    > $FINAL_DIR/all_unpaired_reads.fastq
