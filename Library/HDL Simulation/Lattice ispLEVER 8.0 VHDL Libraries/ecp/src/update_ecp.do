#  File: update_ecp.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library ecp for Lattice
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O3
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw ecp 
clearlibrary  
acom -work ecp $OPT $DSN\src\ORCACOMP.vhd
acom -work ecp $OPT $DSN\src\ORCA_SEQ.vhd
acom -work ecp $OPT $DSN\src\ORCA_IO.vhd
acom -work ecp $OPT $DSN\src\ORCA_CMB.vhd
acom -work ecp $OPT $DSN\src\ORCA_CNT.vhd
acom -work ecp $OPT $DSN\src\ORCA_MEM.vhd
acom -work ecp $OPT $DSN\src\ORCA_MISC.vhd
acom -work ecp $OPT $DSN\src\ORCA_LUT.vhd
acom -work ecp $OPT $DSN\src\ORCA_MULT.vhd
#adel -lib ecp jtagb
#alog -v2k -work ecp +define+RTL +define+UNIT_DELAY ./jtag/JTAGB.v.src 
setlibrarymode -ro ecp


