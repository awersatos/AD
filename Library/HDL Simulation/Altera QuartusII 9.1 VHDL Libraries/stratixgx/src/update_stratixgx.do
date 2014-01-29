#  File: update_stratixgx.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library stratixgx for Altera
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O3
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw stratixgx
clearlibrary
acom -work stratixgx $OPT $DSN\src\stratixgx_atoms.vhd
acom -work stratixgx $OPT $DSN\src\stratixgx_components.vhd

setlibrarymode -ro stratixgx
