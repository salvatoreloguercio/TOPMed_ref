#!/bin/bash -l

for i in {1..22}; do
if [ ! -e "chr${i}" ]; then
    mkdir chr${i}
fi
done

while read path_line; do

 vcf=$(basename $path_line .vcf.gz | sed -e "s/_TOPMed_WGS_freeze\.8\.chr22\.hg38//g") #cut -d "_" -f 1-2 )

  sbatch --export=input=$path_line --job-name=I_rename_bi_$vcf --output=I_rename_bi_$vcf.%J I_rename_bi.sbatch;
  sleep 1;

done < TOPmed_GRch38_frz8_paths.tsv