#!/bin/bash

# Setup basic parameters
BASEDIR="$(dirname "$(dirname "$(realpath "$0")")")"
BEDFILE=$(realpath $1)
OUTDIR=$(realpath $2)
echo using $BASEDIR as basedir
echo using $BEDFILE as bedfile
echo using $OUTDIR as outdir


# error if BEDFILE missing
if [ -z "$BEDFILE" ]; then
    echo "BEDFILE not provided. Exiting."
    exit 1
fi

# try to create OUTDIR if it does not exist
if [ ! -d "$OUTDIR" ]; then
    echo creating outdir: $OUTDIR
    mkdir -p $OUTDIR
fi

# check that apptainer exists
APP=$(realpath $BASEDIR/workflow/ldsc_latest.sif)
# exit if APP does not exist
if [ ! -f "$APP" ]; then
    echo "Container not found: $APP"
    exit 1
fi


###################################################
# Start script
# get SLURM parameters
source $BASEDIR/scripts/env.sh


# echo Creating ldscores for $celltype_name
sbatch --output $OUTDIR/ldscores-%A_%a.out \
 --mem=$MEM \
 --account $ACC \
 --partition $PARTITION \
 --time=$TIME \
 --array=1-22 \
 $BASEDIR/scripts/compute_ldscores_container.sh $BEDFILE $OUTDIR $BASEDIR

