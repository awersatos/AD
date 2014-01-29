#  File: update_smartfusion.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library smartfusion for Actel
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O3
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw smartfusion 
clearlibrary
acom -work smartfusion $OPT $DSN\src\smartfusion.vhd
setlibrarymode -ro smartfusion