#  File: update_ovi_axcelerator.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library ovi_axcelerator for Actel
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O2
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw ovi_axcelerator 
clearlibrary
cd $DSN
alog -v2k -work ovi_axcelerator $OPT -f $DSN\src\ovi_axcelerator.opt
setlibrarymode -ro ovi_axcelerator
