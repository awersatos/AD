#  File: update_alt_vtl.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library alt_vtl for Altera
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O3
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw alt_vtl
clearlibrary
acom -work alt_vtl $OPT $DSN\src\alt_vtl.vhd
acom -work alt_vtl $OPT $DSN\src\alt_vtl_cmp.vhd
setlibrarymode -ro alt_vtl
