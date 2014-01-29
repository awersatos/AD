#  File: update_ovi_xp2.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library ovi_xp2 for Lattice
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file	

set OPT -O2
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw ovi_xp2
clearlibrary
cd $DSN
alog -work ovi_xp2 $OPT -f $dsn\src\ovi_xp2.opt
#alog $OPT -v2k -work ovi_xp2 +define+RTL +define+UNIT_DELAY ./src/jtag/JTAGE.v.src
#alog $OPT -v2k -work ovi_xp2 +define+RTL +define+UNIT_DELAY ./src/jtag/xp2_tag_mem/SSPIA.v.src 
setlibrarymode -ro ovi_xp2

