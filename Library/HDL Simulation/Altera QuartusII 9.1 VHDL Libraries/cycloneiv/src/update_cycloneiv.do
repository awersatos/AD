#  File: update_cycloneiv.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library cycloneiv for Altera
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O3
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw cycloneiv
clearlibrary
acom -work cycloneiv $OPT $DSN\src\cycloneiv_atoms.vhd
acom -work cycloneiv $OPT $DSN\src\cycloneiv_components.vhd
setlibrarymode -ro cycloneiv
