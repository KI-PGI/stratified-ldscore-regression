# How to use this repository
clone from github
setup reference file paths

```
~/ki-pgi-storage/Data/downstreamGWAS/reference/sldsc_ref/
ln -s /cfs/klemming/home/a/arvhar/ki-pgi-storage/Data/downstreamGWAS/reference/ workflow

```

# How to use
Clone this repository
Download the LD-reference files
Download the apptainer

```
/cfs/klemming/home/a/arvhar/arvhar/stratified-ldscore-regression/scripts/cell-type-ldscores.sh \
    /cfs/klemming/projects/supr/ki-pgi-storage/shared/arvhar/development-scz/workflow/yang_li_2023/PVALB_1.bed \
    /cfs/klemming/home/a/arvhar/PVALB_1
```

The repository provides a script that will take:
1. path to a bedfile
2. outputdir

And will run a slurm-array job to calculate LDscores
