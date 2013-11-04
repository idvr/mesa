#!/bin/csh
mkdir -p 2048/IMAGES
dcm_modify_object -t -T ../tcia-rembrandt/000002 2048/IMAGES/000002 << __EOF
0010 0010 Jones^Paul
0010 0020 2048
0010 0021 IHERED&1.3.6.1.4.1.21367.13.20.1000&ISO
0010 0030 19590404
0010 0040 M
0008 0050 33732
0008 0030 120000
0020 0010 33732
0008 0051 (
 0040 0031 ACCESSIONRED
 0040 0032 1.3.6.1.4.1.21367.13.77.40
 0040 0033 ISO
)
0008 0082 (
 0008 0100 CH100
 0008 0102 99IHE
 0008 0104 "Red Connectathon Hospital"
)
0020 000D 1.3.6.1.4.21367.999.10.1.10
0020 000E 1.3.6.1.4.21367.999.10.2.10
0008 0018 1.3.6.1.4.21367.999.10.3.30
__EOF
