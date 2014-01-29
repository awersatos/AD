#  File: update_sc.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library sc for Lattice
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O3
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw sc
clearlibrary
acom -work sc $OPT $dsn/src/orcacomp.vhd
acom -work sc $OPT $dsn/src/orca_seq.vhd
acom -work sc $OPT $dsn/src/orca_io.vhd
acom -work sc $OPT $dsn/src/orca_mem.vhd
acom -work sc $OPT $dsn/src/orca_cmb.vhd
acom -work sc $OPT $dsn/src/orca_cnt.vhd
acom -work sc $OPT $dsn/src/orca_mis.vhd
acom -work sc $OPT $dsn/src/orca_sl.vhd
#adel -lib sc jtaga
#alog -work sc +define+RTL +define+UNIT_DELAY +incdir+./jtag/jtaga_files -f rtl_jtaga.f ./jtag/JTAGA.v.src

setlibrarymode -ro sc