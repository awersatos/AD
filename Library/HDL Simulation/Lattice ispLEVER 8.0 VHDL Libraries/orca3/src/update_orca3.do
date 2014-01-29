#  File: update_orca3.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library orca3 for Lattice
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O3
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw orca3 
clearlibrary
acom -work orca3 $OPT $DSN\src\orcacomp.vhd 
acom -work orca3 $OPT $DSN\src\orca_seq.vhd 
acom -work orca3 $OPT $DSN\src\orca_io.vhd 
acom -work orca3 $OPT $DSN\src\orca_mem.vhd 
acom -work orca3 $OPT $DSN\src\orca_mpi.vhd
acom -work orca3 $OPT $DSN\src\orca_cmb.vhd 
acom -work orca3 $OPT $DSN\src\orca_pcm.vhd 
acom -work orca3 $OPT $DSN\src\orca_cnt.vhd
setlibrarymode -ro orca3