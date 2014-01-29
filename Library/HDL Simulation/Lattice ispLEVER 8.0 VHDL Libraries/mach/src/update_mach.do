#  File: update_mach.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library mach for Lattice
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O3
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw mach 
clearlibrary
acom -work mach $OPT $DSN\src\mach_components.vhd
acom -work mach $OPT $DSN\src\mach.vhd
setlibrarymode -ro mach
