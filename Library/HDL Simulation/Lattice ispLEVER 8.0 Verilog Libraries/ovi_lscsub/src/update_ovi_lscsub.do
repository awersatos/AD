#  File: update_ovi_lscsub.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library ovi_lscsub for Lattice
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file	

set OPT -O2
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw ovi_lscsub
clearlibrary
cd $DSN
alog -work ovi_lscsub $OPT -f $dsn\src\ovi_lscsub.opt
setlibrarymode -ro ovi_lscsub
