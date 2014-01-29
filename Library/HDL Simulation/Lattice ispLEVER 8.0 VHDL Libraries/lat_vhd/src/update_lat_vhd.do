#  File: update_lat_vhd.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library lat_vhd for Lattice
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O3
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw lat_vhd 
clearlibrary
acom -work lat_vhd $OPT $DSN\src\func.vhd
setlibrarymode -ro lat_vhd