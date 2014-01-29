#  File: update_ovi_simprim.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library ovi_simprim for Xilinx
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file	

#set OPT -O5
#uncomment following line to compile with debug information
set OPT -dbg

setlibrarymode -rw ovi_simprim
clearlibrary
cd $dsn
alog -work ovi_simprim $OPT -f $dsn\src\ovi_simprim.opt
setlibrarymode -ro ovi_simprim

