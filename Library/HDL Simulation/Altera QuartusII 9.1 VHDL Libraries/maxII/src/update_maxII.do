#  File: update_maxII.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library maxII for Altera
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O3
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw maxII
clearlibrary
acom -work maxII $OPT $DSN\src\maxII_atoms.vhd
acom -work maxII $OPT $DSN\src\maxII_components.vhd
setlibrarymode -ro maxII
