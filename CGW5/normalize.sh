in_dir=
out_dir=
tools_dir=

for input in $in_dir/*; do
    base=`basename $input`
    # base=${base%.*}
    out=${out_dir}${base}
    cat $input | grep -v '^.$' | sed -e 's/　/ /g' | sed -e 's/ \+/ /g' | python ${tools_dir}common/normalize.py > $out
    echo Output: $out
done

