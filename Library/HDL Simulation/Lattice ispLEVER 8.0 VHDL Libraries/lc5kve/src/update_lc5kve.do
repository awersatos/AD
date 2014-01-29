#  File: update_lc5kve.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library lc5kve for Lattice
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O3
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw lc5kve 
clearlibrary
acom -work lc5kve $OPT $DSN\src\mach_components.vhd
acom -work lc5kve $OPT $DSN\src\mach.vhd
setlibrarymode -ro lc5kve
