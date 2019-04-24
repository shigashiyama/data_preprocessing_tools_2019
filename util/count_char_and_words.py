import sys


def count(seg_file):
    n_sen = 0
    n_char = 0
    n_word = 0
    with open(seg_file) as f:
        for line in f:
            line = line.strip()
            if not line:
                continue

            sen = line.replace(' ', '')
            words = line.split(' ')
            n_char += len(sen)
            n_word += len(words)
            n_sen += 1

    print('#sen={}, avg. word={}, avg. char={}'.format(n_sen, n_word/n_sen, n_char/n_sen))


if __name__ == '__main__':
    seg_file = sys.argv[1]
    count(seg_file)
