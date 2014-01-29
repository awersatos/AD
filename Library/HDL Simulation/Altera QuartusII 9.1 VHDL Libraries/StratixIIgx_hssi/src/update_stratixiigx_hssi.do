#  File: update_stratixiigx_hssi.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library stratixiigx_hssi for Altera
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O3
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw stratixiigx_hssi
clearlibrary
acom -work stratixiigx_hssi $OPT $DSN\src\stratixiigx_hssi_components.vhd
acom -work stratixiigx_hssi $OPT $DSN\src\stratixiigx_hssi_atoms.vhd
setlibrarymode -ro stratixiigx_hssi
