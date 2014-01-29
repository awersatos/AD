#  File: update_ovi_unimacro.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library ovi_unimacro for Xilinx
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O2
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw ovi_unimacro
clearlibrary
cd $dsn
alog -l ovi_unisim -work ovi_unimacro $OPT -f $dsn/src/ovi_unimacro.opt

setlibrarymode -ro ovi_unimacro


