java -Xmx10g -cp stanford-parser edu.stanford.nlp.parser.nndep.DependencyParser \
     -model stanford-parser/models/en/edu/stanford/nlp/models/parser/nndep/wsj_SD.gz \
     -tagger.model stanford-parser/models/en/edu/stanford/nlp/models/pos-tagger/english-bidirectional/english-bidirectional-distsim.tagger \
     -textFile $1 \
     -outFile $2
