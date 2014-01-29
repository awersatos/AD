#  File: update_orca2.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library orca2 for Lattice
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O3
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw orca2 
clearlibrary
acom -work orca2 $OPT $DSN\src\orcacomp.vhd 
acom -work orca2 $OPT $DSN\src\orca_mem.vhd 
acom -work orca2 $OPT $DSN\src\orca_seq.vhd 
acom -work orca2 $OPT $DSN\src\orca_io.vhd 
acom -work orca2 $OPT $DSN\src\orca_cmb.vhd 
acom -work orca2 $OPT $DSN\src\orca_cnt.vhd 
acom -work orca2 $OPT $DSN\src\orca_reg.vhd 
setlibrarymode -ro orca2


