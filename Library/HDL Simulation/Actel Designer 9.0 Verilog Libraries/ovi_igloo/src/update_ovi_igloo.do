#  File: update_ovi_igloo.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library ovi_igloo for Actel 	 
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file	

set OPT -O2
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw ovi_igloo	 
clearlibrary
cd $DSN
alog -v2k -work ovi_igloo $OPT -f $dsn\src\ovi_igloo.opt
setlibrarymode -ro ovi_igloo

