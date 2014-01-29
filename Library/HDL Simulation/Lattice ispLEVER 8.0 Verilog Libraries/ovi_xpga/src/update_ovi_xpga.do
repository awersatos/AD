#  File: update_ovi_xpga.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library ovi_xpga for Lattice
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file	

set OPT -O2
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw ovi_xpga
clearlibrary
cd $DSN
alog -work ovi_xpga $OPT -f $dsn\src\ovi_xpga.opt
setlibrarymode -ro ovi_xpga

