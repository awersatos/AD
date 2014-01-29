#  File: update_ovi_vlog_macro.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library ovi_vlog_macro for Lattice
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file	

set OPT -O2
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw ovi_vlog_macro
clearlibrary
cd $DSN
alog -work ovi_vlog_macro $OPT -f $dsn\src\ovi_vlog_macro.opt
setlibrarymode -ro ovi_vlog_macro

