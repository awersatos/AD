#  File: update_a54sx.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library a54sx for Actel
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O3
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw a54sx 
clearlibrary
acom -work a54sx $OPT $DSN\src\54sx.vhd
setlibrarymode -ro a54sx
