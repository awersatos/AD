#  File: update_proasic3e.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library proasic3e for Actel
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O3
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw proasic3e 
clearlibrary
acom -work proasic3e $OPT $DSN\src\proasic3e.vhd
setlibrarymode -ro proasic3e