import argparse
import sys
import zenhan


def run_from_stdin(normalize_space=False):
    run(iter(sys.stdin.readline, ''), normalize_space=normalize_space)


def run_from_file(input_file, normalize_space=False):
    with open(input_file) as f:
        run(f, normalize_space=normalize_space)


def run(generator, normalize_space=False):
    for line in generator:
        line = line.strip('\n')
        if normalize_space:
            linez = zenhan.h2z(line, mode=7)
        else:
            linez = zenhan.h2z(line, mode=7, ignore=' ')
        print(linez)


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--normalize_space', action='store_true')
    args = parser.parse_args()

    run_from_stdin(normalize_space=args.normalize_space)
