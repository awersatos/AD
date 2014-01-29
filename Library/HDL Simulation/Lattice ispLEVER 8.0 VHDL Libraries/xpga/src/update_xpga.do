#  File: update_xpga.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library xpga for Lattice
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O3
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw xpga
clearlibrary
acom -work xpga $OPT $DSN\src\xpga_components.vhd
acom -work xpga $OPT $DSN\src\xpga.vhd
setlibrarymode -ro xpga

