#  File: update_ovi_altera_mf.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library ovi_altera_mf for Altera
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O2
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw ovi_altera_mf 
clearlibrary 
cd $dsn
alog -work ovi_altera_mf $OPT -f $DSN\src\ovi_altera_mf.opt
setlibrarymode -ro ovi_altera_mf
