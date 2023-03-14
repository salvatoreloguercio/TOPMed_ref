#!/bin/bash -l


while read path_line; do
 
 cd $(dirname $path_line);

 echo $path_line;
 
 study=$(basename $path_line |  cut -f 2 -d '.')

 sbatch --export=input=$path_line --job-name=untar_$study /mnt/stsi/stsi6/Internal/TOPmed/ref_GRCh38/untar.sbatch;
    sleep 1;
    
done < topmed_vcf_paths_untar.txt
