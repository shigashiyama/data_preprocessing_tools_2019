# starndard data split
# train: 81-325,400-454,500-554,590-596,600-885,900,1001-1017,1019,1021-1035,1037-1043,1045-1059,1062-1071,
#        1073-1078,1100-1117,1130-1131,1133-1140,1143-1147,1149-1151,2000-2139,2160-2164,2181-2279,
#        2311-2549,2603-2774,2820-3079
# devel: 41-80,1120-1129,2140-2159,2280-2294,2550-2569,2775-2799,3080-3109
# test:  1-40,901-931,1018,1020,1036,1044,1060-1061,1072,1118-1119,1132,1141-1142,1148,2165-2180,2295-2310,
#        2570-2602,2800-2819,3110-3145
#
# [ref] http://www.aclweb.org/anthology/D15-1141 -> http://www.aclweb.org/anthology/P12-1083 

ext=$1                          # seg or pos
in_dir=$2
out_dir=$3

train=${out_dir}/train.${ext}
: > $train
grep -h -v '<' ${in_dir}/chtb_008[1-9].${ext} >> $train    # 0081-0089
grep -h -v '<' ${in_dir}/chtb_009?.${ext} >> $train        # 0090-0099
grep -h -v '<' ${in_dir}/chtb_0[12]??.${ext} >> $train     # 0100-0299
grep -h -v '<' ${in_dir}/chtb_03[01]?.${ext} >> $train     # 0300-0319
grep -h -v '<' ${in_dir}/chtb_032[0-5].${ext} >> $train    # 0320-0325
grep -h -v '<' ${in_dir}/chtb_04[0-4]?.${ext} >> $train    # 0400-0449
grep -h -v '<' ${in_dir}/chtb_045[0-4].${ext} >> $train    # 0450-0454
grep -h -v '<' ${in_dir}/chtb_05[0-4]?.${ext} >> $train    # 0500-0549
grep -h -v '<' ${in_dir}/chtb_055[0-4].${ext} >> $train    # 0550-0554
grep -h -v '<' ${in_dir}/chtb_059[0-6].${ext} >> $train    # 0590-0596
grep -h -v '<' ${in_dir}/chtb_0[67]??.${ext} >> $train     # 0600-0799
grep -h -v '<' ${in_dir}/chtb_08[0-7]?.${ext} >> $train    # 0800-0879
grep -h -v '<' ${in_dir}/chtb_088[0-5].${ext} >> $train    # 0880-0885
grep -h -v '<' ${in_dir}/chtb_0900.${ext} >> $train        # 0900
grep -h -v '<' ${in_dir}/chtb_100[1-9].${ext} >> $train    # 1000-1009
grep -h -v '<' ${in_dir}/chtb_101[0-7].${ext} >> $train    # 1010-1017
grep -h -v '<' ${in_dir}/chtb_1019.${ext} >> $train        # 1019
grep -h -v '<' ${in_dir}/chtb_102[1-9].${ext} >> $train    # 1021-1029
grep -h -v '<' ${in_dir}/chtb_103[0-57-9].${ext} >> $train # 1030-1035,1037-1039
grep -h -v '<' ${in_dir}/chtb_104[0-35-9].${ext} >> $train # 1040-1043,1045-1049
grep -h -v '<' ${in_dir}/chtb_105?.${ext} >> $train        # 1050-1059
grep -h -v '<' ${in_dir}/chtb_106[2-9].${ext} >> $train    # 1062-1069
grep -h -v '<' ${in_dir}/chtb_107[01].${ext} >> $train     # 1070-1071
grep -h -v '<' ${in_dir}/chtb_107[3-8].${ext} >> $train    # 1073-1078
grep -h -v '<' ${in_dir}/chtb_110?.${ext} >> $train        # 1100-1109
grep -h -v '<' ${in_dir}/chtb_111[0-7].${ext} >> $train    # 1110-1117
grep -h -v '<' ${in_dir}/chtb_113[013-9].${ext} >> $train  # 1130-1131,1133-1139
grep -h -v '<' ${in_dir}/chtb_114[03-79].${ext} >> $train  # 1140,1143-1147,1149
grep -h -v '<' ${in_dir}/chtb_115[01].${ext} >> $train     # 1150-1151
grep -h -v '<' ${in_dir}/chtb_20??.${ext} >> $train        # 2000-2099
grep -h -v '<' ${in_dir}/chtb_21[0-3]?.${ext} >> $train    # 2100-2139
grep -h -v '<' ${in_dir}/chtb_216[0-4].${ext} >> $train    # 2160-2164
grep -h -v '<' ${in_dir}/chtb_218[1-9].${ext} >> $train    # 2181-2189
grep -h -v '<' ${in_dir}/chtb_219?.${ext} >> $train        # 2190-2199
grep -h -v '<' ${in_dir}/chtb_22[0-7]?.${ext} >> $train    # 2200-2279
grep -h -v '<' ${in_dir}/chtb_231[1-9].${ext} >> $train    # 2311-2319
grep -h -v '<' ${in_dir}/chtb_23[2-9]?.${ext} >> $train    # 2320-2399
grep -h -v '<' ${in_dir}/chtb_24??.${ext} >> $train        # 2400-2499
grep -h -v '<' ${in_dir}/chtb_25[0-4]?.${ext} >> $train    # 2500-2549
grep -h -v '<' ${in_dir}/chtb_260[3-9].${ext} >> $train    # 2603-2609
grep -h -v '<' ${in_dir}/chtb_26[1-9]?.${ext} >> $train    # 2610-2699
grep -h -v '<' ${in_dir}/chtb_27[0-6]?.${ext} >> $train    # 2700-2769
grep -h -v '<' ${in_dir}/chtb_277[0-4].${ext} >> $train    # 2770-2774
grep -h -v '<' ${in_dir}/chtb_28[2-9]?.${ext} >> $train    # 2820-2899
grep -h -v '<' ${in_dir}/chtb_29??.${ext} >> $train        # 2900-2999
grep -h -v '<' ${in_dir}/chtb_30[0-7]?.${ext} >> $train    # 3000-3079

