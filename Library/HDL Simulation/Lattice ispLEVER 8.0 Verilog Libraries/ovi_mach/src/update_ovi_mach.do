#  File: update_ovi_mach.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library ovi_mach for Lattice
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file	

set OPT -O2
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw ovi_mach
clearlibrary
cd $DSN
alog -work ovi_mach $OPT -f $dsn\src\ovi_mach.opt 
setlibrarymode -ro ovi_mach

