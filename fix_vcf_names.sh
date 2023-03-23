#!/bin/bash -l

# manually fix some vcf file names - for CVhealth, MESA, WHI

# CVHealth c2

cd /mnt/stsi/stsi6/External/TOPMed/TOPMed.CVHealth.phs000993.c2.DS-CVD-IRV-MDS/phs000993.v5.p2/RootStudyConsentSet_phs000993.TOPMed_WGS_HVH.v5.p2.c2.DS-CVD-IRB-MDS/GenotypeFiles/consent2/

mv HVH_phs000993_TOPMed_WGS_freeze.8.chr22.hg38.c2.vcf.gz HVH_phs000993_TOPMed_WGS_freeze.8.chr22.hg38.vcf.gz

for file in *.hg38.vcf.gz; do

  mv "$file" "${file/hg38.vcf.gz/hg38.c2.vcf.gz}"

done

# CVHealth c1

cd /mnt/stsi/stsi6/External/TOPMed/TOPMed.CVHealth.phs000993.c1.HMB-IRB-MDS/phs000993.v5.p2/RootStudyConsentSet_phs000993.TOPMed_WGS_HVH.v5.p2.c1.HMB-IRB-MDS/GenotypeFiles/consent1/

mv HVH_phs000993_TOPMed_WGS_freeze.8.chr22.hg38.c1.vcf.gz HVH_phs000993_TOPMed_WGS_freeze.8.chr22.hg38.vcf.gz

for file in *.hg38.vcf.gz; do

  mv "$file" "${file/hg38.vcf.gz/hg38.c1.vcf.gz}"

done

# MESA c1 - rename tabix too

cd /mnt/stsi/stsi6/External/TOPMed/TOPMed.MESA.phs001416.c1.HMB/phs001416.v2.p1/RootStudyConsentSet_phs001416.TOPMed_WGS_MESA.v2.p1.c1.HMB/GenotypeFiles/phg001275.v1.TOPMed_WGS_MESA_v2.genotype-calls-vcf.WGS_markerset_grc38.c1.HMB/

mv MESA_phs001416_TOPMed_WGS_freeze.8.chr22.hg38.c1.vcf.gz MESA_phs001416_TOPMed_WGS_freeze.8.chr22.hg38.vcf.gz

for file in *.hg38.vcf.gz; do

  mv "$file" "${file/hg38.vcf.gz/hg38.c1.vcf.gz}"

done

for file in *.hg38.vcf.gz.tbi; do

  mv "$file" "${file/hg38.vcf.gz.tbi/hg38.c1.vcf.gz.tbi}"

done

# MESA c2

cd /mnt/stsi/stsi6/External/TOPMed/TOPMed.MESA.phs001416.c2.HMB-NPU/phs001416.v2.p1/RootStudyConsentSet_phs001416.TOPMed_WGS_MESA.v2.p1.c2.HMB-NPU/GenotypeFiles/phg001275.v1.TOPMed_WGS_MESA_v2.genotype-calls-vcf.WGS_markerset_grc38.c2.HMB-NPU/c2

mv MESA_phs001416_TOPMed_WGS_freeze.8.chr22.hg38.c2.vcf.gz MESA_phs001416_TOPMed_WGS_freeze.8.chr22.hg38.vcf.gz

for file in *.hg38.vcf.gz; do

  mv "$file" "${file/hg38.vcf.gz/hg38.c2.vcf.gz}"

done

for file in *.hg38.vcf.gz.tbi; do

  mv "$file" "${file/hg38.vcf.gz.tbi/hg38.c2.vcf.gz.tbi}"

done

# WHI c1

cd /mnt/stsi/stsi6/External/TOPMed/TOPMed.WHI.phs001237.c1.HMB-IRB/phs001237.v2.p1/RootStudyConsentSet_phs001237.TOPMed_WGS_WHI.v2.p1.c1.HMB-IRB/GenotypeFiles/c1

mv WHI_phs001237_TOPMed_WGS_freeze.8.chr22.hg38.c1.vcf.gz WHI_phs001237_TOPMed_WGS_freeze.8.chr22.hg38.vcf.gz

