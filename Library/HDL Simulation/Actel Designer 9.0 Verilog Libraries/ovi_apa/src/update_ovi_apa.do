#  File: update_ovi_apa.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library ovi_apa for  Actel
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file	

set OPT -O2
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw ovi_apa
clearlibrary
cd $DSN
alog -v2k -work ovi_apa $OPT -f $dsn\src\ovi_apa.opt
setlibrarymode -ro ovi_apa

