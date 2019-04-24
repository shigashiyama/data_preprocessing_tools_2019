#!/bin/sh

input=$1
outdir=$2

cd ../StanfordSegmenter/stanford-segmenter
base=`basename $input`
base=${base%.*}
echo $base
./segment.sh ctb $input UTF-8 0 > ${outdir}/${base}.seg
