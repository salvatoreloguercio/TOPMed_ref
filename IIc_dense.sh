#!/bin/bash -l

for i in {1..22}; do

sbatch --export=input=$i --job-name=IIc_dense_chr$i --output=IIc_dense_chr$i.%J IIc_dense.sbatch;
sleep 1;

done
