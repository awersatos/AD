#  File: update_arriaii.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library arriaii for Altera
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O3
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw arriaii 
clearlibrary	  
cd $dsn
acom -work arriaii $OPT -f $dsn\src\arriaii.opt
setlibrarymode -ro arriaii
