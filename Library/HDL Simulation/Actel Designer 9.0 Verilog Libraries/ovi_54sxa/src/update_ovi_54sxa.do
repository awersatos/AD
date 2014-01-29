#  File: update_ovi_54sxa.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library ovi_54sxa for  Actel
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file	


set OPT -O2
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw ovi_54sxa
clearlibrary
cd $DSN
alog -v2k -work ovi_54sxa $OPT -f $dsn\src\ovi_54sxa.opt
setlibrarymode -ro ovi_54sxa

