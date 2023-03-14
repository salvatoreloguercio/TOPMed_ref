#!/bin/bash -l

while read tpath; do

study=$(echo $tpath | cut -d '.' -f2)
# echo $study

cnt=$( dirname $tpath | xargs -I % bash -c "ls %/*.gz" | wc -l )   # https://superuser.com/questions/304189/expanding-globs-in-xargs

echo -e "$study\t$cnt"

done < TOPmed_GRch38_frz8_paths.tsv
