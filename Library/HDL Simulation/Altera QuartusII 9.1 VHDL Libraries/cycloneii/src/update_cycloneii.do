#  File: update_cycloneii.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library cycloneii for Altera
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O3
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw cycloneii
clearlibrary
acom -work cycloneii $OPT $DSN\src\cycloneii_atoms.vhd
acom -work cycloneii $OPT $DSN\src\cycloneii_components.vhd
setlibrarymode -ro cycloneii
