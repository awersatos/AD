#  File: update_neoprims.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library neoprims for Latice
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O3
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw neoprims 
clearlibrary
acom -work neoprims $OPT $DSN\src\neoprims.vhd 
acom -work neoprims $OPT $DSN\src\neo_comp.vhd
setlibrarymode -ro neoprims
