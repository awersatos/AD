#  File: update_xilinxcorelib.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library xilinxcorelib for Xilinx
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O3
#uncomment following line to compile with debug information
#set OPT -dbg
setlibrarymode -rw xilinxcorelib 
clearlibrary 
cd $dsn
acom -o -work xilinxcorelib $OPT -f ./src/xilinxcorelib.opt 
setlibrarymode -ro xilinxcorelib 
