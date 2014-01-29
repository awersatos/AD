#  File: update_sgate.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library mercury for Altera
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O3
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw sgate
clearlibrary	
acom -work sgate $OPT $DSN\src\sgate_pack.vhd
acom -work sgate $OPT $DSN\src\sgate.vhd
setlibrarymode -ro sgate
