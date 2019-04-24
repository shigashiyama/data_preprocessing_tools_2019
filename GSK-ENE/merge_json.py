import sys
import collections
import json


def read_xml(input_xml, data):
    with open(input_xml, 'r') as f:
        prev_doc_id = None

        for line in f:
            line = line.strip('\n')

            if not line or line[0] == '#':
                continue

            array = line.split('\t')
            doc_id = array[2]
            word = array[3]

            if prev_doc_id != doc_id:
                # print(doc_id)
                # if prev_doc_id != None:
                #     break
                
                prev_doc_id = doc_id
                prev_char_idx = 0
                ne_info_idx = 0
                ne_info = data[doc_id]

            if prev_char_idx <= 0:
                prev_char_idx *= -1
                string = ne_info['lines'][ne_info_idx]
                names = ne_info['categories'][ne_info_idx]
                org_spans = ne_info['spans'][ne_info_idx]
                
                idx2span = {}
                spans_all = set()
                for i, s in enumerate(org_spans):
                    s_array = s.split(':')
                    sb = int(s_array[0])
                    se = int(s_array[1])
                    idx2span[i] = [n for n in range(sb, se)]
                    spans_all = spans_all.union(idx2span[i])

                # print('--')
                # print(prev_char_idx)
                # print(line)
                # print(doc_id)
                # print(ne_info['lines'])
                # print('ne_info_idx', ne_info_idx)
                # print(string, len(string))
                # print(names)
                # print(org_spans)
                # print(spans_all)
                # print(idx2span)
                # print('--')

            char_idx_begin = prev_char_idx
            char_idx_end = prev_char_idx + len(word)

            if (char_idx_begin in spans_all and 
                (char_idx_end-1) in spans_all):

                for i, span in idx2span.items():
                    if char_idx_begin in span:
                        ne_idx = i

                name = names[ne_idx]
                # print('{} {} {}\t{}\t{}'.format(char_idx_begin, char_idx_end, line, name, string[char_idx_begin:char_idx_end]))
                print('{}\t{}'.format(line, name))

                if word != string[char_idx_begin:char_idx_end]:
                    print('<error>', file=sys.stderr)
                    print(doc_id, file=sys.stderr)
                    print(word, '<->', string[char_idx_begin:char_idx_end], file=sys.stderr)
                    print(string, char_idx_begin, char_idx_end, file=sys.stderr)
                    print(line, file=sys.stderr)
                    sys.exit()

            else:
                #print('{} {} {}'.format(char_idx_begin, char_idx_end, line))
                print('{}\t'.format(line))
            
            # print(char_idx_end, len(string))
            if char_idx_end == len(string):
                prev_char_idx = 0
                ne_info_idx += 1

            elif char_idx_end > len(string):
                prev_char_idx = -(char_idx_end - len(string))
                ne_info_idx += 1

            else:
                prev_char_idx = char_idx_end


if __name__ == '__main__':
    input_xml = sys.argv[1]
    input_json = sys.argv[2]

    with open(input_json, 'r') as f:
        data = json.load(f)

    read_xml(input_xml, data)
