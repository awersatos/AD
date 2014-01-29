#  File: update_ovi_arriaii.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library ovi_arriaii for Altera
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O2
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw ovi_arriaii 
clearlibrary	  
cd $dsn
alog -work ovi_arriaii $OPT -f $dsn\src\ovi_arriaii.opt
setlibrarymode -ro ovi_arriaii
