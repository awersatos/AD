#  File: update_arriagx_hssi.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library arriagx_hssi for Altera
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O3
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw arriagx_hssi
clearlibrary
acom -work arriagx_hssi $OPT $DSN\src\arriagx_hssi_components.vhd
acom -work arriagx_hssi $OPT $DSN\src\arriagx_hssi_atoms.vhd
setlibrarymode -ro arriagx_hssi
