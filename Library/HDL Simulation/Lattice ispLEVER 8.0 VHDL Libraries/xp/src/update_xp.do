#  File: update_xp.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library xp for Lattice
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O3
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw xp 
clearlibrary  
acom -work xp $OPT $DSN\src\ORCACOMP.vhd
acom -work xp $OPT $DSN\src\ORCA_SEQ.vhd	
acom -work xp $OPT $DSN\src\ORCA_IO.vhd 
acom -work xp $OPT $DSN\src\ORCA_CMB.vhd
acom -work xp $OPT $DSN\src\ORCA_CNT.vhd		
acom -work xp $OPT $DSN\src\ORCA_MEM.vhd 
acom -work xp $OPT $DSN\src\ORCA_MISC.vhd  
acom -work xp $OPT $DSN\src\ORCA_LUT.vhd	 
#adel -lib xp jtagb
#alog -v2k -work xp +define+RTL +define+UNIT_DELAY ./jtag/JTAGB.v.src
setlibrarymode -ro xp


