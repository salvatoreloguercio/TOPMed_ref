#!/bin/bash -l

for i in {1..22}; do

sbatch --export=input=$i --job-name=IIa_merge_chr$i --output=IIa_merge_chr$i.%J IIa_merge.sbatch;
sleep 1;


#done
