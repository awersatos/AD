#  file: update_ovi_stratixgx_gxb.do
#    copyright (c) aldec inc.
#  file can be used to update library ovi_stratixgx_gxb for Altera
#  to update the library, perform the following steps:
#    1. update existing library source files
#    2. execute this macro file

set OPT -O2
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw ovi_stratixgx_gxb
clearlibrary
alog -work ovi_stratixgx_gxb $OPT -l ovi_sgate -f $dsn\src\ovi_stratixgx_hssi.opt
setlibrarymode -ro ovi_stratixgx_gxb
