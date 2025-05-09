# How to use this repository
clone from github
setup reference file paths

```
git clone https://github.com/KI-PGI/stratified-ldscore-regression.git
cd stratified-ldscore-regression
```


```
mkdir workflow
wget https://zenodo.org/records/8367200/files/sldsc_ref.tar.gz
tar -xvf sldsc_ref.tar.gz
mv sldsc_ref workflow/
rm sldsc_ref.tar.gz
```

# edit parameter files
[env.sh](scripts/env.sh) contains the slurm parameters. edit to fit your needs.
[load_apptainer.sh] contains the code needed to make apptainer availble on your HPC. edit to fit your needs.

```
source scripts/load_apptainer.sh
(cd workflow && apptainer pull docker://arvhar/ldsc:latest)
```
# check that all files are in place
```
workflow/sldsc_ref/hm_snp.txt
workflow/ldsc_latest.sif
```


use the test.bed file to make a test run
```
mkdir -p workflow/testrun
cp test.bed workflow/testrun/
sh scripts/calc_ld.sh workflow/testrun


```
