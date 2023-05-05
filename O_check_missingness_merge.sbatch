#!/bin/bash -l
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --partition=shared
#SBATCH --time=20:00:00
#SBATCH -J chr20_merge_mis
#SBATCH -o chr20_merge_mis.%J

module load plink/2.00a3

cd /mnt/stsi/stsi6/Internal/TOPmed/ref_GRCh38


 plink2 --vcf TOPmed_merge_chr20.vcf.gz --missing sample-only -out merge_chr20


