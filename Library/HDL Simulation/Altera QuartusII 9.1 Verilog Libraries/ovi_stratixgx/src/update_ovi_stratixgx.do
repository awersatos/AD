#  file: update_ovi_stratixgx.do
#    copyright (c) aldec inc.
#  file can be used to update library ovi_stratixgx for Altera
#  to update the library, perform the following steps:
#    1. update existing library source files
#    2. execute this macro file

set OPT -O2
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw ovi_stratixgx
clearlibrary
alog -work ovi_stratixgx $OPT -f $dsn\src\ovi_stratixgx.opt
setlibrarymode -ro ovi_stratixgx
