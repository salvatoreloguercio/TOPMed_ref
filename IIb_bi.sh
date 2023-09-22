#!/bin/bash -l

for i in {1..22}; do

sbatch --export=input=$i --job-name=IIb_bi_chr$i --output=IIb_bi_chr$i.%J IIb_bi.sbatch;
sleep 1;

done
