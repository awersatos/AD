#  File: update_cycloneiii.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library cycloneiii for Altera
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O3
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw cycloneiii
clearlibrary
acom -work cycloneiii $OPT $DSN\src\cycloneiii_atoms.vhd
acom -work cycloneiii $OPT $DSN\src\cycloneiii_components.vhd
setlibrarymode -ro cycloneiii
