
# FOR TESTING
bedfile=$1
outdir=$2 
BASEDIR=$3
#bedfile=/cfs/klemming/projects/supr/ki-pgi-storage/shared/arvhar/development-scz/workflow/yang_li_2023/PVALB_1.bed
BASEDIR="/cfs/klemming/projects/supr/ki-pgi-storage/shared/arvhar/stratified-ldscore-regression"
annotation_name=$(basename $bedfile .bed)

#  parse arguments -------------------------------------------------------------

plink_ref=$(realpath $BASEDIR/workflow/sldsc_ref/1000G_EUR_Phase3_plink/1000G.EUR.QC)
hm_snp=$(realpath $BASEDIR/workflow/sldsc_ref/hm_snp.txt)
container=$(realpath $BASEDIR/workflow/containers/ldsc_latest.sif)
annot_file=${outdir}/baseline.$chr.annot.gz

echo PARAMS ----------------
echo bedfile: $bedfile
echo saving files to outdir: $outdir
echo plink_ref: $plink_ref
echo hm_snp: $hm_snp
echo using annot_file: $annot_file
echo ----------------------

# check if run as array job -----------------------------------------------------

if [ -n "$SLURM_ARRAY_TASK_ID" ]; then
    echo "Running on SLURM cluster with array index $SLURM_ARRAY_TASK_ID"
    chr=$SLURM_ARRAY_TASK_ID
else
    echo "Running locally without SLURM_ARRAY_TASK_ID. Exiting."
    exit 1
fi

# check if workdir exists ------------------------------------------------------§

annot_file=${workdir}/baseline.$chr.annot.gz
echo using annot_file: $annot_file

# create workdir if it doesn't exist
if [ ! -d "$workdir" ]; then
    mkdir -p $workdir
fi


# ----------------------------------------------------------------------------

# assumes that computation cluster uses module system
# if not, load python and ldsc manually
echo Calculating LDscores for chromosome $chr, saving results to: $workdir
module unload python
module load ldsc

# make ldscores
make_annot.py --bed-file $bedfile --bimfile $plink_ref.$chr.bim --annot-file $annot_file
ldsc.py --l2 --bfile ${plink_ref}.$chr --ld-wind-cm 1 --annot $annot_file --thin-annot --out $workdir/baseline.$chr --print-snps $hm_snp