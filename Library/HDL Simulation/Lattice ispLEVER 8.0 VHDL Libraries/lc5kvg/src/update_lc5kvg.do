#  File: update_lc5kvg.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library lc5kvg for Lattice
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O3
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw lc5kvg 
clearlibrary
acom -work lc5kvg $OPT $DSN\src\lc5kvg_components.vhd
acom -work lc5kvg $OPT $DSN\src\lc5kvg.vhd
setlibrarymode -ro lc5kvg
