#  File: update_lattice.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library lattice for Lattice
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O3
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw lattice 
clearlibrary
acom -work lattice $OPT $DSN\src\func.vhd
setlibrarymode -ro lattice
