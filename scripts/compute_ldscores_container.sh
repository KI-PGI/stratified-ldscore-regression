#!/bin/bash

if [ -n "$SLURM_ARRAY_TASK_ID" ]; then
    echo "Running on SLURM cluster with array index $SLURM_ARRAY_TASK_ID"
    chr=$SLURM_ARRAY_TASK_ID
else
    echo "Using argument 4 as chr"
    chr=$4
fi


BEDFILE=$1
OUTDIR=$2
BASEDIR=$3


#
BED_NAME=$(basename $BEDFILE)
ANNOT_NAME=$(basename $BEDFILE .bed)

# create mounting points for apptainer
APP="$BASEDIR/workflow/ldsc_latest.sif"
APP_BED_DIR="$(dirname $BEDFILE):/tmp"
APP_WORKDIR="$OUTDIR:/mnt"
APP_REFDIR="$BASEDIR:/src"

# setup iteration specific variables
plink_ref="/src/workflow/sldsc_ref/1000G_EUR_Phase3_plink/1000G.EUR.QC"
hm_snp="/src/workflow/sldsc_ref/hm_snp.txt"
ANNOT="/mnt/baseline.$chr.annot.gz"



apptainer exec --cleanenv --bind $APP_WORKDIR,$APP_REFDIR,$APP_BED_DIR $APP \
    /tools/ldsc/make_annot.py \
    --bed-file /tmp/$BED_NAME \
    --bimfile $plink_ref.$chr.bim \
    --annot-file $ANNOT

apptainer exec --cleanenv --bind $APP_WORKDIR,$APP_REFDIR,$APP_BED_DIR $APP \
    /tools/ldsc/ldsc.py \
    --bfile ${plink_ref}.$chr \
    --ld-wind-cm 1 \
    --annot $ANNOT \
    --thin-annot \
    --out /mnt/baseline.$chr \
    --print-snps $hm_snp

