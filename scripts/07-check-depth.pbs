#!/usr/bin/env bash

#############################################
# Since the original assembly seems to      #
# be the best (in terms of length of        #
# contigs and number of genes) we will      #
# calculate the depth of coverage           #
# for it                                    #
#############################################

#PBS -W group_list=bhurwitz
#PBS -q qualified
#PBS -j oe
#PBS -o ./out/09-checkdepth/
#PBS -l select=1:ncpus=12:mem=72gb
###and the amount of time required to run it
#PBS -l walltime=24:00:00
#PBS -l cput=96:00:00
#PBS -M scottdaniel@email.arizona.edu
#PBS -m bea


echo Started at $(date)

if [ -n "$PBS_O_WORKDIR" ]; then
    cd $PBS_O_WORKDIR
fi

set -u

source ./config.sh

COMMON="$WORKER_DIR/common.sh"

if [ -e $COMMON ]; then
  . "$COMMON"
else
  echo Missing common \"$COMMON\"
  exit 1
fi

if [ ! -d $ALIGN_DIR ]; then
    mkdir -p $ALIGN_DIR
fi

cd $DEDUPED_DIR

printf "\nDoing bbmap...\n\n"

$HOME/bin/bbmap/bbwrap.sh ref=$CONTIG_DIR/original_all/final.contigs.fa \
    in=./all_dedup.1.fastq,./final_unpaired_dedup.fastq \
    in2=./all_dedup.2.fastq \
    out=$ALIGN_DIR/aln.sam.gz \
    kfilter=22 \
    subfilter=15 \
    maxindel=80 \
    threads=12 \
    covstats=$ALIGN_DIR/covstats.txt

echo Done at $(date)
