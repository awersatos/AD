#  File: update_ovi_lpm.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library ovi_lpm for Altera
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O2
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw ovi_lpm 
clearlibrary
alog -work ovi_lpm $OPT $DSN\src\220model.v
alog -work ovi_lpm $OPT $DSN\src\ALTERA_MF.V 
setlibrarymode -ro ovi_lpm
