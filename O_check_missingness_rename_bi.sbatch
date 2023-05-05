#!/bin/bash -l
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --partition=shared
#SBATCH --time=24:00:00
#SBATCH -J chr20_plink2_mis
#SBATCH -o chr20_plink2_mis_rename.%J

module load plink/2.00a3

cd /mnt/stsi/stsi6/Internal/TOPmed/ref_GRCh38/chr20

# check rename vcfs
ls *rename.vcf.gz > rename_list.txt

while read path_line; do
 
 name=$(basename $path_line .vcf.gz)
 cg=$(echo $name | sed -e "s/_TOPMed_WGS_freeze\.8\.chr22\.hg38//g")


 i=20
 
 infile=$(echo $path_line | sed -e "s/chr22/chr${i}/g" )

 plink2 --vcf $infile --missing sample-only -out ${cg}_rename


done < rename_list.txt

# repeat for rename_bi
ls *rename_bi.vcf.gz > rename_bi_list.txt

while read path_line; do
 
 name=$(basename $path_line .vcf.gz)
 cg=$(echo $name | sed -e "s/_TOPMed_WGS_freeze\.8\.chr22\.hg38//g")

 
 infile=$(echo $path_line | sed -e "s/chr22/chr${i}/g" )

 plink2 --vcf $infile --missing sample-only -out ${cg}_rename_bi


done < rename_bi_list.txt