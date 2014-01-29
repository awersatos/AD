#  File: update_cpld.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library cpld for Xilinx
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O3
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw cpld 
clearlibrary
acom -work cpld $OPT $DSN\src\cpld_det.vhd  
acom -work cpld $OPT $DSN\src\cpld_det_sim.vhd  
setlibrarymode -ro cpld


