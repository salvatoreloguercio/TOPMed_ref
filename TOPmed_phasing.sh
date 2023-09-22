#!/bin/bash -l

for i in {5..19}; do

sbatch --export=input=$i --job-name=chr$i_phasing --output=chr$i_phasing.%J TOPmed_phasing.sbatch;
sleep 1;

done