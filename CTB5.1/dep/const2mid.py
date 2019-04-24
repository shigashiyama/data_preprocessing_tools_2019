import sys
import os
import re


SEN_START = '<S ID'
SEN_END = '</S>'


"""
An example of an input sentence:

<S ID=1>
( (IP-HLN (NP-SBJ (NP-PN (NR 上海) 
			 (NR 浦东)) 
		  (NP (NN 开发) 
		      (CC 与) 
		      (NN 法制) 
		      (NN 建设))) 
	  (VP (VV 同步))) ) 
</S>

"""
def run(input_file, output_dir):
    prefix = input_file.split('/')[-1].split('.')[0]
    out_b = '{}/{}.brc'.format(output_dir, prefix)
    out_w = '{}/{}.wrd'.format(output_dir, prefix)

    with open(input_file, 'r') as fi, open(out_b, 'w') as fob, open(out_w, 'w') as fow:
        in_sent = False
        bracket_lines = []
        words = []
        open_count = 0
        close_count = 0

        for line in fi:
            line = line.strip()
            if line.startswith(SEN_START):
                in_sent = True
                sen_id = line.split('=')[1][:-1]

            elif line == SEN_END:
                for bracket in bracket_lines:
                    print(bracket, file=fob)
                for word in words:
                    print(word, file=fow)
                # print('', file=fob)
                # print('', file=fow)

                in_sent = False
                bracket_lines = []
                words = []
                open_count = 0
                close_count = 0

            elif in_sent:
                in_sent = True
                bracket_lines.append(line)

                tmp1 = line.replace('( ', '')
                tmp2 = re.sub('\([\S]+ ', '', tmp1)
                tmp3 = re.sub('\)+', '_', tmp2)

                for cand in tmp3.split(' '):
                    if len(cand) > 1 and cand[-1] == '_':
                        word = cand[:-1]
                        if (word.startswith('*') and word != '*'):
                            continue

                        words.append(word)
                        # print(word, '\t', line)
                
                open_count += line.count('(')
                close_count += line.count(')')
                if open_count == close_count:
                    bracket_lines.append('')
                    words.append('')


if __name__ == '__main__':
    #BUG chtb_548, 637, 644, 1031 で単語抽出結果と Penn2Malt 解析結果で語数が合わず、手動で修正

    input_dir = sys.argv[1]
    output_dir = sys.argv[2]

    # files = os.listdir(input_dir)
    # for file in files:
    #     print(file)
    #     run(input_dir + '/' + file, output_dir)
