#  file: update_ovi_altgxb.do
#    copyright (c) aldec inc.
#  file can be used to update library ovi_altgxb for Altera
#  to update the library, perform the following steps:
#    1. update existing library source files
#    2. execute this macro file

set OPT -O2
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw ovi_altgxb
clearlibrary
alog -work ovi_altgxb $OPT -l ovi_sgate $dsn\src\stratixgx_mf.v
setlibrarymode -ro ovi_altgxb
