#  File: update_lc4k.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library lc4k for Lattice
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O3
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw lc4k 
clearlibrary
acom -work lc4k $OPT $DSN\src\mach_components.vhd
acom -work lc4k $OPT $DSN\src\mach.vhd
setlibrarymode -ro lc4k
