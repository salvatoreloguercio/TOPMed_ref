#!/bin/bash -l
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
##SBATCH --mem=150G
#SBATCH --partition=shared
#SBATCH --time=48:00:00

module load python/3.8.3
module load samtools
module load java


echo "workdir: $SLURM_SUBMIT_DIR"
cd $SLURM_SUBMIT_DIR

start=`date +%s`


echo "Renaming chrs..."

chr_names=/mnt/stsi/stsi5/raqueld/picard_utils/chr_names.txt

name=$(basename $input .vcf.gz)
cg=$(echo $name | cut -d "_" -f 1-2)

echo -e '#!/bin/bash -l' > annotate_${cg}.sh

for i in {1..22}; do
  
  infile=$(echo $input | sed -e "s/chr22/chr${i}/g" )
  outfile=$(basename $infile | sed -e "s/\.vcf\.gz/\.rename\.vcf\.gz/g")

  echo -e "bcftools annotate --rename-chrs $chr_names $infile -Oz -o chr${i}/$outfile; tabix -f -p vcf chr${i}/$outfile" >> annotate_${cg}.sh

done

parallel -j 16 < annotate_${cg}.sh

#rm annotate_${cg}.sh



echo "Extract biallelic..."

echo -e '#!/bin/bash -l' > bi_${cg}.sh

for i in {1..22}; do

    infile=$(basename $input .vcf.gz | sed -e "s/chr22/chr${i}/g" ).rename.vcf.gz
    outfile=$(echo ${infile} | sed -e 's/\.rename\.vcf\.gz/\.rename\.bi\.vcf\.gz/g')

    echo -e "bcftools view chr${i}/$infile -M 2 -m 2 -v snps -Oz -o chr${i}/$outfile; tabix -f -p vcf chr${i}/$outfile" >> bi_${cg}.sh
done

parallel -j 16 < bi_${cg}.sh

#rm bi_${cg}.sh



echo "Checking results..."

echo -e '#!/bin/bash -l' > run_final_check_${cg}.sh

for i in {1..22}; do

    infile=$(basename $input .vcf.gz | sed -e "s/chr22/chr${i}/g" ).rename.bi.vcf.gz

    echo -e "nvar=\$(zcat chr${i}/$infile | grep -v \"#\" | wc -l); echo $i \$nvar >> bi_filt_count_${cg}.txt" >> run_final_check_${cg}.sh
done

parallel -j 16 < run_final_check_${cg}.sh

#rm run_final_check_${cg}.sh

#cat final_lifted_count_{1..22}.txt

end=`date +%s`

runtime=$((end-start))

echo "Total runtime (16 cores): ${runtime}"

