#  File: update_altera.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library altera for Altera	Quartus
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O3
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw altera 
clearlibrary
acom -work altera $OPT $DSN\src\altera_primitives_components.vhd
acom -work altera $OPT $DSN\src\altera_primitives.vhd
acom -work altera $OPT $DSN\src\altera_europa_support_lib.vhd
setlibrarymode -ro altera
