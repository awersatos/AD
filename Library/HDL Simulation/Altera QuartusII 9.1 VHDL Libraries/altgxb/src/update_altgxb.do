#  File: update_altgxb.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library altgxb for Altera
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O3
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw altgxb
clearlibrary
acom -work altgxb $OPT $DSN\src\stratixgx_mf.vhd 
acom -work altgxb $OPT $DSN\src\stratixgx_mf_components.vhd 
setlibrarymode -ro altgxb
