#!/usr/local/bin/bash

in_dir=$1
out_dir=$2

for fn in $in_dir/*/* ; do
    base=`basename $fn`
    java -cp "../StanfordParser/stanford-parser.jar" -mx1g edu.stanford.nlp.trees.EnglishGrammaticalStructure -basic -keepPunct -conllx -treeFile $fn > ${out_dir}/${base}
done
