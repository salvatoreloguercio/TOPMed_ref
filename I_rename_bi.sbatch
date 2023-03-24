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

for i in {1..22}; do

  name=$(basename $input .vcf.gz)
  cg=$(echo $name | cut -d "_" -f 1-2)
  infile=$(echo $input | sed -e "s/chr22/chr${i}/g" )
  outfile=$(basename $infile | sed -e 's/\.vcf\.gz/\.rename\.vcf\.gz/g')

  echo -e "#!/bin/bash -l" > annotate_${cg}.sh
  echo -e "bcftools annotate --rename-chrs $chr_names $infile -Oz -o chr${i}/$outfile; tabix -f -p vcf chr${i}/$outfile" >> annotate_${cg}.sh

parallel -j 16 < annotate_${cg}.sh

rm annotate_${cg}.sh



echo "Extract biallelic..."


for i in {1..22}; do

    infile=$(basename $input .vcf.gz | sed -e "s/chr22/chr${i}/g" ).rename.vcf.gz
    outfile=$(echo ${infile} | sed -e 's/\.rename\.vcf\.gz/\.rename\.bi\.vcf\.gz/g')
    echo -e "#!/bin/bash -l" > bi_${cg}.sh
    echo -e "bcftools view chr${i}/$infile -M 2 -m 2 -v snps -Oz -o chr${i}/$outfile; tabix -f -p vcf chr${i}/$outfile" >> bi_${cg}.sh

parallel -j 16 < bi_${cg}.sh

rm bi_${cg}.sh



echo "Checking results..."

for i in {1..22}; do

    infile=$(basename $input .vcf.gz | sed -e "s/chr22/chr${i}/g" ).rename.bi.vcf.gz


    echo -e "nvar=\$(zcat chr${i}/$infile | grep -v \"#\" | wc -l); echo $i \$nvar > final_lifted_count_$i.txt"; done > run_final_check_${cg}.sh

parallel -j 16 < run_final_check_${cg}.sh

rm run_final_check_${cg}.sh

cat final_lifted_count_{1..22}.txt

end=`date +%s`

runtime=$((end-start))

echo "Total runtime (16 cores): ${runtime}"




###########


############

echo "Checking results..."

name=$(basename $input .hg19.vcf.gz)

i=22

echo -e "#!/bin/bash -l" > run_check_$name.sh
echo -e "nvar=\$(zcat $name.hg19.vcf.gz | grep -v \"#\" | wc -l); echo $i \$nvar > lifted_count_$name.txt" >> run_check_$name.sh
echo -e "nvar=\$(zcat $name.hg19_rejected_variants.vcf.gz | grep -v \"#\" | wc -l); echo $i \$nvar > unlifted_count_$name.txt" >> run_check_$name.sh
echo -e "nvar=\$(zcat $name.hg19.concat.vcf.gz | grep -v \"#\" | wc -l); echo $i \$nvar > lifted_concat_count_$name.txt" >> run_check_$name.sh

parallel -j 16 < run_check_$name.sh

rm run_check_$name.sh

echo "Lifted:"
cat lifted_count_$name.txt

echo "Unlifted:"
cat unlifted_count_$name.txt

echo "lifted_concat:"
cat lifted_concat_count_$name.txt



echo "Renaming chrs..."

chr_names=/mnt/stsi/stsi5/raqueld/picard_utils/chr_names.txt


    infile=$name.hg19.concat.vcf.gz
    outfile=$(echo $infile | sed -e 's/\.hg19\.concat\.vcf\.gz/\.hg19\.concat\.rename\.vcf\.gz/g')
    echo -e "#!/bin/bash -l" > annotate_$name.sh
    echo -e "bcftools annotate --rename-chrs $chr_names $infile -Oz -o $outfile; tabix -f -p vcf $outfile" >> annotate_$name.sh

parallel -j 16 < annotate_$name.sh

rm annotate_$name.sh

echo "Extract biallelic..."

    in=$name.hg19.concat.rename.vcf.gz
    out=$(echo $in | sed -e 's/\.hg19\.concat\.rename\.vcf\.gz/\.hg19\.concat\.rename\.bi\.vcf\.gz/g')
    echo -e "#!/bin/bash -l" > bi_$name.sh
    echo -e "bcftools view $in -M 2 -m 2 -v snps -Oz -o $out; tabix -f -p vcf $out" >> bi_$name.sh

parallel -j 16 < bi_$name.sh

rm bi_$name.sh



#echo "Filter missingness..."


#    infile=$name.hg19.concat.rename.bi.vcf.gz
#    outfile=$(echo $infile | sed -e 's/rename\.bi\.vcf\.gz$/rename\.bi\.dense\.vcf\.gz/g')
#    echo -e "#!/bin/bash -l" > filter_missingness_$name.sh
#    echo -e "bcftools view -i'F_MISSING<=0.1' $infile | bcftools norm /dev/stdin -d both -Oz -o $outfile; tabix -p vcf -f $outfile" >> filter_missingness_$name.sh

#parallel -j 16 < filter_missingness_$name.sh

#rm filter_missingness_$name.sh



echo "Checking filtered results..."
echo -e "#!/bin/bash -l" > run_final_check_$name.sh
echo -e "nvar=\$(zcat $name.hg19.concat.rename.bi.vcf.gz | grep -v \"#\" | wc -l); echo $i \$nvar > bi_count_$name.txt" >> run_final_check_$name.sh

parallel -j 16 < run_final_check_$name.sh

rm run_final_check_$name.sh

echo "bi only:"
cat bi_count_$name.txt


end=`date +%s`

runtime=$((end-start))

echo "Total runtime using 16 cores: ${runtime}"