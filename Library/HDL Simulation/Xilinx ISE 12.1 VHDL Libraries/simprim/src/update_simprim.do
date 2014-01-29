#  File: update_simprim.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library simprim for Xilinx
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

#set OPT -O3
#uncomment following line to compile with debug information
set OPT -dbg

setlibrarymode -rw simprim 
clearlibrary 
cd $dsn
acom -work simprim $OPT $dsn/src/simprim_vpackage.vhd 
acom -work simprim $OPT $dsn/src/simprim_vcomponents.vhd 
acom -o -work simprim $OPT -f ./src/secureip/secureip.opt 
acom -o -work simprim $OPT -f ./src/primitive/primitive.opt

setlibrarymode -ro simprim
