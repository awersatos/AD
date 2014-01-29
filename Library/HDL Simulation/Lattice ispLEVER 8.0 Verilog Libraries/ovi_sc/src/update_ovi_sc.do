#  File: update_ovi_sc.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library ovi_sc for Lattice
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file	

set OPT -O2
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw ovi_sc 
clearlibrary
cd $DSN
alog -work ovi_sc $OPT -f $dsn\src\ovi_sc.opt
#alog $OPT -work ovi_sc +define+RTL +define+UNIT_DELAY +incdir+./src/jtag/jtaga_files -f ./src/rtl_jtaga.f ./src/jtag/JTAGA.v.src 
setlibrarymode -ro ovi_sc
