for file in `ls *tsv`; do
    name=${file%.*}
    out=${name}.sl
    cut -f3,4 $file | sed -e 's/'$'\t/\//g' > _tmp
    python /home/shigashi/data_shigashi/work/seikanlp/tools/common/to_chars.py -i _tmp -t word -s -n -m 1000 > $out
    rm -f _tmp
done
