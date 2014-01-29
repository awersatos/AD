#  File: update_stratixIII.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library stratixIII for Altera
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O3
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw stratixIII
clearlibrary
acom -work stratixIII $OPT $DSN\src\stratixIII_atoms.vhd
acom -work stratixIII $OPT $DSN\src\stratixIII_components.vhd
setlibrarymode -ro stratixIII
