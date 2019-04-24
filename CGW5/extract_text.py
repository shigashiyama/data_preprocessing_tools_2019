import sys
import re
import gzip


def read_and_write(fr, fw):
    if in_file.endswith('gz'):
        fr = gzip.open(in_file, 'rb')
        flag_bin = True
    else:
        fr = open(in_file, 'r')
        flag_bin = False
    fw = open(out_file, 'w')

    digits = re.compile(r'[0-9]+')
    buf_p = []
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
                for sen in buf_p:
                    if not re.sub(digits, '', sen):
                        continue
                    fw.write(sen+'\n')

                flag_p = False                        
                buf_p = []

            elif line.startswith('<DATE'):
                flag_d = True

            elif line.startswith('</DATE'):
                flag_d = False

            continue

        if flag_p:
            if not buf_p:
                line = line.lstrip(' ')

            sens = line.split('。')
            for i, sen in enumerate(sens):
                if i > 0 and buf_p:
                    buf_p[-1] += '。'

                if len(buf_p) > 0:
                    if sen.startswith('」'):
                        buf_p[-1] += sen[0]
                        sen = sen[1:]

                    if not sen:
                        continue

                    if buf_p[-1].endswith('。') or buf_p[-1].endswith('」'):
                        buf_p.append(sen)
                    else:
                        buf_p[-1] += sen

                else:
                    if sen.startswith('」'):
                        sen = sen[1:]

                    if sen:
                        buf_p.append(sen)
                            
        elif flag_d:
            continue
            
        else:
            fw.write(line+'\n')
            
    fr.close()
    fw.close()

if __name__ == '__main__':
    in_file = sys.argv[1]
    out_file = sys.argv[2]
    read_and_write(in_file, out_file)
