#!/bin/bash -l
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
##SBATCH --mem=150G
#SBATCH --partition=shared
#SBATCH --time=48:00:00
#SBATCH -J 0_count_variants_all
#SBATCH -o 0_count_variants_all.%J

module load samtools


echo "workdir: $SLURM_SUBMIT_DIR"
cd $SLURM_SUBMIT_DIR


while read input; do

 vcf=$(basename $path_line .vcf.gz | sed -e "s/_TOPMed_WGS_freeze\.8\.chr22\.hg38//g") #cut -d "_" -f 1-2 )


name=$(basename $input .vcf.gz)
cg=$(echo $name | sed -e "s/_TOPMed_WGS_freeze\.8\.chr22\.hg38//g")  #cut -d "_" -f 1-2)

echo $cg
echo "Checking variants..."

echo -e '#!/bin/bash -l' > 0_check_variants_all_${cg}.sh

for i in {1..22}; do

    infile=$(echo $input | sed -e "s/chr22/chr${i}/g" )

    echo -e "nvar=\$(zcat $infile | grep -v \"#\" | wc -l); echo $i \$nvar >> 0_check_variants_all_${cg}.txt" >> 0_check_variants_all_${cg}.sh
done

parallel -j 16 < 0_check_variants_all_${cg}.sh

#rm run_final_check_${cg}.sh

#cat final_lifted_count_{1..22}.txt

done < TOPmed_GRch38_frz8_paths.tsv
