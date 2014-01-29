#  File: update_iglooe.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library iglooe for Actel
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O3
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw iglooe 
clearlibrary
acom -work iglooe $OPT $DSN\src\iglooe.vhd
setlibrarymode -ro iglooe