#!/bin/bash -l

#for i in {20}; do
for i in `seq 20 22`;do
#i=20

sbatch --export=input=$i --job-name=IIc_dense_chr$i --output=IIc_dense_chr$i.%J IIc_dense.sbatch;
sleep 1;

done
