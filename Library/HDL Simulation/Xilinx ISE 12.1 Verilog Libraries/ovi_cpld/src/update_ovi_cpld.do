#  File: update_ovi_cpld.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library ovi_cpld for Xilinx
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file			

set OPT -O2
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw ovi_cpld
clearlibrary			  
cd $dsn
alog -work ovi_cpld $OPT $dsn\src\cpld_det.v 
alog -work ovi_cpld $OPT $dsn\src\cpld_det_sim.v 
setlibrarymode -ro ovi_cpld



