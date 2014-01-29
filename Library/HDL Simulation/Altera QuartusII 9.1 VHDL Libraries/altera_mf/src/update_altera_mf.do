#  File: update_altera_mf.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library altera_mf for Altera Quartus
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O3
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw altera_mf 
clearlibrary
acom -work altera_mf $OPT $DSN\src\altera_mf_components.vhd
acom -work altera_mf $OPT $DSN\src\altera_mf.vhd	  
setlibrarymode -ro altera_mf
