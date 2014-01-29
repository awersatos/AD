#  File: update_ecp2.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library ecp2 for Lattice
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O3
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw ecp2 
clearlibrary  
acom -work ecp2 $OPT $DSN\src\ECP2COMP.vhd
acom -work ecp2 $OPT $DSN\src\ECP2_SEQ.vhd
acom -work ecp2 $OPT $DSN\src\ECP2_IO.vhd
acom -work ecp2 $OPT $DSN\src\ECP2_CMB.vhd
acom -work ecp2 $OPT $DSN\src\ECP2_CNT.vhd
acom -work ecp2 $OPT $DSN\src\ECP2_MEM.vhd
acom -work ecp2 $OPT $DSN\src\ECP2_MISC.vhd
acom -work ecp2 $OPT $DSN\src\ECP2_LUT.vhd
acom -work ecp2 $OPT $DSN\src\ECP2_MULT.vhd
acom -work ecp2 $OPT $DSN\src\ECP2_SL.vhd
#adel -lib ecp2 jtagc
#alog -v2k -work ecp2 +define+RTL +define+UNIT_DELAY ./jtag/JTAGC.v.src 

setlibrarymode -ro ecp2


