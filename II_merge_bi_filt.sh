#!/bin/bash -l

for i in {1..22}; do


sbatch --export=input=$i --job-name=II_merge_chr$i --output=II_merge_chr$i.%J II_merge_bi_filt.sbatch;
sleep 1;


done
