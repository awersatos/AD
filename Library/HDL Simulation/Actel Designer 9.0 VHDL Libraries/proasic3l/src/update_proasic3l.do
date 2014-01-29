#  File: update_proasic3l.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library proasic3l for Actel
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O3
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw proasic3l 
clearlibrary
acom -work proasic3l $OPT $DSN\src\proasic3l.vhd
setlibrarymode -ro proasic3l