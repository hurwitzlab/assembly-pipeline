#PBS -W group_list=bhurwitz
#PBS -q qualified
#PBS -l select=1:ncpus=6:mem=36gb
###and the amount of time required to run it
#PBS -l walltime=24:00:00
#PBS -l cput=24:00:00
#PBS -M scottdaniel@email.arizona.edu
#PBS -m bea

echo STARTED at $(date)

set -u

COMMON="$WORKER_DIR/common.sh"

if [ -e $COMMON ]; then
  . "$COMMON"
else
  echo Missing common \"$COMMON\"
  exit 1
fi

DIRS_TO_PROC=$(mktemp)

get_lines $DIRS_TO_DEDUP $DIRS_TO_PROC $PBS_ARRAY_INDEX $STEP_SIZE

NUM_FILES=$(lc $DIRS_TO_PROC)

echo Found \"$NUM_FILES\" files to process

for DIR in $(cat $DIRS_TO_DEDUP); do

    echo Working on $DIR

    cd $UNK_DIR/$DIR

    find ./ -type f -iname "*.fastq" -print0 | xargs -0 -I file cat file \
        > unaligned.temp

    if [[ $(file unaligned.temp) =~ "cannot" ]]; then
        echo Something went wrong with finding or catting files
        exit 123
    else
        echo Now filtering duplicates
    fi

    fastq filter --unique unaligned.temp > deduped.temp

done

echo DONE at $(date)

