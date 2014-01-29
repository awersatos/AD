#  file: update_ovi_max.do
#    copyright (c) aldec inc.
#  file can be used to update library ovi_max for Altera
#  to update the library, perform the following steps:
#    1. update existing library source files
#    2. execute this macro file

set OPT -O2
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw ovi_max 
clearlibrary
cd $DSN
alog -work ovi_max $OPT -f $dsn\src\ovi_max.opt
setlibrarymode -ro ovi_max
