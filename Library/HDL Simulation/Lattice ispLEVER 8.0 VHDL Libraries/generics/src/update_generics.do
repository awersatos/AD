#  File: update_generics.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library generics for Lattice
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O3
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw generics 
clearlibrary
acom -work generics $OPT $DSN\src\generics.vhd
setlibrarymode -ro generics
