#!/usr/local/bin/bash

in_dir=$1
out_dir=$2

for in_file in ${in_dir}/*; do
    echo read $in_file
    base=`basename $in_file`
    base=${base%.*}
    out_file=${out_dir}/${base}.tok
    python extract_and_tokenize.py $in_file $out_file
done
            
