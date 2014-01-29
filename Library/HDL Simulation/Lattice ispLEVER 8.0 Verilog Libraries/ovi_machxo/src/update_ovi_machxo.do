#  File: update_ovi_machxo.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library ovi_machxo for Lattice
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file	

set OPT -O2
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw ovi_machxo
clearlibrary
cd $DSN
alog -work ovi_machxo $OPT -f $dsn\src\ovi_machxo.opt
#alog $OPT -v2k -work ovi_machxo +define+RTL +define+UNIT_DELAY ./src/jtag/JTAGD.v.src 
setlibrarymode -ro ovi_machxo

