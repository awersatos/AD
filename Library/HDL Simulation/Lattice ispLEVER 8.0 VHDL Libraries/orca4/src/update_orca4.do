#  File: update_orca4.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library orca4 for Lattice
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O3
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw orca4
clearlibrary
acom -work orca4 $OPT $dsn/src/orcacomp.vhd
acom -work orca4 $OPT $dsn/src/orca_seq.vhd
acom -work orca4 $OPT $dsn/src/orca_io.vhd
acom -work orca4 $OPT $dsn/src/orca_mem.vhd
acom -work orca4 $OPT $dsn/src/orca_cmb.vhd
acom -work orca4 $OPT $dsn/src/orca_cnt.vhd
acom -work orca4 $OPT $dsn/src/orca_pcm.vhd
acom -work orca4 $OPT $dsn/src/orca_mis.vhd
setlibrarymode -ro orca4