#!/bin/bash

#SBATCH -J megahit           # Job name
#SBATCH -o ./logs/megahit.%j.out    # Specify stdout output file (%j expands to jobId)
#SBATCH -p largemem           # Queue name
#SBATCH -N 1                    # Total number of nodes requested (16 cores/node)
#SBATCH -n 32                     # Total number of tasks
#SBATCH -t 48:00:00              # Run time (hh:mm:ss) - 1.5 hours
#SBATCH --mail-user=scottdaniel@email.arizona.edu
#SBATCH --mail-type=all
#SBATCH -A iPlant-Collabs         # Specify allocation to charge against

#automagic offloading for the xeon phi co-processor
#in case anything uses Intel's Math Kernel Library
export MKL_MIC_ENABLE=1
export OMP_NUM_THREADS=32
export MIC_OMP_NUM_THREADS=480
export OFFLOAD_REPORT=2

cd $WORK

export FASTQ_DIR="/work/03859/sdaniel/all_fastq_dedupped"

#apparently, megahit doesn't like it if you create directories!!!
#if [ ! -d megahit_output_dedup ]; then
#    mkdir -p megahit_output_dedup
#fi

echo "Started at $(date)"

megahit \
    --num-cpu-threads 32 \
    --memory 0.9 \
    --presets meta-large \
    -1 $FASTQ_DIR/all_dedup.1.fastq \
    -2 $FASTQ_DIR/all_dedup.2.fastq \
    -r $FASTQ_DIR/final_unpaired_dedup.fastq \
    -o megahit_output_dedup

echo "Ended at $(date)"
