#  File: update_ovi_altera.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library ovi_altera for Altera
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O2
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw ovi_altera 
clearlibrary	  
cd $dsn
alog -work ovi_altera $OPT -f $dsn\src\ovi_altera.opt
setlibrarymode -ro ovi_altera
