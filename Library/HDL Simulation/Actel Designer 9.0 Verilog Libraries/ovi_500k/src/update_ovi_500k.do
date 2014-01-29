#  File: update_ovi_500k.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library ovi_500k for Actel
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O2
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw ovi_500k 
clearlibrary
cd $DSN
alog -v2k -work ovi_500k $OPT -f $dsn\src\ovi_500k.opt
setlibrarymode -ro ovi_500k
