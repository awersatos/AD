#  File: update_ovi_unisim.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library ovi_unisim for Xilinx
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file			

set OPT -O2
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw ovi_unisim
clearlibrary			  
cd $dsn
alog -work ovi_unisim $OPT -f $dsn/src/ovi_unisim.opt	
setlibrarymode -ro ovi_unisim



