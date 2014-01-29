#  File: update_3200dx.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library 3200dx for Actel
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O3
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw a3200dx 
clearlibrary
acom -work a3200dx $OPT $DSN\src\3200dx.vhd
setlibrarymode -ro a3200dx
