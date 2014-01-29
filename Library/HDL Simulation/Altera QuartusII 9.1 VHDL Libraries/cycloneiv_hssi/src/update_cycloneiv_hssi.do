#  File: update_cycloneiv_hssi.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library cycloneiv_hssi for Altera
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O3
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw cycloneiv_hssi
clearlibrary
acom -work cycloneiv_hssi $OPT $DSN\src\cycloneiv_hssi_components.vhd
acom -work cycloneiv_hssi $OPT $DSN\src\cycloneiv_hssi_atoms.vhd
setlibrarymode -ro cycloneiv_hssi
