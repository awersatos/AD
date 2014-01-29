#  File: update_ovi_uni9000.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library ovi_uni9000 for Xilinx
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file			

set OPT -O2
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw ovi_uni9000
clearlibrary
cd $dsn
alog -work ovi_uni9000 $OPT -f $dsn/src/ovi_uni9000.opt
setlibrarymode -ro ovi_uni9000			   
