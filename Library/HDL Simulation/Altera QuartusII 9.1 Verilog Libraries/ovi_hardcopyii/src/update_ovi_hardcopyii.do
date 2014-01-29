#  file: update_ovi_hardcopyii.do
#    copyright (c) aldec inc.
#  file can be used to update library ovi_hardcopyii for Altera
#  to update the library, perform the following steps:
#    1. update existing library source files
#    2. execute this macro file

set OPT -O2
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw ovi_hardcopyii
clearlibrary
alog -work ovi_hardcopyii $OPT -f $dsn\src\ovi_hardcopyii.opt
setlibrarymode -ro ovi_hardcopyii
