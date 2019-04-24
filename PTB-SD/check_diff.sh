dir_gold=/path/to/LDC99T42_PTB3/processed/dep_pos-gold
dir_pred=/path/to/LDC99T42_PTB3/processed/dep_pos-st3.3.0/

for file in $dir_pred/*; do
    base=`basename $file`
    base=${base%.*}
    echo $file
    echo "lines"
    wc -l ${dir_gold}${base}.mrg
    wc -l ${dir_pred}${base}.dep
    echo "word diff:"
    diff <(grep -v '^#' ${dir_gold}${base}.mrg | cut -f2 ) <(cat ${dir_pred}${base}.dep | cut -f1) | wc -l
    echo "pos accuracy:"
    paste <(grep -v '^#' ${dir_gold}${base}.mrg | cut -f4) <(cut -f2 ${dir_pred}${base}.dep ) | awk '{if ($1==$2) tp+=1;} END {print tp / NR, tp, NR}'
    echo ""
done
