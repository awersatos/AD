#  file: update_ovi_cycloneiii.do
#    copyright (c) aldec inc.
#  file can be used to update library ovi_cycloneiii for Altera
#  to update the library, perform the following steps:
#    1. update existing library source files
#    2. execute this macro file

set OPT -O2
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw ovi_cycloneiii 
clearlibrary
cd $DSN
alog -work ovi_cycloneiii -l ovi_altera $OPT -f $dsn\src\ovi_cycloneiii.opt
setlibrarymode -ro ovi_cycloneiii
