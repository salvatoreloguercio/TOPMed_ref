#!/bin/bash -l
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=48
#SBATCH --mem=720G
#SBATCH --partition=stsi
#SBATCH --time=120:00:00
##SBATCH --job-name=chr21_phasing
##SBATCH --output=%x.oe%j


module load java
module load samtools

echo "workdir: $SLURM_SUBMIT_DIR"
cd $SLURM_SUBMIT_DIR

java -Xmx720g -jar beagle.22Jul22.46e.jar \
        gt="/mnt/stsi/stsi6/Internal/TOPmed/ref_GRCh38/TOPmed_merge_chr${input}_bi_dense.vcf.gz" \
        map="/mnt/stsi/stsi6/Internal/TOPmed/ref_GRCh38/plink_maps/plink.chr${input}.GRCh38.map" \
        window=20.0 \
        out="/mnt/stsi/stsi6/Internal/TOPmed/ref_GRCh38/TOPmed_merge_chr${input}_bi_dense_phased"


tabix -p vcf -f /mnt/stsi/stsi6/Internal/TOPmed/ref_GRCh38/TOPmed_merge_chr${input}_bi_dense_phased.vcf.gz