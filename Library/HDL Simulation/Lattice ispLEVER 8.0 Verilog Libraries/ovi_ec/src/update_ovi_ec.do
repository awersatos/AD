#  File: update_ovi_ec.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library ovi_ec for Lattice
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file	

set OPT -O2
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw ovi_ec
clearlibrary
cd $DSN
alog -work ovi_ec $OPT -f $dsn\src\ovi_ec.opt
#alog $OPT -v2k -work ovi_ec +define+RTL +define+UNIT_DELAY ./src/jtag/JTAGB.v.src
setlibrarymode -ro ovi_ec

