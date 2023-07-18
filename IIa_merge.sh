#!/bin/bash -l

#for i in {1..22}; do
#for i in {20}; do
#for i in `seq 1 4`;do
# `seq 16 22`;do
i=2

sbatch --export=input=$i --job-name=IIa_merge_chr$i --output=IIa_merge_chr$i.%J IIa_merge.sbatch;
sleep 1;


#done
