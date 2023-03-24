#!/bin/bash -l

for i in {1..22}; do
if [ ! -e "chr${i}" ]; then
    mkdir chr${i}
fi
done

while read path_line; do

 vcf=$(basename $path_line .vcf.gz | cut -d "_" -f 1-2 )

  sbatch --export=input=$path_line --job-name=I_rename_bi_$vcf --output=I_rename_bi_$vcf.out I_rename_bi.sbatch;
  sleep 1;

done < test.txt