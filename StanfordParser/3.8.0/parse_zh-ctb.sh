java -Xmx20g -cp stanford-parser edu.stanford.nlp.parser.nndep.DependencyParser \
     -model stanford-parser/models/edu/stanford/nlp/models/parser/nndep/CTB_CoNLL_params.txt.gz \
     -tagger.model stanford-parser/models/edu/stanford/nlp/models/pos-tagger/chinese-distsim/chinese-distsim.tagger \
     -textFile $1 \
     -outFile $2
