#  File: update_lava1.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library lava1 for Lattice
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O3
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw lava1
clearlibrary
acom -work lava1 $OPT $DSN\src\xpga_components.vhd
acom -work lava1 $OPT $DSN\src\xpga.vhd
setlibrarymode -ro lava1
