#  File: update_cyclone.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library cyclone for Altera
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O3
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw cyclone
clearlibrary
acom -work cyclone $OPT $DSN\src\cyclone_atoms.vhd
acom -work cyclone $OPT $DSN\src\cyclone_components.vhd
setlibrarymode -ro cyclone