devel=${out_dir}/devel.${ext}
: > $devel
grep -h -v '<' ${in_dir}/chtb_004[1-9].${ext} >> $devel # 0041-0049
grep -h -v '<' ${in_dir}/chtb_00[5-7]?.${ext} >> $devel # 0050-0079
grep -h -v '<' ${in_dir}/chtb_0080.${ext} >> $devel     # 0080
grep -h -v '<' ${in_dir}/chtb_112?.${ext} >> $devel     # 1120-1129
grep -h -v '<' ${in_dir}/chtb_21[45]?.${ext} >> $devel  # 2140-2159
grep -h -v '<' ${in_dir}/chtb_228?.${ext} >> $devel     # 2280-2289
grep -h -v '<' ${in_dir}/chtb_229[0-4].${ext} >> $devel # 2290-2294
grep -h -v '<' ${in_dir}/chtb_25[56]?.${ext} >> $devel  # 2550-2569
grep -h -v '<' ${in_dir}/chtb_277[5-9].${ext} >> $devel # 2775-2779
grep -h -v '<' ${in_dir}/chtb_27[89]?.${ext} >> $devel  # 2780-2799
grep -h -v '<' ${in_dir}/chtb_30[89]?.${ext} >> $devel  # 3080-3099
grep -h -v '<' ${in_dir}/chtb_310?.${ext} >> $devel     # 3100-3109


test=${out_dir}/test.${ext}
: > $test
grep -h -v '<' ${in_dir}/chtb_00[0-3]?.${ext} >> $test # 0001-0039
grep -h -v '<' ${in_dir}/chtb_0040.${ext} >> $test     # 0040
grep -h -v '<' ${in_dir}/chtb_090[1-9].${ext} >> $test # 0901-0909
grep -h -v '<' ${in_dir}/chtb_09[12]?.${ext} >> $test  # 0910-0929
grep -h -v '<' ${in_dir}/chtb_093[01].${ext} >> $test  # 0930-0931
grep -h -v '<' ${in_dir}/chtb_1018.${ext} >> $test     # 1018
grep -h -v '<' ${in_dir}/chtb_1020.${ext} >> $test     # 1020
grep -h -v '<' ${in_dir}/chtb_1036.${ext} >> $test     # 1036
grep -h -v '<' ${in_dir}/chtb_1044.${ext} >> $test     # 1044
grep -h -v '<' ${in_dir}/chtb_106[01].${ext} >> $test  # 1060-1061
grep -h -v '<' ${in_dir}/chtb_1072.${ext} >> $test     # 1072
grep -h -v '<' ${in_dir}/chtb_111[89].${ext} >> $test  # 1118-1119
grep -h -v '<' ${in_dir}/chtb_1132.${ext} >> $test     # 1132
grep -h -v '<' ${in_dir}/chtb_104[128].${ext} >> $test # 1141-1142,1148
grep -h -v '<' ${in_dir}/chtb_216[5-9].${ext} >> $test # 2165-2169
grep -h -v '<' ${in_dir}/chtb_217?.${ext} >> $test     # 2170-2179
grep -h -v '<' ${in_dir}/chtb_2180.${ext} >> $test     # 2180
grep -h -v '<' ${in_dir}/chtb_229[509].${ext} >> $test # 2295-2299
grep -h -v '<' ${in_dir}/chtb_230?.${ext} >> $test     # 2300
grep -h -v '<' ${in_dir}/chtb_2310.${ext} >> $test     # 2310
grep -h -v '<' ${in_dir}/chtb_25[7-9]?.${ext} >> $test # 2570-2599
grep -h -v '<' ${in_dir}/chtb_260[0-2].${ext} >> $test # 2600-2602
grep -h -v '<' ${in_dir}/chtb_28[01]?.${ext} >> $test  # 2800-2819
grep -h -v '<' ${in_dir}/chtb_31[1-3]?.${ext} >> $test # 3110-3139
grep -h -v '<' ${in_dir}/chtb_314[0-5].${ext} >> $test # 3140-3145
