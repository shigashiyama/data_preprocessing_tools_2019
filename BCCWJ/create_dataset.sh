#### set file paths

format=SUW
input=$1   #BCCWJ1.1/Disk3/CORE_OT/core_SUW.txt
outdir=$2  #out

outdir1=${outdir}/org
outdir2=${outdir}/simple

mkdir -p $outdir1 $outdir2


#### Split data into ClassA-1 (test) and others (train and devel) [org POS]

coreid_file=core.list
testid_file=ClassA-1.list
train0=${outdir1}/core_other.txt
test0=${outdir1}/core_ClassA-1.txt
test=${outdir1}/test.txt
tmp=__tmp

./convert.sh $input $format $coreid_file $testid_file $train0 $test0
./split_for_each_domain.sh $outdir1
cat $test0 | sed -e 's/^B'$'\t/\\n/g' | sed 's/^I'$'\t//g' | sed 1d > $tmp; mv $tmp $test


#### Split data into ClassA-1 (test) and others (train and devel) [simplified POS]

train_s0=${outdir2}/core_other.txt
test_s0=${outdir2}/core_ClassA-1.txt
test_s=${outdir2}/test.txt
tmp=__tmp

./remove_minor_pos_for_core_others.sh $train0 > $train_s0
./remove_minor_pos_for_core_ClassA-1.sh $test0 > $test_s0
./split_for_each_domain.sh $outdir2
cat $test_s0 | sed -e 's/^B'$'\t/\\n/g' | sed 's/^I'$'\t//g' | sed 1d > $tmp; mv $tmp $test_s
