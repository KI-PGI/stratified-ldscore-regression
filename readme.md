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
scripts/cell-type-ldscores.sh dataset2_genes.bed workflow/dcgna_t2d_genes
```

The repository provides a script that will take:
1. path to a bedfile
2. outputdir

And will run a slurm-array job to calculate LDscores
```bash
BEDFILE=$(realpath /cfs/klemming/projects/supr/ki-pgi-storage/shared/arvhar/dataset2_genes.bed)
OUTDIR=$(realpath ~/arvhar/dcgna_t2d_genes)
BASEDIR=$(realpath /cfs/klemming/home/a/arvhar/arvhar/stratified-ldscore-regression)


```



```{r}
library(dplyr)
library(stringr)
df |> 
    filter(str_detect(X1, "chr", negate = TRUE)) |>
    mutate(
     X2 = as.integer(X2),
     X3 = as.integer(X3)

    )
```