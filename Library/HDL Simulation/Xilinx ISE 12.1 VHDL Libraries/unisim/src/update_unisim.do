#  File: update_unisim.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library unisim for Xilinx
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O3
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw unisim 
clearlibrary
cd $dsn
acom -work unisim $OPT $dsn/src/unisim_vpkg.vhd
acom -work unisim $OPT $dsn/src/unisim_vcomp.vhd 
acom -o -work unisim $OPT -f ./src/primitive/primitive.opt 
acom -o -work unisim $OPT -f ./src/secureip/secureip.opt    

setlibrarymode -ro unisim


