#  File: update_ovi_cycloneiv.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library ovi_cycloneiv for Altera
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O2
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw ovi_cycloneiv 
clearlibrary	  
cd $dsn
alog -work ovi_cycloneiv $OPT -f $dsn\src\ovi_cycloneiv.opt
setlibrarymode -ro ovi_cycloneiv
