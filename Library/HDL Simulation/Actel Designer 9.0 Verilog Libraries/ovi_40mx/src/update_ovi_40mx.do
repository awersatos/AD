#  File: update_ovi_40mx.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library ovi_40mx for Actel
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file	

set OPT -O2
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw ovi_40mx	 
clearlibrary
cd $DSN
alog -v2k -work ovi_40mx $OPT -f $dsn\src\ovi_40mx.opt
setlibrarymode -ro ovi_40mx

