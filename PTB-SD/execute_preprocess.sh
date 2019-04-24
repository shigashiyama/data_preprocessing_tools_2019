#!/usr/local/bin/bash

# gold bracketed w/ gold pos -> gold dependency w/ gold pos
#./brc2dep-sd.sh (input_brc) (dep_pos_gold)

# gold dependency w/ gold pos -> tok
#python ./mrg2tok.py (file)

# tok -> pred pos
#./tok2pos-st330.sh (input_tok) (output_pos)

# merge gold dependency and pred pos
#name=train; paste <(cut -f2 dep_pos-gold/${name}.mrg) <(cut -f2 pos-st3.3.0/${name}.pos) <(cut -f7-8 dep_pos-gold/${name}.mrg) > dep_pos-st3.3.0/${name}.dep
