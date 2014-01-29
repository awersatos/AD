#  File: update_act1.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library act1 for Actel
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O3
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw act1 
clearlibrary
acom -work act1 $OPT $DSN\src\act1.vhd
setlibrarymode -ro act1