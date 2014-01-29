#  File: update_lc5kb.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library lc5kb for Lattice
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O3
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw lc5kb 
clearlibrary
acom -work lc5kb $OPT $DSN\src\mach_components.vhd
acom -work lc5kb $OPT $DSN\src\mach.vhd
setlibrarymode -ro lc5kb
