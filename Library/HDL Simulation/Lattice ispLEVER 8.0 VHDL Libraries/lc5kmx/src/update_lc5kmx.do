#  File: update_lc5kmx.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library lc5kmx for Lattice
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O3
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw lc5kmx
clearlibrary
acom -work lc5kmx $OPT $DSN\src\lc5kmx_components.vhd
acom -work lc5kmx $OPT $DSN\src\lc5kmx.vhd
setlibrarymode -ro lc5kmx
