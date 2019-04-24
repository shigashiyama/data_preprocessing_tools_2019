import sys
import collections
import json


# one sentence in one line
# e.g., "自民_ORG 、 社会_ORG の各党は" 
def write_sl_format(data):
    cnt = 0
    for doc_id in data:
        cnt += 1

        ne_info = data[doc_id]
        len_line = len(ne_info['lines'])

        for i in range(len_line):
            ret = []
            string = ne_info['lines'][i]
            names = ne_info['categories'][i]
            org_spans = ne_info['spans'][i]

            # print(string)
            # print(names)
            # print(org_spans)

            if not org_spans:
                ret.append(string)
                continue

            idx2span = {}
            for i, s in enumerate(org_spans):
                s_array = s.split(':')
                sb = int(s_array[0])
                se = int(s_array[1])
                idx2span[i] = [n for n in range(sb, se)]

            i = 0
            span = idx2span[i]
            prev_j = 0
            j = 0
            words = []
            len_sen = len(string)
            while j < len_sen:
                if not span:
                    words.append(string[j:])
                    break

                else:
                    if j in span:
                        while j in span:
                            j += 1

                        segment = string[prev_j:j]
                        ne = names[i]
                        words.append('{}|{}'.format(segment, ne))
                        prev_j = j

                        i += 1
                        span = idx2span[i] if i < len(org_spans) else None

                    else:
                        while not j in span:
                            j += 1

                        segment = string[prev_j:j]
                        words.append(segment)
                        prev_j = j

            ret.append(' '.join(words))

            # print('#ORG_LINE={}'.format(string))
            for line in ret:
                ret2 = line.replace('。', '。$')
                for sen in ret2.split('$'):
                    if sen:
                        print('{}\t{}'.format(doc_id, sen))
                        # print(len(sen), file=sys.stderr)
            
if __name__ == '__main__':
    input_json = sys.argv[1]

    with open(input_json, 'r') as f:
        data = json.load(f)

    write_sl_format(data)
