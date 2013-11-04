#!/bin/csh
mkdir -p 777/IMAGES
dcm_modify_object -t -T ../tcia-rembrandt/000000 777/IMAGES/000000 << __EOF
0010 0010 IWRF^ROB
0010 0020 777
0010 0021 IHERED&1.3.6.1.4.1.21367.13.20.1000&ISO
0010 0030 19511207
0010 0040 M
0008 0050 ACC-777
0008 0030 120000
0020 0010 777
0020 000D 1.3.6.1.4.21367.999.10.1.2
0020 000E 1.3.6.1.4.21367.999.10.2.2
0008 0018 1.3.6.1.4.21367.999.10.3.4
__EOF
