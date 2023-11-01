mkdir -p workflow/reference_files

echo downloading reference files from Zenodo
wget https://zenodo.org/records/8367200/files/sldsc_ref.tar.gz -O workflow/reference_files/sldsc_ref.tar.gz
echo Checking that file download was successful

# check that md5 is equal to 

expected_md5="442741559abab2680ad431021244e1f7 workflow/reference_files/sldsc_ref.tar.gz"
actual_md5=$(md5sum workflow/reference_files/sldsc_ref.tar.gz)
echo expected md5: $expected_md5
echo actual md5: $actual_md5

echo untarring files
tar -xvzf workflow/reference_files/sldsc_ref.tar.gz -C workflow/reference_files/
