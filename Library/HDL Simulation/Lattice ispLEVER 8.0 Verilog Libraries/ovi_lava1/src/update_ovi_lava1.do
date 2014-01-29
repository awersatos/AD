#  File: update_ovi_LAVA1.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library ovi_LAVA1 for Lattice
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file	

set OPT -O4
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw ovi_LAVA1
clearlibrary
cd $DSN
alog -work ovi_LAVA1 $OPT -f $dsn\src\ovi_LAVA1.opt
setlibrarymode -ro ovi_LAVA1

