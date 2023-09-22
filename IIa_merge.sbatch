#!/bin/bash -l
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=200G
#SBATCH --partition=highmem
#SBATCH --time=300:00:00

module load samtools

echo "workdir: $SLURM_SUBMIT_DIR"
cd $SLURM_SUBMIT_DIR

start=`date +%s`


bcftools merge --threads 16 -l /mnt/stsi/stsi6/Internal/TOPmed/ref_GRCh38/chr${input}/TOPMed_merge_list_chr${input}.txt -m snps -Oz -o TOPmed_merge_chr${input}.vcf.gz --force-samples

#bcftools view --threads 16 TOPmed_merge_chr${input}.vcf.gz -M 2 -m 2 -v snps -Oz -o TOPmed_merge_chr${input}_bi.vcf.gz; tabix -f -p vcf TOPmed_merge_chr${input}_bi.vcf.gz

#bcftools view -i'F_MISSING<=0.0' TOPmed_merge_chr${input}_bi.vcf.gz | bcftools norm --threads 16 /dev/stdin -d both -Oz -o TOPmed_merge_chr${input}_bi_dense.vcf.gz; tabix -p vcf -f TOPmed_merge_chr${input}_bi_dense.vcf.gz


end=`date +%s`

runtime=$((end-start))

echo "Total runtime (16 cores): ${runtime}"


