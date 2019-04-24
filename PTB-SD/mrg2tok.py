import sys


if __name__ == '__main__':
    input_path = sys.argv[1]

    with open(input_path, 'r') as f:
        sen = []
        for line in f:
            line = line.strip()
            if line:
                word = line.split('\t')[1]
                sen.append(word)
            elif sen:
                print(' '.join(sen))
                sen = []

        if sen:
            print(' '.join(sen))
