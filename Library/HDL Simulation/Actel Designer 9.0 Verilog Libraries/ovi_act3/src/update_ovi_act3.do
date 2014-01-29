#  File: update_ovi_act3.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library ovi_act3 for Actel
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file	

set OPT -O2
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw ovi_act3
clearlibrary
cd $DSN
alog -v2k -work ovi_act3 $OPT -f $dsn\src\ovi_act3.opt
setlibrarymode -ro ovi_act3

