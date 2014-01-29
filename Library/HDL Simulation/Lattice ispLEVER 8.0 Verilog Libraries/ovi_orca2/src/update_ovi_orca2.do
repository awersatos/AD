#  File: update_ovi_orca2.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library ovi_orca2 for Lattice
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file	

set OPT -O2
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw ovi_orca2
clearlibrary
cd $DSN
alog -work ovi_orca2 $OPT -f $dsn\src\ovi_orca2.opt
setlibrarymode -ro ovi_orca2

