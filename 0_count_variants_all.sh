#!/bin/bash -l


while read path_line; do

 vcf=$(basename $path_line .vcf.gz | sed -e "s/_TOPMed_WGS_freeze\.8\.chr22\.hg38//g") #cut -d "_" -f 1-2 )

  sbatch --export=input=$path_line --job-name=0_count_variants_all_$vcf --output=0_count_variants_all_$vcf.%J 0_count_variants_all.sbatch;
  sleep 1;

done < TOPmed_GRch38_frz8_paths.tsv