#  File: update_ovi_proasic3l.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library ovi_proasic3l for Actel 	 
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file	

set OPT -O2
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw ovi_proasic3l	 
clearlibrary
cd $DSN
alog -v2k -work ovi_proasic3l $OPT -f $dsn\src\ovi_proasic3l.opt
setlibrarymode -ro ovi_proasic3l

