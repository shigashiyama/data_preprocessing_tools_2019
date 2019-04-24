#### set file paths

input_dir=$1   #BCCWJ1.1/Disk4/TSV_SUW_OT
output_dir=$2  #out
coreid_file=core.list

get_id_list() {
    list=""
    while read line; do
        list="${list} $line"
    done
    echo $list
}
coreids=`grep '_' $coreid_file | get_id_list`

extract_non_core() {
    cat $1 | while read line; do
        IFS=''
        # SUW - 1:category, 2:fileid, 10:bos, 24:word surface, 17:pos, 18:conjugation_type, 19:conjugation_form, 22:word lemma, 25:reading

        fileid=`echo $line | cut -d$'\t' -f2`
        res=`echo $coreids | grep $fileid`
        if [ -n "$res" ]; then
            continue
        fi

        echo $line | awk -F$'\t' 'BEGIN{OFS="\t"}{print($10,$1,$2,$24,$17,$18,$19,$22,$25)}'
    done
}


mkdir -p ${output_dir}/tsv ${output_dir}/txt

for cate in `echo LB OB OL OM OP OT OV`; do
    echo $cate
    dir=${input_dir}/${cate}
    for file in `ls $dir`; do
        echo $file
        file_full=${dir}/${file}
        file_head=${file%.*}
        paste <(cut -f10 $file_full) <(cut -f1,2,24 $file_full) <(cut -f17-19,22,25 $file_full) > ${output_dir}/tsv/${file_head}.tsv
        cat ${output_dir}/tsv/${file_head}.tsv | sed -e 's/^B'$'\t/\\n/g' | sed 's/^I'$'\t//g' | sed 1d > ${output_dir}/txt/${file_head}.txt
    done
done

for cate in `echo OC OW OY PB PM PN`; do # 鬼のように時間がかかる (2週間以上) ので複数マシンで並列実行にすべき
    dir=${input_dir}/${cate}
    echo $cate
    for file in `ls $dir`; do
        echo ${dir}/${file}
        file_full=${dir}/${file}
        file_head=${file%.*}
        extract_non_core ${file_full} > ${output_dir}/tsv/${file_head}.tsv
        cat ${output_dir}/tsv/${file_head}.tsv | sed -e 's/^B'$'\t/\\n/g' | sed 's/^I'$'\t//g' | sed 1d > ${output_dir}/txt/${file_head}.txt
    done
done
