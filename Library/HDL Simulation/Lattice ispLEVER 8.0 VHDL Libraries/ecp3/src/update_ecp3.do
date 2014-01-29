#  File: update_ecp3.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library ecp3 for Lattice
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O3
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw ecp3 
clearlibrary  
acom -work ecp3 $OPT $DSN\src\ECP3COMP.vhd
acom -work ecp3 $OPT $DSN\src\ECP3_SEQ.vhd
acom -work ecp3 $OPT $DSN\src\ECP3_IO.vhd
acom -work ecp3 $OPT $DSN\src\ECP3_CMB.vhd
acom -work ecp3 $OPT $DSN\src\ECP3_CNT.vhd
acom -work ecp3 $OPT $DSN\src\ECP3_MEM.vhd
acom -work ecp3 $OPT $DSN\src\ECP3_MISC.vhd 
acom -work ecp3 $OPT $DSN\src\ECP3_LUT.vhd
acom -work ecp3 $OPT $DSN\src\ECP3_MULT.vhd
acom -work ecp3 $OPT $DSN\src\ECP3_SL.vhd
#adel -lib ecp3 jtage
#alog -v2k -work ecp3 +define+RTL +define+UNIT_DELAY ./jtag/JTAGE.v.src 

setlibrarymode -ro ecp3


