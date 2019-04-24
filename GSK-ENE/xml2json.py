import sys
import re
import collections
import glob
import json


def read_xml_file(filename, data):
    with open(filename, 'r') as f:
        in_text = False

        doc_id = None
        string_list = []           # string corresponds to one (or more) sentence
        ne_names_list = []
        ne_spans_list = []

        for line in f:
            line = line.strip('\n')

            if not line:
                continue

            if line.startswith('<ID>'):
                doc_id = line[line.index('>')+1:line.index('<', 1)]
            
            elif line.startswith('</TEXT>'):
                in_text = False

            elif line.startswith('<TEXT>'):
                in_text = True
                in_ne = False
                prev_ne_name = ""

            elif line.startswith('<rejectedBlock'):
                continue

            elif line.startswith('<HEADLINE>') or in_text:
                if line.startswith('<HEADLINE>'):
                    line = line[10:-11]
                    in_ne = False
                    
                string = ''
                ne_spans = []
                ne_names = []

                segments = re.sub('(<[^>]+>)', r'\\\1\\', line).split('\\')

                for s in segments:
                    if s.startswith('</'):
                        in_ne = False

                    elif s.startswith('<'):
                        in_ne = True
                        ne_name = s[1:-1]
                        prev_ne_name = ne_name
                        ne_names.append(ne_name)
                        # print('name', ne_name)

                    elif in_ne:
                        if not ne_names:
                            ne_name = s[1:-1]
                            ne_names.append(prev_ne_name)

                        span = '{}:{}'.format(len(string), len(string)+len(s))
                        ne_spans.append(span)
                        string += s
                        # print('span', span)
                        # print('+', string)

                    else:
                        string += s
                        # print('+', string)

                string_list.append(string)
                ne_names_list.append(ne_names) 
                ne_spans_list.append(ne_spans) 

            else:
                pass

        inner_data = collections.OrderedDict()
        inner_data['lines'] = string_list
        inner_data['categories'] = ne_names_list
        inner_data['spans'] = ne_spans_list
        data[doc_id] = inner_data

        # print(doc_id)
        # for string, names, spans in zip(string_list, ne_names_list, ne_spans_list):
        #     print(string)
        #     print(names)
        #     print(spans)


if __name__ == '__main__':
    data = collections.OrderedDict()

    input_dir = sys.argv[1]
    output_dir = sys.argv[2]

    files = glob.glob('{}/*'.format(input_dir))
    files.sort()

    for filename in files:
        read_xml_file(filename, data)

    name = re.sub('.*/', '', input_dir)
    output_path = '{}/{}.json'.format(output_dir, name)
    with open(output_path, 'w') as fw:
        json.dump(data, fw, ensure_ascii=False, indent=2)
