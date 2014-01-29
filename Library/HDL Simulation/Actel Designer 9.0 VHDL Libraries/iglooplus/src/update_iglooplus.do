#  File: update_iglooplus.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library iglooplus for Actel
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O3
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw iglooplus 
clearlibrary
acom -work iglooplus $OPT $DSN\src\iglooplus.vhd
setlibrarymode -ro iglooplus