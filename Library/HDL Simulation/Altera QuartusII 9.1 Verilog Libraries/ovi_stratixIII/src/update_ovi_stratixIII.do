#  file: update_ovi_stratixIII.do
#    copyright (c) aldec inc.
#  file can be used to update library ovi_stratixIII for Altera
#  to update the library, perform the following steps:
#    1. update existing library source files
#    2. execute this macro file

set OPT -O2
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw ovi_stratixIII
clearlibrary
alog -l ovi_altera -work ovi_stratixIII $OPT -f $dsn\src\ovi_stratixIII.opt
setlibrarymode -ro ovi_stratixIII
