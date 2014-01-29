#  File: update_xp2.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library xp2 for Lattice
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O3
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw xp2
clearlibrary
acom -work xp2 $OPT $DSN\src\XP2COMP.vhd
acom -work xp2 $OPT $DSN\src\XP2_SEQ.vhd
acom -work xp2 $OPT $DSN\src\XP2_IO.vhd
acom -work xp2 $OPT $DSN\src\XP2_CMB.vhd
acom -work xp2 $OPT $DSN\src\XP2_CNT.vhd
acom -work xp2 $OPT $DSN\src\XP2_MEM.vhd
acom -work xp2 $OPT $DSN\src\XP2_MISC.vhd
acom -work xp2 $OPT $DSN\src\XP2_LUT.vhd
acom -work xp2 $OPT $DSN\src\XP2_MULT.vhd
acom -work xp2 $OPT $DSN\src\XP2_SL.vhd
#adel -lib xp2 jtage
#alog -v2k -work xp2 +define+RTL +define+UNIT_DELAY ./jtag/JTAGE.v.src
#adel -lib xp2 sspia
#alog -v2k -work xp2 +define+RTL +define+UNIT_DELAY +define+VHDLIB ./jtag/xp2_tag_mem/SSPIA.v.src 

setlibrarymode -ro xp2

