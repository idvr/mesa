#!/bin/csh
mkdir -p 300/IMAGES
dcm_modify_object -t -T ../tcia-rembrandt/000002 300/IMAGES/000002 << __EOF
0010 0010 IWRF^PAT
0010 0020 200
0010 0021 IHEFACILITY&1.3.6.1.4.1.21367.3000.1.6&ISO
0010 0030 19600412
0010 0040 F
0008 0050 #
0008 0030 120000
0020 0010 98321
0020 000D 1.3.6.1.4.21367.999.10.1.7
0020 000E 1.3.6.1.4.21367.999.10.2.7
0008 0018 1.3.6.1.4.21367.999.10.3.21
__EOF
