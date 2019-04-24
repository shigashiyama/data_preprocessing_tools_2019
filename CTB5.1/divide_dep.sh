# Starndard data split
# - train: 001-815,1001-1136 (16,118 sen)
# - devel: 886-931,1148-1151 (804 sen)   # 886-899: N/A
# - test:  816-885,1137-1147 (1,915 sen)
#
# [ref] (Zhang and Clark 2008) http://aclweb.org/anthology/D08-1059

ext=dep
in_dir=$1
out_dir=$2

: > ${out_dir}/train.${ext}
cat ${in_dir}/chtb_[0-7]??.${ext} >> ${out_dir}/train.${ext}
cat ${in_dir}/chtb_80?.${ext} >> ${out_dir}/train.${ext}
cat ${in_dir}/chtb_81[0-5].${ext} >> ${out_dir}/train.${ext}
cat ${in_dir}/chtb_10??.${ext} >> ${out_dir}/train.${ext}
cat ${in_dir}/chtb_11[0-2]?.${ext} >> ${out_dir}/train.${ext}
cat ${in_dir}/chtb_113[0-6].${ext} >> ${out_dir}/train.${ext}

: > ${out_dir}/devel.${ext}
# cat ${in_dir}/chtb_88[6-9].${ext} >> ${out_dir}/devel.${ext}
# cat ${in_dir}/chtb_89[0-9].${ext} >> ${out_dir}/devel.${ext}
cat ${in_dir}/chtb_9[0-2]?.${ext} >> ${out_dir}/devel.${ext}
cat ${in_dir}/chtb_93[0-1].${ext} >> ${out_dir}/devel.${ext}
cat ${in_dir}/chtb_114[8-9].${ext} >> ${out_dir}/devel.${ext}
cat ${in_dir}/chtb_115[0-1].${ext} >> ${out_dir}/devel.${ext}

: > ${out_dir}/test.${ext}
cat ${in_dir}/chtb_81[6-9].${ext} >> ${out_dir}/test.${ext}
cat ${in_dir}/chtb_8[2-7]?.${ext} >> ${out_dir}/test.${ext}
cat ${in_dir}/chtb_88[0-5].${ext} >> ${out_dir}/test.${ext}
cat ${in_dir}/chtb_113[7-9].${ext} >> ${out_dir}/test.${ext}
cat ${in_dir}/chtb_114[0-7].${ext} >> ${out_dir}/test.${ext}
