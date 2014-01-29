#  File: update_stratixiv_hssi.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library stratixiv_hssi for Altera
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O3
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw stratixiv_hssi
clearlibrary
acom -work stratixiv_hssi $OPT $DSN\src\stratixiv_hssi_components.vhd
acom -work stratixiv_hssi $OPT $DSN\src\stratixiv_hssi_atoms.vhd
setlibrarymode -ro stratixiv_hssi
