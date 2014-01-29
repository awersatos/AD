#  File: update_ovi_ecp3.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library ovi_ecp3 for Lattice
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file	

set OPT -O2
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw ovi_ecp3
clearlibrary
cd $DSN
alog -work ovi_ecp3 $OPT -f $dsn\src\ovi_ecp3.opt
#alog $OPT -v2k -work ovi_ecp3 +define+RTL +define+UNIT_DELAY ./src/jtag/JTAGE.v.src 
setlibrarymode -ro ovi_ecp3

