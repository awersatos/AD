#  File: update_arriaii_hssi.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library arriaii_hssi for Altera
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O3
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw arriaii_hssi 
clearlibrary	  
cd $dsn
acom -work arriaii_hssi $OPT -f $dsn\src\arriaii_hssi.opt
setlibrarymode -ro arriaii_hssi
