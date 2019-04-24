import sys
import os
import re
import gzip

import nltk


digits = re.compile(r'[0-9]+')
def write_tokenized_sentences(text, writer):
    if not text or not re.sub(digits, '', text):
        return

    sens = nltk.tokenize.sent_tokenize(text)
    for sen in sens:
        words = nltk.tokenize.word_tokenize(sen)
        if len(words) > 2:
            s = ' '.join(words)
            writer.write(s+'\n')
        

def read_and_write(fr, fw):
    if in_file.endswith('gz'):
        fr = gzip.open(in_file, 'rb')
        flag_bin = True
    else:
        fr = open(in_file, 'r')
        flag_bin = False
    fw = open(out_file, 'w')

    
    buf_t = ''
    buf_p = ''
    flag_t = False
    flag_p = False
    flag_d = False

    for line in fr:
        if flag_bin:
            line = line.decode('utf-8')
        line = line.rstrip('\n')

        if len(line) == 0:
            continue

        if line.startswith('<'):
            if line.startswith('<P>'):
                flag_p = True

            elif line.startswith('</P>'):
                write_tokenized_sentences(buf_p, fw)
                flag_p = False
                buf_p = ''

            elif line.startswith('<TEXT'):
                flag_t = True

            elif line.startswith('</TEXT'):
                write_tokenized_sentences(buf_t, fw)
                flag_t = False
                buf_t = ''

            elif line.startswith('<DATE'):
                flag_d = True

            elif line.startswith('</DATE'):
                flag_d = False

            continue

        if flag_p:
            if buf_p:
                buf_p += ' '
            buf_p += line.strip()
                            
        elif flag_t:
            if buf_t:
                buf_t += ' '
            buf_t += line.strip()

        elif flag_d:
            continue
            
        else:
            write_tokenized_sentences(line, fw)
            
    fr.close()
    fw.close()

if __name__ == '__main__':
    in_file = sys.argv[1]
    out_file = sys.argv[2]
    read_and_write(in_file, out_file)
