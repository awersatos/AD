#  File: update_stratixgx_gxb.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library stratixgx_gxb for Altera
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O3
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw stratixgx_gxb
clearlibrary
acom -work stratixgx_gxb $OPT $DSN\src\stratixgx_hssi_atoms.vhd
acom -work stratixgx_gxb $OPT $DSN\src\stratixgx_hssi_components.vhd
setlibrarymode -ro stratixgx_gxb
