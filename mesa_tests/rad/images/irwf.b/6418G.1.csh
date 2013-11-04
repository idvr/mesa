#!/bin/csh
mkdir -p 6418G/IMAGES
dcm_modify_object -t -T ../tcia-rembrandt/000001 6418G/IMAGES/000001 << __EOF
0010 0010 Black^Michael
0010 0020 6418
0010 0021 IHEGREEN&1.3.6.1.4.1.21367.13.20.2000&ISO
0010 0030 19501226
0010 0040 M
0008 0050 39621
0008 0030 120000
0020 0010 39621
0008 0051 (
 0040 0031 ACCESSIONGREEN
 0040 0032 1.3.6.1.4.1.21367.13.77.50
 0040 0033 ISO
)
0008 0082 (
 0008 0100 CH200
 0008 0102 99IHE
 0008 0104 "Green Connectathon Hospital"
)
0020 000D 1.3.6.1.4.21367.999.10.1.15
0020 000E 1.3.6.1.4.21367.999.10.2.15
0008 0018 1.3.6.1.4.21367.999.10.3.44
__EOF
