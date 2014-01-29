#  File: update_ovi_gdx2.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library ovi_gdx2 for Lattice
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file	

set OPT -O2
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw ovi_gdx2
clearlibrary
cd $DSN
alog -v95 -work ovi_gdx2 $OPT -f $dsn\src\ovi_gdx2.opt
setlibrarymode -ro ovi_gdx2

