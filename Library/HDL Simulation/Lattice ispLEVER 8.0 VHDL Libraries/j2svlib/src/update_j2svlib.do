#  File: update_j2svlib.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library j2svlib for Lattice
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O3
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw j2svlib 
clearlibrary
acom -work j2svlib $OPT $DSN\src\j2svlib.vhd
setlibrarymode -ro j2svlib
