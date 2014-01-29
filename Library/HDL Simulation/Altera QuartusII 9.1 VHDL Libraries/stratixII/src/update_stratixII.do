#  File: update_stratixII.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library stratixII for Altera
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O3
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw stratixII
clearlibrary
acom -work stratixII $OPT $DSN\src\stratixII_atoms.vhd
acom -work stratixII $OPT $DSN\src\stratixII_components.vhd
setlibrarymode -ro stratixII
