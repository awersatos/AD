#  File: update_ovi_ecp.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library ovi_ecp for Lattice
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file	

set OPT -O2
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw ovi_ecp
clearlibrary
cd $DSN
alog -work ovi_ecp $OPT -f $dsn\src\ovi_ecp.opt
#alog $OPT -v2k -work ovi_ecp +define+RTL +define+UNIT_DELAY ./src/jtag/JTAGB.v.src
setlibrarymode -ro ovi_ecp

