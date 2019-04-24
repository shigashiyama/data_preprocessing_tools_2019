import sys


if __name__ == '__main__':
    infile = sys.argv[1]

    with open(infile, 'r') as f:
        index = 0
        feat = '-'
        deps = '-'
        misc = '-'

        for line in f:
            line = line.strip()
            if len(line) < 1:
                index = 0
                print()
                continue

            array = line.split('\t')
            form = lemma = array[0]
            pos1 = pos2 = array[1]
            head = array[2]
            deprel = array[3]
            index += 1
            print('{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}'.format(
                index, form, lemma, pos1, pos2, feat, head, deprel, deps, misc))
