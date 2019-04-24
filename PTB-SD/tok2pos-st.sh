#!/usr/local/bin/bash

in_dir=$1
out_dir=$2

for fn in $in_dir/* ; do
    base=`basename $fn`
    base=${base%.*}
    java -cp "../StanfordPOSTagger/stanford-postagger-3.3.0.jar" edu.stanford.nlp.tagger.maxent.MaxentTagger -model ../StanfordPOSTagger/wsj-0-18-left3words-distsim.tagger -tokenize false -sentenceDelimiter newline -outputFormat tsv -textFile $fn > ${out_dir}/${base}.pos
done



