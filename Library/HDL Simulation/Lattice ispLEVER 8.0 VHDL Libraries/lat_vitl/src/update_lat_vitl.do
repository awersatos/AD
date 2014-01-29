#  File: update_lat_vitl.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library lat_vitl for Lattice
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O3
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw lat_vitl 
clearlibrary
acom -work lat_vitl $OPT $DSN\src\vital.vhd
setlibrarymode -ro lat_vitl
