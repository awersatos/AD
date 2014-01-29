#  file: update_ovi_sgate .do
#    copyright (c) aldec inc.
#  file can be used to update library ovi_sgate  for Altera
#  to update the library, perform the following steps:
#    1. update existing library source files
#    2. execute this macro file

set OPT -O2
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw ovi_sgate  
clearlibrary
cd $DSN
alog -work ovi_sgate $OPT -l ovi_lpm -f $dsn\src\ovi_sgate.opt
setlibrarymode -ro ovi_sgate 
