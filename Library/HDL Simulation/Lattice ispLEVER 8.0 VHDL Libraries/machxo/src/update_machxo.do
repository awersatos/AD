#  File: update_machxo.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library machxo for Lattice
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O3
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw machxo 
clearlibrary  
acom -work machxo $OPT $DSN\src\MACHXOCOMP.vhd
acom -work machxo $OPT $DSN\src\MACHXO_SEQ.vhd
acom -work machxo $OPT $DSN\src\MACHXO_IO.vhd	 
acom -work machxo $OPT $DSN\src\MACHXO_MEM.vhd
acom -work machxo $OPT $DSN\src\MACHXO_CMB.vhd
acom -work machxo $OPT $DSN\src\MACHXO_CNT.vhd
acom -work machxo $OPT $DSN\src\MACHXO_MISC.vhd
acom -work machxo $OPT $DSN\src\MACHXO_LUT.vhd
#adel -lib machxo jtagd
#alog -v2k -work machxo +define+RTL +define+UNIT_DELAY ./jtag/JTAGD.v.src 
setlibrarymode -ro machxo


