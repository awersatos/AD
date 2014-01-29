#  file: update_ovi_maxII.do
#    copyright (c) aldec inc.
#  file can be used to update library ovi_maxII for Altera
#  to update the library, perform the following steps:
#    1. update existing library source files
#    2. execute this macro file

set OPT -O2
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw ovi_maxII 
clearlibrary
cd $DSN
alog -work ovi_maxII $OPT -f $dsn\src\ovi_maxII.v
setlibrarymode -ro ovi_maxII
