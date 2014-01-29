#  File: update_ovi_ecp2.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library ovi_ecp2 for Lattice
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file	

set OPT -O2
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw ovi_ecp2
clearlibrary
cd $DSN
alog -work ovi_ecp2 $OPT -f $dsn\src\ovi_ecp2.opt
#alog $OPT -v2k -work ovi_ecp2 +define+RTL +define+UNIT_DELAY ./src/jtag/JTAGC.v.src 
setlibrarymode -ro ovi_ecp2

