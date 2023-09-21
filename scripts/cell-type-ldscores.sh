
# author: Arvid Harder, code modified from Shuyang Yao and Lu Yi
# dependencies: assumes use on longleaf computation cluster



# Reference files
plink_ref="workflow/reference_files/1000G_EUR_Phase3_plink/1000G.EUR.QC"
hm_snp="workflow/reference_files/hm_snp.txt"

# based on the inputted bedfile
bedfile=$1
celltype_name=$(basename $bedfile .bed)
outdir="workflow/ldscores/$celltype_name"


echo Creating ldscores for $celltype_name
sbatch --output workflow/slurm/$celltype_name-ldscores-%A_%a.out --array=1-22 \
 scripts/compute_ldscores.sh $bedfile $outdir $plink_ref $hm_snp

