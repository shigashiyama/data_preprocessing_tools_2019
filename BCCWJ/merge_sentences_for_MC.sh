# paste <(for ((i=0;i<502;i++)); do  echo OC ; done) suw/core_ClassA-1_OC.sl luw/core_ClassA-1_OC.sl > suw_luw/core_ClassA-1_OC.sl
# paste <(for ((i=0;i<504;i++)); do  echo OW ; done) suw/core_ClassA-1_OW.sl luw/core_ClassA-1_OW.sl > suw_luw/core_ClassA-1_OW.sl
# paste <(for ((i=0;i<509;i++)); do  echo OY ; done) suw/core_ClassA-1_OY.sl luw/core_ClassA-1_OY.sl > suw_luw/core_ClassA-1_OY.sl
# paste <(for ((i=0;i<510;i++)); do  echo PB ; done) suw/core_ClassA-1_PB.sl luw/core_ClassA-1_PB.sl > suw_luw/core_ClassA-1_PB.sl
# paste <(for ((i=0;i<492;i++)); do  echo PM ; done) suw/core_ClassA-1_PM.sl luw/core_ClassA-1_PM.sl > suw_luw/core_ClassA-1_PM.sl
# paste <(for ((i=0;i<505;i++)); do  echo PN ; done) suw/core_ClassA-1_PN.sl luw/core_ClassA-1_PN.sl > suw_luw/core_ClassA-1_PN.sl
# paste <(for ((i=0;i<5911;i++)); do  echo OC ; done) suw/core_other_OC.sl luw/core_other_OC.sl > suw_luw/core_other_OC.sl
# paste <(for ((i=0;i<5533;i++)); do  echo OW ; done) suw/core_other_OW.sl luw/core_other_OW.sl > suw_luw/core_other_OW.sl
# paste <(for ((i=0;i<6946;i++)); do  echo OY ; done) suw/core_other_OY.sl luw/core_other_OY.sl > suw_luw/core_other_OY.sl
# paste <(for ((i=0;i<9565;i++)); do  echo PB ; done) suw/core_other_PB.sl luw/core_other_PB.sl > suw_luw/core_other_PB.sl
# paste <(for ((i=0;i<12461;i++)); do  echo PM ; done) suw/core_other_PM.sl luw/core_other_PM.sl > suw_luw/core_other_PM.sl
# paste <(for ((i=0;i<16545;i++)); do  echo PN ; done) suw/core_other_PN.sl luw/core_other_PN.sl > suw_luw/core_other_PN.sl

dir=suw_luw
: > train.sl
: > devel.sl
head -5411  ${dir}/domains/core_other_OC.sl >> ${dir}/train.sl
tail -500   ${dir}/domains/core_other_OC.sl >> ${dir}/devel.sl
head -5033  ${dir}/domains/core_other_OW.sl >> ${dir}/train.sl
tail -500   ${dir}/domains/core_other_OW.sl >> ${dir}/devel.sl
head -6546  ${dir}/domains/core_other_OY.sl >> ${dir}/train.sl
tail -500   ${dir}/domains/core_other_OY.sl >> ${dir}/devel.sl
head -9065  ${dir}/domains/core_other_PB.sl >> ${dir}/train.sl
tail -500   ${dir}/domains/core_other_PB.sl >> ${dir}/devel.sl
head -11961 ${dir}/domains/core_other_PM.sl >> ${dir}/train.sl
tail -500   ${dir}/domains/core_other_PM.sl >> ${dir}/devel.sl
head -16045 ${dir}/domains/core_other_PN.sl >> ${dir}/train.sl
tail -500   ${dir}/domains/core_other_PN.sl >> ${dir}/devel.sl
