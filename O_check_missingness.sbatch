#!/bin/bash -l
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --partition=shared
#SBATCH --time=20:00:00
#SBATCH -J chr20_plink2_mis
#SBATCH -o chr20_plink2_mis.%J

module load plink/2.00a3

while read path_line; do
 
 name=$(basename $path_line .vcf.gz)
 cg=$(echo $name | sed -e "s/_TOPMed_WGS_freeze\.8\.chr22\.hg38//g")


 i=20
 
 infile=$(echo $path_line | sed -e "s/chr22/chr${i}/g" )

 plink2 --vcf $infile --missing sample-only -out $cg


done < TOPmed_GRch38_frz8_paths.tsv