#  File: update_ex.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library ex for Actel
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O3
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw ex 
clearlibrary
acom -work ex $OPT $DSN\src\ex.vhd
setlibrarymode -ro ex