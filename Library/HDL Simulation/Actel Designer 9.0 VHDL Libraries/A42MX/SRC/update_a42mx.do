#  File: update_a42mx.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library a42mx for Actel
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O3
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw a42mx 
clearlibrary
acom -work a42mx $OPT $DSN\src\42mx.vhd
setlibrarymode -ro a42mx
