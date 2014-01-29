#  File: update_gen_aux.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library gen_aux for Lattice
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O3
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw gen_aux 
clearlibrary
acom -work gen_aux $OPT $DSN\src\gen_aux.vhd
setlibrarymode -ro gen_aux
