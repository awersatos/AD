#  file: update_ovi_cyclone.do
#    copyright (c) aldec inc.
#  file can be used to update library ovi_cyclone for altera
#  to update the library, perform the following steps:
#    1. update existing library source files
#    2. execute this macro file

set OPT -O2
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw ovi_cyclone 
clearlibrary
cd $DSN
alog -work ovi_cyclone $OPT -f $dsn\src\ovi_cyclone.opt
setlibrarymode -ro ovi_cyclone
