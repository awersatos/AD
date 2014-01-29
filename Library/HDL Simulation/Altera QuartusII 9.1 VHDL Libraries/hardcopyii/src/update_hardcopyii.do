#  File: update_hardcopyii.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library hardcopyii for Altera
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O3
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw hardcopyii
clearlibrary
acom -work hardcopyii $OPT $DSN\src\hardcopyii_atoms.vhd
acom -work hardcopyii $OPT $DSN\src\hardcopyii_components.vhd
setlibrarymode -ro hardcopyii
