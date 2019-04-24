modify L194 in edu/stanford/nlp/parser/nndep/Config.java as follows:

~~~~
public String sentenceDelimiter = "\n";
~~~~

modify 1126 in edu/stanford/nlp/parser/nndep/DependencyParser.java as follows:
~~~~
    for (List<HasWord> sentence : preprocessor) {
        if (sentence.size() <= 2) continue;
        tagged.add(tagger.tagSentence(sentence));
    }
~~~~

modify L1140 in edu/stanford/nlp/parser/nndep/DependencyParser.java as follows:

~~~~
     output.println(String.format("%s\t%s\t%s\t%s\t%s",
                                  dep.dep().word(),
                                  dep.dep().tag(),
                                  dep.gov().index(),
                                  dep.reln())
     );
~~~~
