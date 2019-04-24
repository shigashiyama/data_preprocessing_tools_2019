import sys


def read_tsv(input_tsv):
    with open(input_tsv, 'r') as f:
        lines = []
        space_only = True

        for line in f:
            line = line.strip('\n')
            if not line or line[0] == '#':
                continue

            array = line.split('\t')
            posi = array[0]
            word = array[3]

            if posi == 'B':
                if not space_only:
                    for l in lines:
                        print(l)

                lines = []
                space_only = True
                # print(space_only, line)

            # if word == '　':
            #     print(space_only, line)
            space_only = space_only and word == '　'
            lines.append(line)
        
        if not space_only:
            for l in lines:
                print(l)


if __name__ == '__main__':
    input_tsv = sys.argv[1]
    read_tsv(input_tsv)
