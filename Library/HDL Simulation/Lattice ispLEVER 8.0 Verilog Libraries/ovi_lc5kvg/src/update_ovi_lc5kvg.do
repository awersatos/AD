#  File: update_ovi_lc5kvg.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library ovi_lc5kvg for Lattice
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file	

set OPT -O2
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw ovi_lc5kvg
clearlibrary
cd $DSN
alog -work ovi_lc5kvg $OPT -f $dsn\src\ovi_lc5kvg.opt
setlibrarymode -ro ovi_lc5kvg

