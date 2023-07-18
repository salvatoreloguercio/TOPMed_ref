#!/bin/bash -l

#for i in {20}; do
for i in `seq 5 19` `seq 21 22`;do
#i=20

sbatch --export=input=$i --job-name=IIb_bi_chr$i --output=IIb_bi_chr$i.%J IIb_bi.sbatch;
sleep 1;

done
