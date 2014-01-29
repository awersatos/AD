#  File: update_arriagx.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library arriagx for Altera
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O3
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw arriagx
clearlibrary
acom -work arriagx $OPT $DSN\src\arriagx_atoms.vhd
acom -work arriagx $OPT $DSN\src\arriagx_components.vhd

setlibrarymode -ro arriagx
