#  file: update_ovi_hardcopyiv.do
#    copyright (c) aldec inc.
#  file can be used to update library ovi_hardcopyiv for Altera
#  to update the library, perform the following steps:
#    1. update existing library source files
#    2. execute this macro file

set OPT -O2
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw ovi_hardcopyiv
clearlibrary
alog -work ovi_hardcopyiv $OPT -f $dsn\src\ovi_hardcopyiv.opt
setlibrarymode -ro ovi_hardcopyiv
