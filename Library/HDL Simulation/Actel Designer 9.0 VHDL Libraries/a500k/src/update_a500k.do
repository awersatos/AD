#  File: update_a500k.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library a500k for Actel
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O3
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw a500k 
clearlibrary
acom -work a500k $OPT $DSN\src\a500k.vhd
setlibrarymode -ro a500k
