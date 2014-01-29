#  File: update_unimacro.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library unimacro for Xilinx
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

#set OPT -O3
#uncomment following line to compile with debug information
set OPT -dbg

setlibrarymode -rw unimacro
clearlibrary
acom -o -work unimacro $OPT $dsn\src\unimacro_VCOMP.vhd 
acom -o -work unimacro $OPT $dsn\src\BRAM_SDP_MACRO.vhd
acom -o -work unimacro $OPT $dsn\src\BRAM_SINGLE_MACRO.vhd
acom -o -work unimacro $OPT $dsn\src\BRAM_TDP_MACRO.vhd
acom -o -work unimacro $OPT $dsn\src\FIFO_DUALCLOCK_MACRO.vhd
acom -o -work unimacro $OPT $dsn\src\FIFO_SYNC_MACRO.vhd
acom -o -work unimacro $OPT $dsn\src\ADDSUB_MACRO.vhd
acom -o -work unimacro $OPT $dsn\src\COUNTER_LOAD_MACRO.vhd
acom -o -work unimacro $OPT $dsn\src\COUNTER_TC_MACRO.vhd
acom -o -work unimacro $OPT $dsn\src\EQ_COMPARE_MACRO.vhd
acom -o -work unimacro $OPT $dsn\src\MACC_MACRO.vhd
acom -o -work unimacro $OPT $dsn\src\MULT_MACRO.vhd
acom -o -work unimacro $OPT $dsn\src\ADDMACC_MACRO.vhd

setlibrarymode -ro unimacro


