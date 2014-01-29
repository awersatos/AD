#  File: update_ovi_3200dx.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library ovi_3200dx for Actel
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file	

set OPT -O2
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw ovi_3200dx
clearlibrary
cd $DSN
alog -v2k -work ovi_3200dx $OPT -f $dsn\src\ovi_3200dx.opt 
setlibrarymode -ro ovi_3200dx
