dir=$1
dir_dom=${dir}/domains
train=${dir}/train.txt
devel=${dir}/devel.txt

mkdir -p $dir_dom

get_top_90per_line_num() {
    N=`wc -l $1 | cut -d' ' -f1`
    num0=$(($N*9/10))
    num1=`head -${num0} $1 | grep -n '^$' | tail -1 | cut -d: -f1`
    echo $num1
}

get_bottom_10per_line_num() {
    N=`wc -l $1 | cut -d' ' -f1`
    num0=$(($N*9/10))
    num1=`head -${num0} $1 | grep -n '^$' | tail -1 | cut -d: -f1`
    num2=$(($N-$num1))
    echo $num2
}

: > $train
: > $devel
for cate in `echo OC OW OY PB PM PN`; do
    file=${dir_dom}/${cate}.txt
    grep $cate ${dir}/core_other.txt | sed -e 's/^B'$'\t/\\n/g' | sed 's/^I'$'\t//g' | sed 1d > $file
    head -`get_top_90per_line_num    $file` $file >> $train
    tail -`get_bottom_10per_line_num $file` $file >> $devel
    echo "" >> $devel
    echo finish $cate
done
