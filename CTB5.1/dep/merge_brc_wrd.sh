#!/usr/local/bin/bash

# Because output of Penn2Malt contains garbled characters, replace them with original characters from wrd files

in_dir=$1
out_dir=$2

for f_word in $in_dir/*wrd ; do
    base=`basename $f_word`
    head=${base%.*}
    out=${out_dir}/${head}.dep
    f_brc=${in_dir}/${head}.brc.3.pa.gs.tab

    nol_w=`wc -l $f_word | cut -d' ' -f1`
    nol_b=`wc -l $f_brc | cut -d' ' -f1`
    if [ $nol_w != $nol_b ]; then
        echo $nol_w $nol_b $f_word $f_brc
    fi

    paste <(cat $f_word) <(cut -f2- $f_brc) > $out
    echo $out
done
