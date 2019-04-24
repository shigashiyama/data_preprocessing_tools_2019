#!/bin/sh

inputdir=$1
outdir=$2

cd ../StanfordParser/3.8.0/
for file in `ls ${inputdir}`; do
    base=`basename $file`
    base=${base%.*}
    echo 'In:' ${inputdir}/${file}
    ./parse_zh-ctb.sh ${inputdir}/${file} ${outdir}/${base}.dep
    echo 'Out:' ${outdir}/${base}.dep
    echo ''
done

