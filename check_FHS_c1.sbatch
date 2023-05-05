#!/bin/bash -l
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --partition=shared
#SBATCH --time=24:00:00
#SBATCH -J check_FHS
#SBATCH -o check_FHS.%J



echo "Checking results..."

echo -e '#!/bin/bash -l' > run_check_FHS_c1.sh

input=/mnt/stsi/stsi6/External/TOPMed/TOPMed.Framingham.WholeGene.phs000974.c1.HMB-IRB-MDS/phs000974.v4.p3/PhenoGenotypeFiles/RootStudyConsentSet_phs000974.TOPMed_WGS_Framingham.v4.p3.c1.HMB-IRB-MDS/GenotypeFiles/phg001282.v1.TOPMed_WGS_Framingham_v4.genotype-calls-vcf.WGS_markerset_grc38.c1.HMB-IRB-MDS/cg1_FHS_phs000974_TOPMed_WGS_freeze.8.chr22.hg38.vcf.gz

for i in {1..22}; do

   infile=$(basename $input | sed -e "s/chr22/chr${i}/g" )

    echo -e "nvar=\$(zcat $infile | grep -v \"#\" | wc -l); echo $i \$nvar >> bi_filt_count_FHS_c1.txt" >> run_check_FHS_c1.sh
done

parallel -j 16 < run_check_FHS_c1.sh