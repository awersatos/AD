#  File: update_a54sxa.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library a54sxa for Actel
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O3
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw a54sxa 
clearlibrary
acom -work a54sxa $OPT $DSN\src\54sxa.vhd
setlibrarymode -ro a54sxa
