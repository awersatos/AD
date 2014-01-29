#  file: update_ovi_stratixiigx_hssi.do
#    copyright (c) aldec inc.
#  file can be used to update library ovi_stratixiigx_hssi for Altera
#  to update the library, perform the following steps:
#    1. update existing library source files
#    2. execute this macro file

set OPT -O2
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw ovi_stratixiigx_hssi
clearlibrary
alog -l ovi_sgate -work ovi_stratixiigx_hssi $OPT -f $dsn\src\ovi_stratixiigx_hssi.opt
setlibrarymode -ro ovi_stratixiigx_hssi
