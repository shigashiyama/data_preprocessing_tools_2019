import sys


def get_stem_and_suffix(lemma, surf, read, len_lemma_suff=1):
    if len_lemma_suff == 0:
        lemma_stem = lemma      # 美し -> 美し
    else:
        lemma_stem = lemma[:-len_lemma_suff] # 開く -> 開
    len_stem = len(lemma_stem)
    lemma_suff = lemma[len_stem:]  # 開く -> く
    surf_stem = surf[:len_stem]    # 開か -> 開
    surf_suff = surf[len_stem:]    # 開か -> か
    len_surf_suff = len(surf_suff)
    read_stem = read[:-len_surf_suff] # ヒラカ -> ヒラ
    read_suff = read[-len_surf_suff:] # ヒラカ -> カ

    return lemma_stem, lemma_suff, surf_stem, surf_suff, read_stem, read_suff


def parse_line(line, debug=False):
    array = line.split('\t')
    b = 0
    cate = array[b+1]    # unused
    doc_id = array[b+2]  # unused
    surf = array[b+3]
    pos = npos = array[b+4]
    ctype = array[b+5]
    cform = array[b+6]
    lemma = array[b+7]
    read = array[b+8]

    split_flag = False
    len_lemma_suff = 1
    lemma_stem = lemma_suff = surf_stem = surf_suff = read_stem = read_suff = ''

    if pos.startswith('接尾辞-名詞的') or pos.startswith('接尾辞-形状詞的'):
            npos = pos.replace('的', '型')

    elif pos.startswith('動詞'):
        if ctype.endswith('変格'):
            npos = pos.replace('動詞', '動詞-特殊型')

        else:
            split_flag = True
            npos_stem = pos.replace('動詞', '動詞-語幹')
            npos_suff = '活用語尾-動詞型'
            lemma_stem, lemma_suff, surf_stem, surf_suff, read_stem, read_suff = get_stem_and_suffix(
                lemma, surf, read)

            if surf_stem == '' and surf_suff: # 暫定
                surf_stem = surf
                npos = npos_stem
                split_flag = False

    elif pos == '接尾辞-動詞的':
            split_flag = True
            npos_stem = '接尾辞-動詞型語幹'
            npos_suff = '活用語尾-動詞型'
            lemma_stem, lemma_suff, surf_stem, surf_suff, read_stem, read_suff = get_stem_and_suffix(
                lemma, surf, read)

    elif pos.startswith('形容詞'):
        if surf[0] != lemma[0]: # ねえ VS ない
            npos = '形容詞-特殊型'
            
        else:
            split_flag = True
            npos_stem = pos.replace('形容詞', '形容詞-語幹')
            npos_suff = '活用語尾-形容詞型'
            len_lemma_suff = 0 if ctype == '文語形容詞-シク' else 1
            lemma_stem, lemma_suff, surf_stem, surf_suff, read_stem, read_suff = get_stem_and_suffix(
                lemma, surf, read, len_lemma_suff)

    elif pos == '接尾辞-形容詞的':
            split_flag = True
            npos_stem = '接尾辞-形容詞型語幹'
            npos_suff = '活用語尾-形容詞型'
            lemma_stem, lemma_suff, surf_stem, surf_suff, read_stem, read_suff = get_stem_and_suffix(
                lemma, surf, read)
        
    elif pos == '助動詞':
        if (ctype.startswith('五段') or
            ctype.startswith('上一段') or
            ctype.startswith('下一段') or
            ctype.startswith('文語下二段')
        ):
            if len(lemma) == 1:
                npos = '助動詞-特殊型'

            elif (lemma == 'つう' or 
                lemma == 'っつう'):
                npos = '助動詞-特殊型'

            else:
                split_flag = True
                npos_stem = '助動詞-動詞型語幹'
                npos_suff = '活用語尾-動詞型'
                lemma_stem, lemma_suff, surf_stem, surf_suff, read_stem, read_suff = get_stem_and_suffix(
                    lemma, surf, read)

        elif (ctype == '助動詞-ナイ' or 
              ctype == '助動詞-タイ' or 
              ctype == '助動詞-ラシイ' or
              ctype == '文語助動詞-ゴトシ' or
              ctype == '文語助動詞-ベシ' or
              ctype == '文語助動詞-マジ' or
              ctype == '文語助動詞-ラシ' or
              ctype == '文語形容詞-ク'
        ):
            if surf[0] != lemma[0]: # ねえ VS ない (「食べねえ」などはカバーされない)
                npos = '助動詞-特殊型'

            else:
                split_flag = True
                npos_stem = '助動詞-形容詞型語幹'
                npos_suff = '活用語尾-形容詞型'
                len_lemma_suff = 0 if (ctype == '文語助動詞-マジ' or ctype == '文語助動詞-ラシ') else 1
                lemma_stem, lemma_suff, surf_stem, surf_suff, read_stem, read_suff = get_stem_and_suffix(
                    lemma, surf, read, len_lemma_suff)

        else:
            # 助動詞-ジャ/タ/ダ/ナンダ/ヌ/ヘン/マイ/マス/ヤ/ヤス/レル, 文語助動詞-ナリ
            npos = '助動詞-特殊型'


    if debug:
        if split_flag:
            print('{}({},{})->{}|{}\t{}->{}|{}\t{}->{}|{}\t{}->{}|{}'.format(
                pos, ctype, cform, npos_stem, npos_suff,
                surf, surf_stem, surf_suff, 
                lemma, lemma_stem, lemma_suff, 
                read, read_stem, read_suff,
            ))

    else:                       # do not output reading
        if split_flag:
            print('{}\t{}\t{}\t{}\t{}\t{}'.format(
                array[0], array[1], array[2], surf_stem, npos_stem, lemma_stem))
            if surf_suff:
                print('{}\t{}\t{}\t{}\t{}\t{}'.format(
                    'I', array[1], array[2], surf_suff, npos_suff, lemma_suff))
    
        else:    
            print('{}\t{}\t{}\t{}\t{}\t{}'.format(
                array[0], array[1], array[2], surf, npos, lemma))


debug = False
def run(generator):
    for line in generator:
        line = line.strip('\n')
        if not line:
            print()
            continue
        elif line[0] == '#':
            continue
        parse_line(line, debug)


def run_from_file(input_file):
    with open(input_file) as f:
        run(f)


def run_from_stdin():
    run(iter(sys.stdin.readline, ''))

            
if __name__ == '__main__':
    if len(sys.argv) > 1:
        run_from_file(sys.argv[1])

    else:
        run_from_stdin()
