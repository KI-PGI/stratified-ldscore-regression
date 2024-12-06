#!/bin/bash

# Setup basic parameters
BASEDIR="$(dirname "$(dirname "$(realpath "$0")")")"
BEDFILE=$1
OUTDIR=$2
echo using $BASEDIR as basedir

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


# echo Creating ldscores for $celltype_name
sbatch --output $OUTDIR/$celltype_name-ldscores-%A_%a.out \
 --mem=3gb \
 --account naiss2024-5-201 \
 --partition shared \
 --time=0:30:00 \
 --array=1-22 \
 $BASEDIR/scripts/compute_ldscores_container.sh $BEDFILE $OUTDIR $BASEDIR