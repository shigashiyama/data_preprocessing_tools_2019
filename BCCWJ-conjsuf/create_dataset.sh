#### set file paths

indir=$1
outdir=$2

test0=${outdir}/core_ClassA-1.txt
test=${outdir}/test.txt

#### Separate conjugative suffix

cat ${indir}/core_other.txt    | python separate_conjsuf_unidic-pos.py > ${outdir}/core_other.txt
cat ${indir}/core_ClassA-1.txt | python separate_conjsuf_unidic-pos.py > ${outdir}/core_ClassA-1.txt

../BCCWJ/split_for_each_domain.sh $outdir
cat $test0 | sed -e 's/^B'$'\t/\\n/g' | sed 's/^I'$'\t//g' | sed 1d > $test
