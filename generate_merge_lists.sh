#!/bin/bash -l


for i in {1..22}; do
  
  cd chr${i}
   find $PWD -name "*.bi.vcf.gz" > TOPMed_merge_list_chr${i}.txt
   wc -l TOPMed_merge_list_chr${i}.txt
  cd ..
done
