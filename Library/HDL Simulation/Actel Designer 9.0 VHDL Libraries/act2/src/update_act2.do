#  File: update_act2.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library act2 for Actel
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O3
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw act2 
clearlibrary
acom -work act2 $OPT $DSN\src\act2.vhd
setlibrarymode -ro act2
