#!/bin/bash -l
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --partition=shared
#SBATCH --time=6:00:00
#SBATCH -J TOPm_get_s
#SBATCH -o TOPm_get_s.%J


module load samtools

while read path_line; do

vcf=$(basename $path_line .vcf.gz | sed -e "s/_TOPMed_WGS_freeze\.8\.chr22\.hg38//g") 

echo $vcf >> TOPmed_frz8_samples.txt

bcftools query -l $path_line > temp
wc -l temp >> TOPmed_frz8_samples.txt

cat temp >> TOPmed_frz8_samples.txt

done < TOPmed_GRch38_frz8_paths.tsv

