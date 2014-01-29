#  File: update_ovi_j2svlib.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library ovi_j2svlib for Lattice
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file	

set OPT -O2
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw ovi_j2svlib	  
clearlibrary
cd $DSN
alog -work ovi_j2svlib $OPT -f $dsn\src\ovi_j2svlib.opt
setlibrarymode -ro ovi_j2svlib

