#  File: update_a40mx.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library a40mx for Actel
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O3
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw a40mx 
clearlibrary
acom -work a40mx $OPT $DSN\src\40mx.vhd
setlibrarymode -ro a40mx
