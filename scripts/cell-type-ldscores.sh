
# author: Arvid Harder, code modified from Shuyang Yao and Lu Yi




# Reference files
plink_ref="workflow/reference_files/sldsc_ref/1000G_EUR_Phase3_plink/1000G.EUR.QC"
hm_snp="workflow/reference_files/sldsc_ref/hm_snp.txt"

# based on the provided bedfile
bedfile=$1
celltype_name=$(basename $bedfile .bed)
outdir="workflow/ldscores/$celltype_name"


echo Creating ldscores for $celltype_name
sbatch --output workflow/slurm/$celltype_name-ldscores-%A_%a.out --mem=3gb --time=0:30:00 --array=1-22 \
    scripts/compute_ldscores_per_chr.sh $bedfile $outdir $plink_ref $hm_snp

