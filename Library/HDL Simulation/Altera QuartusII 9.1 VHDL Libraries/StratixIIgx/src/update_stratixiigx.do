#  File: update_stratixiigx.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library stratixiigx for Altera
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O3
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw stratixiigx
clearlibrary
acom -work stratixiigx $OPT $DSN\src\stratixiigx_atoms.vhd
acom -work stratixiigx $OPT $DSN\src\stratixiigx_components.vhd
setlibrarymode -ro stratixiigx
