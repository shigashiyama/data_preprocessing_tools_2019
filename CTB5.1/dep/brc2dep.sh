#!/usr/local/bin/bash

in_dir=$1

for fn in $in_dir/*brc ; do
    basename $fn
    java -jar ../Penn2Malt/Penn2Malt.jar $fn ../Penn2Malt/headrules_zhang07.txt 3 2 chtb
    rm -f ${fn}.3.pa.dep
    rm -f ${fn}.3.pa.pos
done
