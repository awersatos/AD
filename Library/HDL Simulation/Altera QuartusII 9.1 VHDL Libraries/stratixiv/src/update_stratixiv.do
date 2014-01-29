#  File: update_stratixiv.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library stratixiv for Altera
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O3
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw stratixiv
clearlibrary
acom -work stratixiv $OPT $DSN\src\stratixiv_atoms.vhd
acom -work stratixiv $OPT $DSN\src\stratixiv_components.vhd
setlibrarymode -ro stratixiv
