#  File: update_ovi_arriagx_hssi.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library ovi_arriagx_hssi for Altera
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O3
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw ovi_arriagx_hssi
clearlibrary
alog -l ovi_sgate -work ovi_arriagx_hssi $OPT -f $DSN\src\ovi_arriagx_hssi.opt
setlibrarymode -ro ovi_arriagx_hssi
