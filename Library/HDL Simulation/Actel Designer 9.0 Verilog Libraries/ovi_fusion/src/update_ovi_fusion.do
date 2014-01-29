#  File: update_ovi_fusion.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library ovi_fusion for Actel 	 
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file	

set OPT -O2
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw ovi_fusion	 
clearlibrary
cd $DSN
alog -v2k -work ovi_fusion $OPT -f $dsn\src\ovi_fusion.opt
setlibrarymode -ro ovi_fusion

