input_dir=data/jdc/2015-06
output_dir=data/jdc/split
output_dir2=data/jdc/split/div
mkdir -p $output_dir2

get_id_list() {
    list=""
    while read line; do
        list="${list} $line"
    done
    echo $list
}

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

## BCCWJ
cat ${input_dir}/CWJ/2012/*          | sed -e 's/ID/#ID/g' > ${output_dir2}/bccwj_train.txt
cat ${input_dir}/CWJ/ClassA-1-2014/* | sed -e 's/ID/#ID/g' > ${output_dir2}/bccwj_test.txt

## EHJ (train/test split is tentative; remove reading column)
nkf -w ${input_dir}/EHJ/[0-5]* | sed -e 's/ \+/ /g' | cut -d' ' -f1-3 | sed -e 's/ID/#ID/g' > ${output_dir2}/ehj_train.txt
nkf -w ${input_dir}/EHJ/?*     | sed -e 's/ \+/ /g' | cut -d' ' -f1-3 | sed -e 's/ID/#ID/g' > ${output_dir2}/ehj_test.txt

## NKN (train/test split is tentative)
nkf -w ${input_dir}/NKN/0?* | sed -e 's/ID/#ID/g' | sed -e 's/ \+/ /g' | cut -d' ' -f1-3 > ${output_dir2}/nkn_train.txt
nkf -w ${input_dir}/NKN/10* | sed -e 's/ID/#ID/g' | sed -e 's/ \+/ /g' | cut -d' ' -f1-3 > ${output_dir2}/nkn_test.txt

## RCP
trainid_file=${input_dir}/RCP/train.file
trainids=`cat $trainid_file | get_id_list`
: > ${output_dir2}/rcp_train.txt
for file in $trainids; do
    cat ${input_dir}/RCP/${file} | sed -e 's/ID/#ID/g' >> ${output_dir2}/rcp_train.txt
done

testid_file=${input_dir}/RCP/test.file
testids=`cat $testid_file | get_id_list`
: > ${output_dir2}/rcp_test.txt
for file in $testids; do
    cat ${input_dir}/RCP/${file} | sed -e 's/ID/#ID/g' >> ${output_dir2}/rcp_test.txt
done

## JNL
trainid_file=${input_dir}/JNL/train.file
trainids=`cat $trainid_file | get_id_list`
: > ${output_dir2}/jnl_train.txt
for file in $trainids; do
    cat ${input_dir}/JNL/${file} | sed -e 's/ID/#ID/g' >> ${output_dir2}/jnl_train.txt
done

testid_file=${input_dir}/JNL/test.file
testids=`cat $testid_file | get_id_list`
: > ${output_dir2}/jnl_test.txt
for file in $testids; do
    cat ${input_dir}/JNL/${file} | sed -e 's/ID/#ID/g' >> ${output_dir2}/jnl_test.txt
done

## NPT
trainid_file=${input_dir}/NPT/train.file
trainids=`cat $trainid_file | get_id_list`
: > ${output_dir2}/npt_train.txt
for file in $trainids; do
    cat ${input_dir}/NPT/${file} | sed -e 's/ID/#ID/g' >> ${output_dir2}/npt_train.txt
done

testid_file=${input_dir}/NPT/test.file
testids=`cat $testid_file | get_id_list`
: > ${output_dir2}/npt_test.txt
for file in $testids; do
    cat ${input_dir}/NPT/${file} | sed -e 's/ID/#ID/g' >> ${output_dir2}/npt_test.txt
done


## split original training set to training and development set
names="bccwj ehj nkn rcp jnl npt"
for name in $names; do
    head -`get_top_90per_line_num    ${output_dir2}/${name}_train.txt` ${output_dir2}/${name}_train.txt \
         > ${output_dir2}/${name}_train0.9.txt
    tail -`get_bottom_10per_line_num ${output_dir2}/${name}_train.txt` ${output_dir2}/${name}_train.txt \
         > ${output_dir2}/${name}_train0.1.txt
done

## merge data
cat ${output_dir2}/*_train0.9.txt > ${output_dir}/all_train.txt
cat ${output_dir2}/*_train0.1.txt > ${output_dir}/all_dev.txt  
cat ${output_dir2}/*_test.txt     > ${output_dir}/all_test.txt 
