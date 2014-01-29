#  File: update_fusion.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library fusion for Actel
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O3
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw fusion 
clearlibrary
acom -work fusion $OPT $DSN\src\fusion.vhd
setlibrarymode -ro fusion