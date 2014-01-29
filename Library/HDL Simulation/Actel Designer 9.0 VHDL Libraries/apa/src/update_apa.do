#  File: update_apa.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library apa for Actel
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O3
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw apa 
clearlibrary
acom -work apa $OPT $DSN\src\apa.vhd
setlibrarymode -ro apa