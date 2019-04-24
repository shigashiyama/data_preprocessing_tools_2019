import sys


def generate_map(filename):
    dic = {}

    with open(filename) as f:
        for line in f:
            kv = line.strip().split('\t')
            dic[kv[0]] = kv[1]

    return dic


def replace_data(filename, cate_map):
    ne_clm = 6

    with open(filename) as f:
        for line in f:
            line = line.strip('\n')

            if not line:
                print()

            elif line.startswith('#'):
                print(line)

            else:
                array = line.split('\t')
                ne = array[ne_clm]

                if ne and ne in cate_map:
                    line_replaced = line.replace(ne, cate_map[ne])
                    print(line_replaced)

                else:
                    print(line)


if __name__ == '__main__':
    cate_file = sys.argv[1]
    input_file = sys.argv[2]

    cate_map = generate_map(cate_file)
    replace_data(input_file, cate_map)
    
    
