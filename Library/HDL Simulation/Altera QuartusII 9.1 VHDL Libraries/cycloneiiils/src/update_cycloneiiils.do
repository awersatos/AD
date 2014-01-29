#  File: update_cycloneiiils.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library cycloneiiils for Altera
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O3
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw cycloneiiils
clearlibrary	  
cd $dsn
acom -work cycloneiiils $OPT -f $dsn\src\cycloneiiils.opt
setlibrarymode -ro cycloneiiils