for file in *.hg38.vcf.gz; do

  mv "$file" "${file/hg38.vcf.gz/hg38.c1.vcf.gz}"

done

for file in *.hg38.vcf.gz.tbi; do

  mv "$file" "${file/hg38.vcf.gz.tbi/hg38.c1.vcf.gz.tbi}"

done

# WHI c2

cd /mnt/stsi/stsi6/External/TOPMed/TOPMed.WHI.phs001237.c2.HMB-IRB-NPU/phs001237.v2.p1/RootStudyConsentSet_phs001237.TOPMed_WGS_WHI.v2.p1.c2.HMB-IRB-NPU/GenotypeFiles/c2

mv WHI_phs001237_TOPMed_WGS_freeze.8.chr22.hg38.c2.vcf.gz WHI_phs001237_TOPMed_WGS_freeze.8.chr22.hg38.vcf.gz

for file in *.hg38.vcf.gz; do

  mv "$file" "${file/hg38.vcf.gz/hg38.c2.vcf.gz}"

done

for file in *.hg38.vcf.gz.tbi; do

  mv "$file" "${file/hg38.vcf.gz.tbi/hg38.c2.vcf.gz.tbi}"

done


# /mnt/stsi/stsi6/External/TOPMed/TOPMed.CVHealth.phs000993.c2.DS-CVD-IRV-MDS/phs000993.v5.p2/RootStudyConsentSet_phs000993.TOPMed_WGS_HVH.v5.p2.c2.DS-CVD-IRB-MDS/GenotypeFiles/consent2/HVH_phs000993_TOPMed_WGS_freeze.8.chr22.hg38.c2.vcf.gz
# /mnt/stsi/stsi6/External/TOPMed/TOPMed.CVHealth.phs000993.c1.HMB-IRB-MDS/phs000993.v5.p2/RootStudyConsentSet_phs000993.TOPMed_WGS_HVH.v5.p2.c1.HMB-IRB-MDS/GenotypeFiles/consent1/HVH_phs000993_TOPMed_WGS_freeze.8.chr22.hg38.c1.vcf.gz

# /mnt/stsi/stsi6/External/TOPMed/TOPMed.MESA.phs001416.c1.HMB/phs001416.v2.p1/RootStudyConsentSet_phs001416.TOPMed_WGS_MESA.v2.p1.c1.HMB/GenotypeFiles/phg001275.v1.TOPMed_WGS_MESA_v2.genotype-calls-vcf.WGS_markerset_grc38.c1.HMB/MESA_phs001416_TOPMed_WGS_freeze.8.chr22.hg38.c1.vcf.gz
# /mnt/stsi/stsi6/External/TOPMed/TOPMed.MESA.phs001416.c2.HMB-NPU/phs001416.v2.p1/RootStudyConsentSet_phs001416.TOPMed_WGS_MESA.v2.p1.c2.HMB-NPU/GenotypeFiles/phg001275.v1.TOPMed_WGS_MESA_v2.genotype-calls-vcf.WGS_markerset_grc38.c2.HMB-NPU/c2/MESA_phs001416_TOPMed_WGS_freeze.8.chr22.hg38.c2.vcf.gz

# /mnt/stsi/stsi6/External/TOPMed/TOPMed.WHI.phs001237.c1.HMB-IRB/phs001237.v2.p1/RootStudyConsentSet_phs001237.TOPMed_WGS_WHI.v2.p1.c1.HMB-IRB/GenotypeFiles/c1/WHI_phs001237_TOPMed_WGS_freeze.8.chr22.hg38.c1.vcf.gz        
#/mnt/stsi/stsi6/External/TOPMed/TOPMed.WHI.phs001237.c2.HMB-IRB-NPU/phs001237.v2.p1/RootStudyConsentSet_phs001237.TOPMed_WGS_WHI.v2.p1.c2.HMB-IRB-NPU/GenotypeFiles/c2/WHI_phs001237_TOPMed_WGS_freeze.8.chr22.hg38.c2.vcf.gz  