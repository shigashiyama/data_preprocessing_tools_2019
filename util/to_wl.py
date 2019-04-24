import sys


if __name__ == '__main__':
    input_file = sys.argv[1]

    with open(input_file, 'r') as f:
        count = 0
        chars = []

        for line in f:
            line = line.rstrip()
            if not line:
                continue

            array = line.split(' ')
            for word in array:
                print(word)
            print()
