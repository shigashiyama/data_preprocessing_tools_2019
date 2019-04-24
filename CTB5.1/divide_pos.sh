# starndard data split
# train: 1-270,400-931,1001-1151 (18089 sen)
# devel: 301-325 (348 sen)
# test:  271-300 (350 sen)
#
# [ref] (Kruengkarai 2009) http://aclweb.org/anthology/P/P09/P09-1058.pdf

ext=$1                          # seg or pos
in_dir=$2
out_dir=$3

: > ${out_dir}/train.${ext}
grep -h -v '<' ${in_dir}/chtb_0??.${ext} >> ${out_dir}/train.${ext}
grep -h -v '<' ${in_dir}/chtb_1??.${ext} >> ${out_dir}/train.${ext}
grep -h -v '<' ${in_dir}/chtb_2[0-6]?.${ext} >> ${out_dir}/train.${ext}
grep -h -v '<' ${in_dir}/chtb_270.${ext} >> ${out_dir}/train.${ext}
grep -h -v '<' ${in_dir}/chtb_[4-9]??.${ext} >> ${out_dir}/train.${ext}
grep -h -v '<' ${in_dir}/chtb_1???.${ext} >> ${out_dir}/train.${ext}

: > ${out_dir}/devel.${ext}
grep -h -v '<' ${in_dir}/chtb_30[1-9].${ext} >> ${out_dir}/devel.${ext}
grep -h -v '<' ${in_dir}/chtb_31?.${ext} >> ${out_dir}/devel.${ext}
grep -h -v '<' ${in_dir}/chtb_32[0-5].${ext} >> ${out_dir}/devel.${ext}

: > ${out_dir}/test.${ext}
grep -h -v '<' ${in_dir}/chtb_27[1-9].${ext} >> ${out_dir}/test.${ext}
grep -h -v '<' ${in_dir}/chtb_2[8-9]?.${ext} >> ${out_dir}/test.${ext}
grep -h -v '<' ${in_dir}/chtb_300.${ext} >> ${out_dir}/test.${ext}

array=("train" "devel" "test")
for ((i=0;i<${#array[@]};i++)); do
    type=${array[i]}
    cat ${out_dir}/${type}.${ext} | sed -e 's/_\-NONE\- //g' > ${out_dir}/${type}.sl
    cat ${out_dir}/${type}.sl | tr ' ' '\n' | tr '_' '\t' > ${out_dir}/${type}.wl
done

