#  File: update_ovi_mgen_vlog.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library ovi_mgen_vlog for Lattice
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file	

set OPT -O2
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw ovi_mgen_vlog
clearlibrary
cd $DSN
alog -work ovi_mgen_vlog $OPT -f $dsn\src\ovi_mgen_vlog.opt
setlibrarymode -ro ovi_mgen_vlog

