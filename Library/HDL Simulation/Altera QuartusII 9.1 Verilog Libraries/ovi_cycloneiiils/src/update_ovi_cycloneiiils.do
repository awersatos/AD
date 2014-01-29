#  File: update_ovi_cycloneiiils.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library ovi_cycloneiiils for Altera
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O2
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw ovi_cycloneiiils 
clearlibrary	  
cd $dsn
alog -work ovi_cycloneiiils $OPT -f $dsn\src\ovi_cycloneiiils.opt
setlibrarymode -ro ovi_cycloneiiils
